import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/components/description_item.dart';
import 'package:stock_picking_mobile/utils/index.dart';

class MagicItemCard extends StatelessWidget {
  const MagicItemCard({Key? key, required this.data}) : super(key: key);

  final StockListItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.papel + ' #${data.magicRanking}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    data.empresa,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Expanded(
                child: Text(
              getFormattedPrice(data.cotacao),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.end,
            ))
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: DescriptionItem(
                label: "Liquid equity (M) ",
                child: getFormattedPrice(data.patrimonioLiquido / 1000000),
              )),
              Expanded(
                  child: DescriptionItem(
                      label: "EV/Ebit",
                      child: getFormattedDouble(data.evByEbit))),
              Expanded(
                  child: DescriptionItem(
                      label: "ROIC",
                      child: getFormattedPercentage(data.roic / 100))),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: DescriptionItem(
                label: "Div. Yield",
                child: getFormattedPercentage(data.dividendYield / 100),
              )),
              Expanded(
                  child: DescriptionItem(
                      label: "Ranking EV/Ebit",
                      child: data.evByEbitRanking.toString())),
              Expanded(
                  child: DescriptionItem(
                      label: "Ranking ROIC",
                      child: data.roicRanking.toString())),
            ],
          ),
        ),
      ]),
    );
  }
}
