import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/domain/repositories/tag_event_repository.dart';
import 'package:charityapp/repositories/tag_event_repository_imp.dart';

class TagCubit extends Cubit<List<TagEvent>?> {
  ITagEventRepository tagRepository = TagEventRepositoryImp();

  TagCubit() : super([]);

  Future<void> load() async {
    emit(null);
    final tags = await tagRepository.loadTags();
    emit(tags);
  }

  Future<void> loadFrom(String eventId) async {
    emit(null);
    final tags = await tagRepository.loadFrom(eventId);
    emit(tags);
  }
}
