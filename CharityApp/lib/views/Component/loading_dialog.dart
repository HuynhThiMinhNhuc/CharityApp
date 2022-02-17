import 'package:flutter/material.dart';
import 'package:async/async.dart';

class LoadingDialog {
  CancelableOperation? _cancelableOperation;
  BuildContext dialogContext;

  LoadingDialog(this.dialogContext);

  bool get isLoading => _cancelableOperation != null
      ? !_cancelableOperation!.isCompleted && !_cancelableOperation!.isCanceled
      : false;

  bool get isCancel => _cancelableOperation?.isCanceled ?? false;
  bool get isCompleted => _cancelableOperation?.isCompleted ?? false;

  void load(Widget loadingWidget) {
    _cancelableOperation = CancelableOperation.fromFuture(showDialog(
        context: dialogContext, builder: (context) => loadingWidget));
  }

  void cancel() {
    if (isLoading) {
      Navigator.pop(dialogContext);
      _cancelableOperation?.cancel();
    }
  }
}
