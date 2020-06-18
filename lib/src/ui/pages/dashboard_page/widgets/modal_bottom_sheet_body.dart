import 'package:event_booking/core/utils/ui/ui_messages.dart';
import 'package:event_booking/core/utils/ui/validator.dart';
import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/data/models/event.dart';
import 'package:event_booking/src/ui/global/providers/token_provider.dart';
import 'package:event_booking/src/ui/pages/auth_page/auth_page.dart';
import 'package:event_booking/src/ui/pages/dashboard_page/bloc/post_event_bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ModalBottomSheetBody extends StatefulWidget {
  final String token;

  const ModalBottomSheetBody({Key key, this.token}) : super(key: key);

  @override
  _ModalBottomSheetBodyState createState() => _ModalBottomSheetBodyState();
}

class _ModalBottomSheetBodyState extends State<ModalBottomSheetBody> {
  DateTime _selectedDate;

  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController priceController;

  FocusNode titleFocus;
  FocusNode descriptionFocus;

  Validator validator;

  PostEventBloc bloc;

  Toast toast;

  @override
  initState() {
    super.initState();

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();

    titleFocus = FocusNode();
    descriptionFocus = FocusNode();

    validator = locator<Validator>();

    toast = Toast(gravity: Gravity.TOP);
  }

  _onChooseDateButtonPressed(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    setState(() => _selectedDate = pickedDate);
  }

  void _onTodayTextTapped() => setState(() => _selectedDate = DateTime.now());

  void _onAddButtonPressed() async {
    String errorMessage = await validator.validateEventInputs(
      title: titleController.text,
      description: descriptionController.text,
      price: priceController.text,
    );
    if (errorMessage == null && _selectedDate == null)
      errorMessage = 'Please choose a date';
    if (errorMessage != null) {
      return toast.show(errorMessage, color: Colors.red);
    }

    bloc.add(
      PostEvent(
        event: Event(
          (b) => b
            ..title = titleController.text
            ..description = descriptionController.text
            ..price = double.parse(priceController.text)
            ..date = _selectedDate,
        ),
        token: widget.token,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.bloc<PostEventBloc>();
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
            TextField(
              controller: titleController,
              focusNode: titleFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                titleFocus.unfocus();
                descriptionFocus.requestFocus();
              },
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: descriptionController,
              focusNode: descriptionFocus,
              minLines: 3,
              maxLines: 5,
              maxLength: 1850,
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: priceController,
              textInputAction: TextInputAction.done,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Today',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTodayTextTapped,
                        ),
                      ),
                    ],
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
                BlocConsumer<PostEventBloc, PostEventState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is EventAdded){
                      Navigator.of(context).pop();
                      toast.show("Event added successfully");
                    }
                    else if (state is AuthenticationFailed){
                      Navigator.of(context).pop();
                      toast.show('Please login again', color: Colors.red[300]);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => AuthPage(),
                      ));
                    }
                    else if (state is NoInternet){
                      toast.show('Check your internet connection');
                    }
                    else if (state is UnknownError){
                      toast.show('An unknown error occured');
                    }
                  },
                  builder: (_, state) {
                    final isLoading = state is Loading;
                    return RaisedButton(
                      onPressed: isLoading ? null : _onAddButtonPressed,
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: isLoading
                              ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : const Text('Add'),
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
