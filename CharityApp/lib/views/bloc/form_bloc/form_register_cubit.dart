import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/repositories/form_repository_imp.dart';
import 'package:equatable/equatable.dart';

class FormRegisterCubit extends Cubit<List<UserOverview>?> {
  IFormRepository formRepository = FormRepositoryImp();
  FormRegisterCubit() : super([]);

  Future<void> loadPaticipants(String eventId) async {
    try {
      emit(null);
      final users = await formRepository.loadPaticipantsOf(eventId);
      emit(users);
    } catch (e) {
      emit([]);
    }
  }

  Future<void> loadRegisters(String eventId) async {
    try {
      emit(null);
      final users = await formRepository.loadRegisterOf(eventId);
      emit(users);
    } catch (e) {
      emit([]);
    }
  }

  void reset() {
    emit(null);
  }
}
