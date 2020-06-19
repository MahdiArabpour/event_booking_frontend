import 'package:event_booking/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

import '../../../../usecases/logout.dart';
import '../bloc/post_event_bloc/bloc.dart';
import '../../../../data/models/event.dart';
import '../../../../../core/utils/ui/validator.dart';
import '../../../../../core/utils/ui/ui_messages.dart';

class ModalBottomSheetBody extends StatefulWidget {
  final String token;

  const ModalBottomSheetBody({Key key, this.token}) : super(key: key);

  @override
  _ModalBottomSheetBodyState createState() => _ModalBottomSheetBodyState();
}

class _ModalBottomSheetBodyState extends State<ModalBottomSheetBody> {
  DateTime _selectedDate;

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;

  Validator _validator;

  PostEventBloc _bloc;

  Toast _toast;

  @override
  initState() {
    super.initState();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();

    _validator = locator<Validator>();

    _toast = locator<Toast>();
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
    String errorMessage = await _validator.validateEventInputs(
      title: _titleController.text,
      description: _descriptionController.text,
      price: _priceController.text,
    );
    if (errorMessage == null && _selectedDate == null)
      errorMessage = 'Please choose a date';
    if (errorMessage != null) {
      return _toast.show(errorMessage, color: Colors.red, gravity: Gravity.TOP);
    }

    _bloc.add(
      PostEvent(
        event: Event(
          (b) => b
            ..title = _titleController.text
            ..description = _descriptionController.text
            ..price = double.parse(_priceController.text)
            ..date = _selectedDate,
        ),
        token: widget.token,
      ),
    );
  }

  Widget _buildAddButton() => BlocConsumer<PostEventBloc, PostEventState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is EventAdded) {
            Navigator.of(context).pop();
            _toast.show("Event added successfully", gravity: Gravity.TOP);
          } else if (state is AuthenticationFailed) {
            Navigator.of(context).pop();
            _toast.show('Please login again',
                color: Colors.red[300], gravity: Gravity.TOP);
            final logout = locator<Logout>();
            logout(context);
          } else if (state is NoInternet) {
            _toast.show('Check your internet connection',
                color: Colors.red, gravity: Gravity.TOP);
          } else if (state is UnknownError) {
            _toast.show('An unknown error occured',
                color: Colors.red, gravity: Gravity.TOP);
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
      );

  @override
  Widget build(BuildContext context) {
    _bloc = context.bloc<PostEventBloc>();
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
              controller: _titleController,
              focusNode: _titleFocus,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                _titleFocus.unfocus();
                _descriptionFocus.requestFocus();
              },
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: _descriptionController,
              focusNode: _descriptionFocus,
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
              controller: _priceController,
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
                _buildAddButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
