import 'package:charityapp/domain/repositories/can_crud_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class CRUDableRepositoryImp implements CRUDableRepository<JsonSerializable> {
  CollectionReference collection;

  CRUDableRepositoryImp({required this.collection});

  @override
  Future<void> add(JsonSerializable entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<JsonSerializable>> load(String rootId, int startIndex, int number) {
    // TODO: implement load
    // var user = await collection.doc(id).get();
    // var json = user.data() as Map<String,dynamic>;

    throw UnimplementedError();
  }

  @override
  Future<void> update(JsonSerializable id) {
    // TODO: implement update
    throw UnimplementedError();
  }

}