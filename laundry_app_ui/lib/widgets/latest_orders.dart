import 'package:flutter/material.dart';
import 'package:laundry_app_ui/models/order.dart';
import 'package:laundry_app_ui/utils/constants.dart';
import 'package:laundry_app_ui/widgets/order_card.dart';
import 'package:laundry_app_ui/utils/helper.dart';

class LatestOrders extends StatefulWidget {
  @override
  _LatestOrdersState createState() => _LatestOrdersState();
}

class _LatestOrdersState extends State<LatestOrders> {
  final List<Order> orders = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    Order().loadOrder().then((value) => setState(() {
          orders.addAll(value);
          _loaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return _loaded
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest Orders",
                        style: TextStyle(
                          color: Constants.headerColor1,
                          fontSize: 18.0,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Constants.otherColor1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          nextScreen(context, "/viewall");
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    // Lets pass the order to a new widget and render it there
                    return OrderCard(
                      order: orders[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15.0,
                    );
                  },
                  itemCount: 2,
                )
                // Let's create an order model
              ],
            ),
          )
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest Orders",
                        style: TextStyle(
                          color: Constants.headerColor1,
                          fontSize: 18.0,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Constants.otherColor1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          nextScreen(context, "/viewall");
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                new Center(
                  child: new CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              ],
            ),
          );
  }
}
