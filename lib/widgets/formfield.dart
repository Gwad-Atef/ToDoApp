import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:task/stateshome/cuibthome.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

Widget defaultFormField({
  @required TextEditingController controller,
  @required String lable,
  Function onChange,
  Function onSubimmt,
  Function onTap,
  @required TextInputType type,
  @required IconData perfix,
  IconData suffix,
  // double radius = 5.0,
  bool ispassword = false,
  Function validate,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validate,
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubimmt,
      keyboardType: type,
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          perfix,
        ),
        suffixIcon: Icon(suffix),
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        CubitHome.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                icon: Icon(
                  Icons.done,
                  color: Colors.blue,
                ),
                onPressed: () {
                  print('Done pressed');
                  CubitHome.get(context)
                      .updateData(status: 'done', id: model['id']);
                }),
            IconButton(
                icon: Icon(
                  Icons.archive,
                  color: Colors.grey,
                ),
                onPressed: () {
                  CubitHome.get(context)
                      .updateData(status: 'archived', id: model['id']);
                }),
          ],
        ),
      ),
    );

Widget tasksBuild({@required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.length > 0,
      fallback: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet , Please Enter Some Tasks',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      builder: (context) => ListView.separated(
          itemBuilder: (context, i) => buildTaskItem(tasks[i], context),
          separatorBuilder: (context, i) => Container(
                height: 1.0,
                color: Colors.grey,
              ),
          itemCount: tasks.length),
    );
