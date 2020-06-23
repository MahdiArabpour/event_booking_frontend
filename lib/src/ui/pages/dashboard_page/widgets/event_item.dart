import 'package:event_booking/src/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class EventItem extends StatefulWidget {
  final Event event;

  const EventItem({Key key, @required this.event}) : super(key: key);

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key(widget.event.id),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ExpansionTile(
            backgroundColor: Theme.of(context).backgroundColor,
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Theme.of(context).accentColor,
              child: Text(
                widget.event.price.toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.event.title),
                Text(
                  DateFormat.yMMMd().format(widget.event.date),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1.color,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            subtitle: Text(widget.event.creator.email),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 8.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.event.description),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
