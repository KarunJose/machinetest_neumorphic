import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:neumoprhic_machinetest/screens/notification/view/notification.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String status = "";
  late StreamSubscription subscription;

  @override
  void initState() {
    checkConnectivity();

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Network detected " + result.name),
        ),
      );
    });
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() {
    Provider.of<ProductProvider>(context, listen: false).getProduct();
  }

  Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      setState(() {
        status = "No network detected";
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ));
            },
          )
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) => SafeArea(
          child: productProvider.loading == true
              ? const Center(child: CircularProgressIndicator())
              : GridView.count(
                  crossAxisCount: 2,
                  //crossAxisSpacing: 2.0,
                  //mainAxisSpacing: 2.0,
                  shrinkWrap: true,
                  children: List.generate(
                    productProvider.products.length,
                    (index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            productProvider
                                                .products[index].image!,
                                            height: 150,
                                            width: 150,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                'Rate: ',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                productProvider.products[index]
                                                    .rating!.rate
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                'Count: ',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                productProvider.products[index]
                                                    .rating!.count
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Image.network(
                                    productProvider.products[index].image!,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    productProvider.products[index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('₹ ' +
                                      productProvider.products[index].price
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  static await(Future<ConnectivityResult> checkConnectivity) {}
}
