import 'package:bloc/bloc.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';


class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormLoadInProccess()) {
    on<FormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
