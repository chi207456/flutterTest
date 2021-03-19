import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({Key key, this.isLoading, this.cover=false, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !cover
        ? !isLoading
            ? child
            : _loadingView
        : Stack(
            children: [child, isLoading ? _loadingView : Container()],
          );
  }

  get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
