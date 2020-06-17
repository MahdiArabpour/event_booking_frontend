import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModalBottomSheetBody extends StatefulWidget {
  @override
  _ModalBottomSheetBodyState createState() => _ModalBottomSheetBodyState();
}

class _ModalBottomSheetBodyState extends State<ModalBottomSheetBody> {
  DateTime _selectedDate;

  _onChooseDateButtonPressed(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    setState(() => _selectedDate = pickedDate);
  }

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
            const Text(
              "Add a new event",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                labelText: "Price",
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () => _onChooseDateButtonPressed(context),
                    child: const Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: const Text('Add'),
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
