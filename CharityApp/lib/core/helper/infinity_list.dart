import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'infinity_list.g.dart';

enum InfinityListStatus { initial, success, failure }

@CopyWith()
class InfinityList<T> extends Equatable {
  bool _isFull;
  bool _isLoading = false;
  InfinityListStatus _status;
  final List<T> items;

  bool get isFull => _isFull;
  bool get isLoading => _isLoading;
  InfinityListStatus get status => _status;

  InfinityList(
      {this.items = const [],
      bool isFull = false,
      InfinityListStatus status = InfinityListStatus.initial})
      : this._isFull = isFull,
        this._status = status;

  Future<List<T>> load(Future<List<T>> getItems) async {
    //If full, don't load
    if (!isFull) {

      _isLoading = true;

      try {
        var newItems = await getItems;

        //If have no item, set to full;
        if (newItems.isEmpty) _isFull = true;
        _status = InfinityListStatus.success;

        items.addAll(newItems);
      } on Exception catch (e) {
        _status = InfinityListStatus.failure;
        print(e.toString());
      }

      _isLoading = false;
    }

    return items;
  }

  void setNotFull() {
    _isFull = false;
  }

  @override
  List<Object?> get props => [items, status, isFull, isLoading];
}
