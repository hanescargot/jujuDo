import 'package:dektodo/const.dart';
import 'package:dektodo/screen/alert/alert_show_edit.dart';
import 'package:dektodo/screen/todo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget slidItem(String createdTime, int idx, data) =>
    Builder(builder: (context) {
      void onDeleteBtnClicked(String doc) {
        xianFirebaseController.deleteTodo(doc);
      }

      void onEditBtnClicked(String doc) {
        alertShowEdit(context, createdTime, idx, data);
      }

      return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (context) {
                onDeleteBtnClicked(createdTime);
              },
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFFFF6E6E),
              icon: Icons.delete_forever_sharp,
              label: 'Delete',
            ),
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (context) {
                onEditBtnClicked(createdTime);
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black54,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: todoListItem(createdTime, idx, data),
      );
    });
