import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/components/magic_item_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StockList extends StatefulWidget {
  const StockList(
      {Key? key,
      required this.items,
      required this.onSelectionChange,
      this.search = ""})
      : super(key: key);

  final List<StockListItem> items;
  final String search;
  final Function(Map value) onSelectionChange;

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  Map selected = {};
  final pageSize = 30;
  int pages = 1;
  bool canLoadMore = false;
  List<StockListItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items.sublist(0, pages * pageSize);
  }

  void _showMoreItems(visibilityInfo) {
    if (visibilityInfo.visibleFraction == 1 && !canLoadMore) {
      setState(() {
        pages = pages + 1;
        canLoadMore = true;
        filteredItems = widget.items.sublist(0, pages * pageSize);
      });
    } else {
      setState(() {
        canLoadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            itemCount: filteredItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            itemBuilder: (context, index) {
              return MagicItemCard(
                  key: Key(filteredItems[index].papel),
                  data: filteredItems[index]);
            }),
        VisibilityDetector(
            key: const Key('loading'),
            onVisibilityChanged: _showMoreItems,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: const Center(
                  child: CircularProgressIndicator(),
                ))),
      ],
    );
  }
}
