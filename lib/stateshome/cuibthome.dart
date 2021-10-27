import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'package:task/screens/archivedtask.dart';
import 'package:task/screens/donetasks.dart';
import 'package:task/screens/newtask.dart';
import 'package:task/stateshome/homestates.dart';

class CubitHome extends Cubit<CubitStates> {
  CubitHome() : super(HomeInitialState());

  static CubitHome get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  Database database;
  List<Map> newTask = [];
  List<Map> doneTasks = [];
  List<Map> archived = [];

  List<Widget> screens = [
    NewTask(),
    DoneTask(),
    Archived(),
  ];
  List<String> title = [
    'NewTask',
    'done',
    'ArchivedTask',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavBar());
  }

  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('DataBase Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT , date TEXT, time TEXT , status TEXT)')
          .then((value) {
        print('Data Base Created Sucess');
      });
    }, onOpen: (database) {
      print(' DataBases opend sucess');
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertToDataBase(
      {@required String title,
      @required String date,
      @required String time}) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title , date , time , status) VALUES ("$title" , "$date" , "$time" , "new")')
          .then((value) {
        print('$value inserted Sucssefull');
        emit(AppInsertDatabase());

        getDataFromDataBase(database);
      }).catchError((error) {
        print('ERROR WHEN Inserting Data ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDataBase(database) async {
    newTask = [];
    doneTasks = [];
    archived = [];
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTask.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archived.add(element);
      });
      emit(AppGetDatabase());
    });
  }

  void updateData({
    @required String status,
    @required int id,
  }) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['updated $status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({
    @required int id,
  }) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  IconData fabIcon = Icons.edit;
  bool isbottomSheetShown = false;

  void changeBottomSheet({@required bool isShown, @required IconData icon}) {
    isbottomSheetShown = isShown;
    fabIcon = icon;
    emit(HomeChangeBottomSheetState());
  }
}
