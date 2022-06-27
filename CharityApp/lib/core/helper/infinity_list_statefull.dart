import 'package:flutter/material.dart';

class InfinityListStateFull<T> extends StatefulWidget {
  final Widget Function(int index) child;
  final Widget? childOnLoad;
  final List<T>? initItems;
  final Future<List<T>> Function(List<T>)? fetchItemsOnTop;
  final Future<List<T>> Function(List<T>)? fetchItemsOnBottom;
  final bool Function(List<T>)? allowFetch;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool reverseList;

  const InfinityListStateFull({
    Key? key,
    required this.child,
    this.childOnLoad,
    this.initItems,
    this.fetchItemsOnTop,
    this.fetchItemsOnBottom,
    this.allowFetch,
    this.physics,
    this.shrinkWrap = false,
    this.reverseList = false,
  }) : super(key: key);

  @override
  State<InfinityListStateFull<T>> createState() => _InfinityListStateFullState<T>();
}

class _InfinityListStateFullState<T> extends State<InfinityListStateFull<T>> {
  late final ScrollController _scrollController;
  late final List<T> items;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    items = widget.initItems ?? [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onFetchItems() {
    _scrollController.addListener(() async {
      // Check is loading
      if (isLoading || !(widget.allowFetch?.call(items) ?? true)) {
        print('List is loading, can not load more');
        return;
      }

      setState(() {
        isLoading = true;
      });

      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Load on bottom
        final newItems = await widget.fetchItemsOnBottom?.call(items) ?? [];
        setState(() {
          isLoading = false;
          items.addAll(newItems);
        });
      }

      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Load on top
        final newItems = await widget.fetchItemsOnTop?.call(items) ?? [];
        setState(() {
          isLoading = false;
          items.addAll(newItems);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      controller: _scrollController,
      itemCount: items.length + (isLoading ? 1 : 0),
      itemBuilder: (_, index) => _buildItem(index),
    );
  }

  _buildItem(int index) {
    // Define build loading widget
    _buildLoading() {
      return widget.childOnLoad ?? Text('Loading...');
    }

    if (widget.reverseList) {
      if (index > 0) {
        return widget.child(index - 1);
      } else {
        return _buildLoading();
      }
    } else {
      if (index < items.length) {
        return widget.child(index);
      } else {
        return _buildLoading();
      }
    }
  }
}
