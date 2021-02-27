import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class DetailOrder {
  int id;
  DateTime estimatedDeliveryDate;
  String subtotalPrice;
  String charge;
  String totalPrice;
  List<Item> listItem;

  DetailOrder({
    this.id,
    this.estimatedDeliveryDate,
    this.subtotalPrice,
    this.charge,
    this.totalPrice,
    this.listItem,
  });
  List<DetailOrder> _detailOrder = []; //DUMMY_PRODUCTS;
  List<DetailOrder> get detailOrder {
    return [..._detailOrder];
  }

  factory DetailOrder.fromJson(Map<String, dynamic> parsedJson) {
    return DetailOrder(
        id: int.parse(parsedJson['id']),
        estimatedDeliveryDate:
            DateTime.parse(parsedJson['estimatedDeliveryDate']),
        subtotalPrice: parsedJson['subtotalPrice'],
        charge: parsedJson['charge'],
        totalPrice: parsedJson['totalPrice'],
        listItem: (parsedJson['listItem'] as List)
            .map((item) => Item.fromJson(item))
            .toList());
  }

  Future<String> _loadADetailOrderAsset() async {
    return await rootBundle.loadString('assets/json/detailOrder.json');
  }

  Future<List<DetailOrder>> loadDetailOrder() async {
    await wait(2);
    String jsonString = await _loadADetailOrderAsset();
    final jsonResponse = json.decode(jsonString);
    for (var detailOrder in jsonResponse['detailOrder']) {
      _detailOrder.add(DetailOrder.fromJson(detailOrder));
    }
    return _detailOrder;
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }
}

class Item {
  String typeLaundry;
  String item;
  String totalItem;
  String price;

  Item({
    this.typeLaundry,
    this.item,
    this.totalItem,
    this.price,
  });

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(
        typeLaundry: parsedJson['typeLaundry'],
        item: parsedJson['item'],
        totalItem: parsedJson['totalItem'],
        price: parsedJson['price']);
  }
}
