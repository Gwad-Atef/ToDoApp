import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/counter/cuibt.dart';
import 'package:task/counter/states.dart';

class Counter extends StatelessWidget {
  // const Counter({ Key? key }) : super(key: key);
  // int counter = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if(state is CounterMiunsState) {
            print('Miuns State ${state.counter}');
          }
           if(state is CounterPlusState) {
            print('Miuns State ${state.counter}');
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Counter '),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).miuns();
                      },
                      child: Text('MINUS')),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).puls();
                      },
                      child: Text('PLUS')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
