import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/stateshome/cuibthome.dart';
import 'package:task/stateshome/homestates.dart';
import 'package:task/widgets/formfield.dart';

class Archived extends StatelessWidget {
  // const Archived({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<CubitHome, CubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = CubitHome.get(context).archived;
        return tasksBuild(tasks: tasks);
      },
    );

  }
}
