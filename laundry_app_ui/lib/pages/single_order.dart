import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_app_ui/models/detail_order.dart';
import 'package:laundry_app_ui/utils/constants.dart';
import 'package:intl/intl.dart';

class SingleOrder extends StatefulWidget {
  final int id;

  // receive data from the OrderCard as a parameter
  SingleOrder({Key key, @required this.id}) : super(key: key);

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  final List<DetailOrder> detailOrder = [];
  DetailOrder detailOrderView = new DetailOrder();
  List<Item> listItemWash = [];
  List<Item> listItemIron = [];
  bool _loaded = false;
  final DateFormat formatter = DateFormat("dd MMM yyyy");

  @override
  void initState() {
    super.initState();
    DetailOrder().loadDetailOrder().then((value) => setState(() {
          detailOrder.addAll(value);
          _loaded = true;
          for (DetailOrder itemDetailOrder in detailOrder) {
            //get id from widget SingleOrder
            if (itemDetailOrder.id == widget.id) {
              detailOrderView = itemDetailOrder;
              for (Item item in detailOrderView.listItem) {
                if (item.typeLaundry == "WASH") {
                  listItemWash.add(item);
                } else {
                  listItemIron.add(item);
                }
              }
            }
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return _loaded
        ? Scaffold(
            backgroundColor: Constants.primaryColor,
            body: Container(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    right: 0.0,
                    top: 10.0,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        "assets/images/washing_machine_illustration.png",
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kToolbarHeight,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FlutterIcons.keyboard_backspace_mdi,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Details About\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                TextSpan(
                                  text: "Order #${detailOrderView.id}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Constants.scaffoldBackgroundColor,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 24.0,
                              horizontal: 16.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Details",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Constants.otherColor1,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "Washing And Folding",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Constants.otherColor1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                getItemLoopWidgets(listItemWash),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Ironing",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Constants.otherColor1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                getItemLoopWidgets(listItemIron),
                                Divider(),
                                getSubtotalRow("Subtotal",
                                    "RM ${detailOrderView.subtotalPrice}"),
                                getSubtotalRow(
                                    "Delivery", "RM ${detailOrderView.charge}"),
                                SizedBox(
                                  height: 10.0,
                                ),
                                getTotalRow("Total",
                                    "RM ${detailOrderView.totalPrice}"),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(16.0),
                            height: ScreenUtil().setHeight(127.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Your clothes are now washing.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Constants.otherColor3,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Estimated Delivery\n",
                                            style: TextStyle(
                                              color: Constants.otherColor4,
                                            ),
                                          ),
                                          TextSpan(
                                            text: formatter.format(
                                                detailOrderView
                                                    .estimatedDeliveryDate),
                                            style: TextStyle(
                                              color: Constants.otherColor3,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/washlogo.png",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Constants.primaryColor,
            body: Container(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    right: 0.0,
                    top: 10.0,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        "assets/images/washing_machine_illustration.png",
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kToolbarHeight,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FlutterIcons.keyboard_backspace_mdi,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Details About\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          new Center(
                            child: new CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

Widget getTotalRow(String title, String amount) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.otherColor1,
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: Constants.otherColor1,
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          ),
        )
      ],
    ),
  );
}

Widget getSubtotalRow(String title, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.otherColor2,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          price,
          style: TextStyle(
            color: Constants.otherColor2,
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

Widget getItemLoopWidgets(List<Item> listItem) {
  List<Widget> list = new List<Widget>();
  for (var i = 0; i < listItem.length; i++) {
    list.add(getItemRow(
        listItem[i].totalItem, listItem[i].item, "RM ${listItem[i].price}"));
  }
  return new Column(children: list);
}

Widget getItemRow(String count, String item, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Constants.otherColor1,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            " x $item",
            style: TextStyle(
              color: Constants.otherColor2,
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Constants.otherColor1,
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}
