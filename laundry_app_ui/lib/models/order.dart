import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum OrderStatus { PICKING_UP, DELIVERING }

class Order {
  final int id;
  final OrderStatus status;
  final DateTime arrivalDate;
  final DateTime placedDate;
  final String deliveryAddress;

  Order({
    this.id,
    this.status,
    this.arrivalDate,
    this.placedDate,
    this.deliveryAddress,
  });

  factory Order.fromJson(Map<String, dynamic> parsedJson) {
    return Order(
        id: int.parse(parsedJson['id']),
        status:
            EnumToString.fromString(OrderStatus.values, parsedJson['status']),
        arrivalDate: DateTime.parse(parsedJson['arrivalDate']),
        placedDate: DateTime.parse(parsedJson['placedDate']),
        deliveryAddress: parsedJson['deliveryAddress']);
  }

  List<Order> _orders = []; //DUMMY_PRODUCTS;
  List<Order> get orders {
    return [..._orders];
  }

  Future<String> _loadAOrderAsset() async {
    return await rootBundle.loadString('assets/json/order.json');
  }

  Future<List<Order>> loadOrder() async {
    await wait(2);
    String jsonString = await _loadAOrderAsset();
    final jsonResponse = json.decode(jsonString);
    for (var item in jsonResponse['orders']) {
      _orders.add(Order.fromJson(item));
    }
    return _orders;
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }
}
