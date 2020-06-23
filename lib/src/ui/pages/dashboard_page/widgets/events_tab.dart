import 'package:event_booking/src/ui/global/providers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:event_booking/core/utils/ui/ui_messages.dart';
import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/data/models/event.dart';
import 'package:event_booking/src/ui/pages/dashboard_page/bloc/book_event_bloc/bloc.dart'
    as b;
import 'package:event_booking/src/ui/pages/dashboard_page/bloc/get_events_bloc/bloc.dart'
    as g;
import 'package:event_booking/src/ui/pages/dashboard_page/widgets/event_item.dart';
import 'package:provider/provider.dart';

class EventsTab extends StatefulWidget {
  @override
  _EventsTabState createState() => _EventsTabState();
}

Widget _loadedEvents;

class _EventsTabState extends State<EventsTab> {
  final toast = locator<Toast>();
  g.GetEventsBloc getEventsBloc;
  String token;

  @override
  initState() {
    super.initState();
  }


  Widget _buildEventItem(Event event) {
    b.BookEventBloc bookEventBloc = locator<b.BookEventBloc>();
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.2,
      child: EventItem(event: event),
      actions: <Widget>[
        BlocConsumer(
          bloc: bookEventBloc,
          listener: (context, state) {
            if (state is b.Booked)
              toast.show(
                'Booked successfully',
                gravity: Gravity.TOP,
              );
            else if (state is b.NoInternet)
              toast.show(
                'Please check your internet connection',
                color: Colors.red,
                gravity: Gravity.TOP,
              );
            else if (state is b.UnknownError)
              toast.show(
                'An unknown error occurred',
                color: Colors.red,
                gravity: Gravity.TOP,
              );
            else if (state is b.AuthenticationFailed) {
              toast.show(
                'Please login again',
                color: Colors.red[300],
                gravity: Gravity.TOP,
              );
            }
          },
          builder: (context, state) {
            return (state is b.Loading)
                ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                )
                : IconSlideAction(
                    caption: 'Book',
                    color: Colors.transparent,
                    icon: Icons.bookmark_border,
                    foregroundColor:
                        Theme.of(context).textTheme.subtitle1.color,
                    closeOnTap: false,
                    onTap: () => bookEventBloc.add(b.BookEvent(eventId: event.id, token: token)),
                  );
          },
        ),
      ],
    );
  }

  Widget _onEventsLoaded(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => events
          .map((event) => _buildEventItem(event))
          .toList()
          .elementAt(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    getEventsBloc = BlocProvider.of<g.GetEventsBloc>(context);
    token = Provider.of<TokenProvider>(context).token;
    if (_loadedEvents == null) getEventsBloc.add(g.GetEvents());
    return BlocConsumer(
      bloc: getEventsBloc,
      listener: (context, state) {
        if (state is g.NoInternet) {
          toast.show('Please check your internet connection',
              color: Colors.red);
        } else if (state is g.UnknownError) {
          toast.show('An unknown error occured', color: Colors.red);
        }
      },
      buildWhen: (preState, state) => preState is g.Loading,
      builder: (context, state) {
        if (state is g.Loaded) {
          _loadedEvents = _onEventsLoaded(state.events);
          return _loadedEvents;
        } else if (state is g.NoInternet && _loadedEvents != null)
          return _loadedEvents;
        else if (state is g.NoInternet || state is g.UnknownError)
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
