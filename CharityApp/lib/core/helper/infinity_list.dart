import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'infinity_list.g.dart';

enum InfinityListStatus { initial, success, failure }

class InfinityList<T> extends StatefulWidget {
  const InfinityList({
    Key? key,
    required this.itemUI,
    required this.fetchMethod,
    required this.items,
  }) : super(key: key);

  final Widget Function(int index) itemUI;
  final Function fetchMethod;
  final List<T> items;

  @override
  State<InfinityList> createState() => _InfinityListState();
}

class _InfinityListState extends State<InfinityList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) widget.fetchMethod;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentOffset = _scrollController.offset;
    return currentOffset >= maxScroll * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;

    if (widget.items.isEmpty) {
      return const Text('No items');
    }
    return ListView.builder(
      itemBuilder: (context, index) => widget.itemUI(index),
      // shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // physics: NeverScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: items.length,
    );
  }
}

// class BottomLoader extends StatelessWidget {
//   const BottomLoader({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: SizedBox(
//         height: 24,
//         width: 24,
//         child: CircularProgressIndicator(strokeWidth: 1.5),
//       ),
//     );
//   }
// }

@CopyWith()
class InfinityListController<T> extends Equatable {
  bool _isFull = false;
  // bool _isLoading = false;
  InfinityListStatus _status;
  List<T> items;

  bool get isFull => _isFull;
  // bool get isLoading => _isLoading;
  InfinityListStatus get status => _status;

  InfinityListController({
    required this.items,
    InfinityListStatus status = InfinityListStatus.initial,
  }) : this._status = status;

  Future<List<T>> load(Future<List<T>> getItems) async {
    //If full, don't load
    if (!isFull) {
      // _isLoading = true;

      try {
        var newItems = await getItems;

        //If have no new item, set to full;
        if (newItems.isEmpty) _isFull = true;
        _status = InfinityListStatus.success;

        items.addAll(newItems);
      } on Exception catch (e) {
        _status = InfinityListStatus.failure;
        print(e.toString());
      }
      // _isLoading = false;
    }

    return items;
  }

  void setNotFull() {
    _isFull = false;
  }

  @override
  List<Object?> get props => [items, status];
}
