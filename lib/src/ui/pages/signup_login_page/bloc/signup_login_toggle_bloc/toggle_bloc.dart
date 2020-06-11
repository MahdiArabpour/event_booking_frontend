import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  @override
  ToggleState get initialState => ToggleLoginState();

  @override
  Stream<ToggleState> mapEventToState(ToggleEvent event) async* {
    switch (event.runtimeType) {
      case ToggleLoginEvent:
        yield ToggleLoginState();
        break;
      case ToggleSignUpEvent:
        yield ToggleSignUpState();
        break;
    }
  }
}
