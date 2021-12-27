import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:equatable/equatable.dart';

part 'activeuser_event.dart';
part 'activeuser_state.dart';

class ActiveuserBloc extends Bloc<ActiveuserEvent, ActiveuserState> {
  ActiveuserBloc() : super(ActiveuserInitialState()) {
    on<ActiveuserLoadEvent>((event, emit) {
    });
    on<ActiveuserClickEvent>((event, emit) {
      // TODO: implement event handler
    });

  }
}
