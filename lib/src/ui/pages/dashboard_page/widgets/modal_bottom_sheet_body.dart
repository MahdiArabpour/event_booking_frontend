import 'package:flutter/material.dart';

class ModalBottomSheetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          top: 25.0,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add a new event",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                labelText: "Price",
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Add'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
