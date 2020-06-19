import 'package:event_booking/core/utils/ui/ui_messages.dart';
import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/data/models/event.dart';
import 'package:event_booking/src/ui/pages/dashboard_page/bloc/get_events_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsTab extends StatefulWidget {
  @override
  _EventsTabState createState() => _EventsTabState();
}

Widget _loadedEvents;

class _EventsTabState extends State<EventsTab> {
  final toast = locator<Toast>();
  GetEventsBloc bloc;

  @override
  initState() {
    super.initState();
  }

  Widget _buildEventsItem(Event event) => Padding(
        key: Key(event.id),
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
                  event.price.toStringAsFixed(2),
                ),
              ),
              title: Text(event.title),
              subtitle: Text(event.creator.email),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 8.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(event.description),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _onEventsLoaded(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => events
          .map((event) => _buildEventsItem(event))
          .toList()
          .elementAt(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<GetEventsBloc>(context);
    if (_loadedEvents == null) bloc.add(GetEvents());
    return BlocConsumer(
      bloc: bloc,
      listener: (context, state) {
        if (state is NoInternet) {
          toast.show('Please check your internet connection',
              color: Colors.red);
        } else if (state is UnknownError) {
          toast.show('An unknown error occured', color: Colors.red);
        }
      },
      buildWhen: (preState, state) => preState is Loading,
      builder: (context, state) {
        if (state is Loaded) {
          _loadedEvents = _onEventsLoaded(state.events);
          return _loadedEvents;
        } else if (state is NoInternet && _loadedEvents != null)
          return _loadedEvents;
        else if (state is NoInternet || state is UnknownError)
          return Center(
            child: Text('Nothing to show'),
          );
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}
