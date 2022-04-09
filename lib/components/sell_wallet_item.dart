import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:stock_picking_mobile/classes/stock_transaction.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/utils/index.dart';

class SellWalletItem extends StatelessWidget {
  const SellWalletItem({Key? key, required this.onSubmit, required this.data})
      : super(key: key);

  final Function(StockTransaction) onSubmit;
  final WalletItem data;

  void handleAddClick(Map<String, dynamic> formData) {
    formData["type"] = StockTransactionType.sell.index;
    formData["ticker"] = data.name;
    onSubmit(StockTransaction.fromMap(formData));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(children: [
      SellWalletItemForm(onAddClick: handleAddClick, data: data)
    ]));
  }
}

class SellWalletItemForm extends StatefulWidget {
  const SellWalletItemForm(
      {Key? key, required this.onAddClick, required this.data})
      : super(key: key);

  final Function onAddClick;
  final WalletItem data;

  @override
  SellWalletItemFormState createState() {
    return SellWalletItemFormState();
  }
}

class SellWalletItemFormState extends State<SellWalletItemForm> {
  final _formKey = GlobalKey<FormState>();

  final priceController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ', decimalSeparator: ',', thousandSeparator: '.');

  final dateController = MaskedTextController(mask: '00/00/0000');

  final Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        children: <Widget>[
          Text(
            widget.data.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              formData['quantity'] = value != null ? int.parse(value) : 0;
            },
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Quantity',
                helperText: 'Max: ' + widget.data.quantity.toString()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid number';
              }

              int intValue = int.parse(value);

              if (intValue > widget.data.quantity || intValue < 0) {
                return 'Enter a valid number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              if (value != null) {
                formData['price'] = getValueFromMoneyMask(value);
              }
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Price',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: dateController,
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              if (value != null) {
                formData['date'] = getDateFromValue(value)?.toIso8601String();
              }
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Sell date',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid date';
              }

              bool isValid = isDateValid(value);

              if (!isValid) return 'Please enter a valid date';

              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onAddClick(formData);
                    }
                  },
                  child: const Text('Sell'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
