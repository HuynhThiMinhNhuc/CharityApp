import 'dart:async';

import 'package:flutter/material.dart';

class InfinityListStateLess<T> extends StatefulWidget {
  final Widget Function(int index) child;
  final Widget? childOnLoad;
  final List<T> items;
  final FutureOr<void> Function(List<T>)? fetchItemsOnTop;
  final FutureOr<void> Function(List<T>)? fetchItemsOnBottom;
  final bool Function(List<T>)? allowFetch;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool reverseList;
  final ScrollController? controller;

  const InfinityListStateLess({
    Key? key,
    required this.child,
    required this.items,
    this.childOnLoad,
    this.fetchItemsOnTop,
    this.fetchItemsOnBottom,
    this.allowFetch,
    this.physics,
    this.shrinkWrap = false,
    this.reverseList = false,
    this.controller,
  }) : super(key: key);

  @override
  State<InfinityListStateLess<T>> createState() =>
      _InfinityListStateLessState<T>();
}

class _InfinityListStateLessState<T> extends State<InfinityListStateLess<T>> {
  late final ScrollController _scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(fetchItems);
  }

  @override
  void dispose() {
    _scrollController.removeListener(fetchItems);
    if (widget.controller == null) _scrollController.dispose();
    super.dispose();
  }

  void fetchItems() async {
    
      // Check is loading
      if (isLoading || !(widget.allowFetch?.call(widget.items) ?? true)) {
        print('List is loading, can not load more');
        return;
      }

      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          isLoading = true;
        });
        print('On load items in bottom list');
        // Load on bottom
        await widget.fetchItemsOnBottom?.call(widget.items);
        setState(() {
          isLoading = false;
        });
      }

      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          isLoading = true;
        });
        print('On load items in top list');
        // Load on top
        await widget.fetchItemsOnTop?.call(widget.items);
        setState(() {
          isLoading = false;
        });
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      controller: widget.controller != null ? null : _scrollController,
      itemCount: widget.items.length + (isLoading ? 1 : 0),
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
      if (index < widget.items.length) {
        return widget.child(index);
      } else {
        return _buildLoading();
      }
    }
  }
}
