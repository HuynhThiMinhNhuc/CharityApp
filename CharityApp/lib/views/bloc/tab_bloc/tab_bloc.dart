import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/core/model/app_tab.dart';
import './tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.home) {
    on<UpdateTab>(_onUpdateTab);
  }

  FutureOr<void> _onUpdateTab(UpdateTab event, Emitter<AppTab> emit) {
    emit(event.newActiveTab);
  }
}
