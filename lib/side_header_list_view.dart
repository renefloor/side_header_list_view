library side_header_list_view;

import 'package:flutter/material.dart';

///  SideHeaderListView for Flutter
///
///  Copyright (c) 2017 Rene Floor
///
///  Released under BSD License.

typedef HasSameHeader = bool Function(int a, int b);

/// Creates a scrollable, linear array of widgets with a header like in the
/// Google contacts app.
///
/// The [itemBuilder] callback will be called only with indices greater than
/// or equal to zero and less than `itemCount`.
///
/// The [itemBuilder] should always return a non-null widget, and actually
/// create the widget instances when called. Creating the widgets in advance
/// is possible, but less efficient.
///
/// The [headerBuilder] should always return a non-null widget that is used
/// as the header. The header is shown in front of the item and takes all the
/// space needed. When the header is not shown, this widget is still created
/// to calculate the space needed.
///
/// The [hasSameHeader] function is used to know when the header is needed to
/// be shown. The header is hidden if the item above this one has the same
/// header.
class SideHeaderListView extends StatefulWidget {
  /// The number of items in the listview. If `null` an infinite list is made.
  final int? itemCount;

  /// An IndexedWidgetBuilder to build the item header
  final IndexedWidgetBuilder headerBuilder;

  /// An IndexedWidgetBuilder to build the item content
  final IndexedWidgetBuilder itemBuilder;

  /// Padding around the header and item.
  final EdgeInsets? padding;

  /// Function to indicate if two positions in the listview have the same
  /// header content.
  final HasSameHeader hasSameHeader;

  /// The height of an item. This is required to be able to calculate the
  /// current position.
  final itemExtend;

  /// Create a SideHeaderListView. The [itemExtend], [headerBuilder],
  /// [itemBuilder] and [hasSameHeader] function are required. When not
  /// supplying an [itemCount] an infinite list is created. The [padding] is
  /// set around the header and item widget.
  SideHeaderListView({
    Key? key,
    this.itemCount,
    required this.itemExtend,
    required this.headerBuilder,
    required this.itemBuilder,
    required this.hasSameHeader,
    this.padding,
  }) : super(key: key);

  @override
  _SideHeaderListViewState createState() => _SideHeaderListViewState();
}

class _SideHeaderListViewState extends State<SideHeaderListView> {
  int currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Opacity(
            opacity: _shouldShowHeader(currentPosition) ? 0.0 : 1.0,
            child: widget.headerBuilder(
                context, currentPosition >= 0 ? currentPosition : 0),
          ),
          top: 0.0 + (widget.padding?.top ?? 0),
          left: 0.0 + (widget.padding?.left ?? 0),
        ),
        ListView.builder(
            padding: widget.padding,
            itemCount: widget.itemCount,
            itemExtent: widget.itemExtend,
            controller: _getScrollController(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Opacity(
                      opacity: _shouldShowHeader(index) ? 1.0 : 0.0,
                      child: widget.headerBuilder(context, index),
                    ),
                  ),
                  Expanded(child: widget.itemBuilder(context, index))
                ],
              );
            }),
      ],
    );
  }

  bool _shouldShowHeader(int position) {
    if (position < 0) {
      return true;
    }
    if (position == 0 && currentPosition < 0) {
      return true;
    }

    if (position != 0 &&
        position != currentPosition &&
        !widget.hasSameHeader(position, position - 1)) {
      return true;
    }

    var itemCount = widget.itemCount;
    var isLast = itemCount != null && position == itemCount - 1;
    if (!isLast &&
        !widget.hasSameHeader(position, position + 1) &&
        position == currentPosition) {
      return true;
    }
    return false;
  }

  ScrollController _getScrollController() {
    var controller = ScrollController();
    controller.addListener(() {
      var pixels = controller.offset;
      var newPosition = (pixels / widget.itemExtend).floor();

      if (newPosition != currentPosition) {
        setState(() {
          currentPosition = newPosition;
        });
      }
    });
    return controller;
  }
}
