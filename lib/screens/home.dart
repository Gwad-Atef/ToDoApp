import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/stateshome/cuibthome.dart';
import 'package:task/stateshome/homestates.dart';
import 'package:task/widgets/formfield.dart';

class HomePage extends StatelessWidget {
  // const HomePage({ Key? key }) : super(key: key);

  var formkey = GlobalKey<FormState>();
  var scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  // void initState() {
  //   createDataBase();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitHome()..createDataBase(),
      child: BlocConsumer<CubitHome, CubitStates>(listener: (context, state) {
        if (state is AppInsertDatabase) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        CubitHome cubit = CubitHome.get(context);

        return Scaffold(
          body: ConditionalBuilder(
            builder: (context) => cubit.screens[cubit.currentIndex],
            condition: state is! AppGetDatabaseLoadingState,
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          key: scafoldKey,
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isbottomSheetShown) {
                if (formkey.currentState.validate()) {
                  cubit.insertToDataBase(
                      title: titlecontroller.text,
                      date: datecontroller.text,
                      time: timecontroller.text);
                  // insertToDataBase(
                  //   date: datecontroller.text,
                  //   time: timecontroller.text,
                  //   title: titlecontroller.text,
                  // ).then((value) {
                  //   getDataFromDataBase(database).then((value) {
                  //     tasks = value;
                  //     Navigator.pop(context);
                  //     isbottomSheetShown = false;

                  //     print(tasks);
                  //   });
                  // });
                }
              } else {
                scafoldKey.currentState
                    .showBottomSheet(
                        (context) => Container(
                              padding: EdgeInsets.all(15.0),
                              color: Colors.white,
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Title can\'t be Empty';
                                          }
                                        },
                                        controller: titlecontroller,
                                        lable: 'Enter Title',
                                        type: TextInputType.name,
                                        perfix: Icons.title),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Date can\'t be Empty';
                                          }
                                        },
                                        controller: datecontroller,
                                        lable: 'Date',
                                        type: TextInputType.phone,
                                        perfix: Icons.calendar_today,
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2015),
                                                  lastDate: DateTime(2050))
                                              .then((value) =>
                                                  datecontroller.text =
                                                      DateFormat.yMMMEd()
                                                          .format(value));
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defaultFormField(
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Time can\'t be Empty';
                                          }
                                        },
                                        controller: timecontroller,
                                        lable: 'Time',
                                        type: TextInputType.datetime,
                                        perfix: Icons.watch_later_outlined,
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) => timecontroller
                                              .text = value.format(context));
                                        })
                                  ],
                                ),
                              ),
                            ),
                        elevation: 20.0)
                    .closed
                    .then((value) {
                  // Navigator.pop(context);
                  // isbottomSheetShown = false;
                  cubit.changeBottomSheet(isShown: false, icon: Icons.edit);
                });
                cubit.changeBottomSheet(isShown: true, icon: Icons.add);
              }
            },
            child: Icon(cubit.fabIcon),
          ),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text(
              cubit.title[cubit.currentIndex],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 20.0,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Task'),
              BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'Archived'),
            ],
          ),
        );
      }),
    );
  }
}
