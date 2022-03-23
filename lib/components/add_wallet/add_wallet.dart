import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/utils/index.dart';

class AddWallet extends StatelessWidget {
  const AddWallet({Key? key, required this.onSubmit}) : super(key: key);

  final Function(WalletItem) onSubmit;

  void handleAddClick(Map<String, dynamic> data) {
    onSubmit(WalletItem.fromMap(data));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(children: [
      AddWalletForm(
        onAddClick: handleAddClick,
      )
    ]));
  }
}

class AddWalletForm extends StatefulWidget {
  const AddWalletForm({Key? key, required this.onAddClick}) : super(key: key);

  final Function onAddClick;

  @override
  AddWalletFormState createState() {
    return AddWalletFormState();
  }
}

class AddWalletFormState extends State<AddWalletForm> {
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
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: (String? value) {
              formData['name'] = value;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ticker',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid ticker';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              formData['quantity'] = value != null ? int.parse(value) : 0;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Quantity',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid number';
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
                formData['buyDate'] = getDateFromValue(value);
              }
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Buy date',
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
                  child: const Text('Add'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
