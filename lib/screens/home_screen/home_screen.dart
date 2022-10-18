import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../constants/colors.dart';
import '../../helpers/hex_convert.dart';
import '../../models/shoes.dart';
import '../../services/read_data.dart';

import 'package:intern_assignment/models/cart_provider.dart';
import 'package:intern_assignment/screens/cart_screen/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool itemsIndex = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: FutureBuilder(
      future: Services.readJsonData(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return Stack(
            children: [
              Positioned(
                top: -60,
                left: -120,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: ColorsApp.kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/nike.png',
                        width: 60,
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Our Products',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CartScreen(
                                      cartData: provider.shoes,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.8),
                                        offset: const Offset(-6.0, -6.0),
                                        blurRadius: 16.0,
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(6.0, 6.0),
                                        blurRadius: 16.0,
                                      ),
                                    ],
                                    color: const Color(0xFFEFEEEE),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                  ),
                                  child: const Icon(CupertinoIcons.cart),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.black,
                                  child: Text(
                                    '${Provider.of<Cart>(context).itemCount}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var items = snapshot.data![index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: size.height * 1 / 2,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: HexColor(items.color),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              transformAlignment:
                                                  Alignment.center,
                                              transform: Matrix4.rotationZ(
                                                  -math.pi / 8),
                                              child: Image.network(
                                                items.image,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Center(
                                                        child: Text(
                                                            'Can not found image')),
                                                loadingBuilder: (context, child,
                                                        loadingProgress) =>
                                                    loadingProgress != null
                                                        ? const Center(
                                                            child:
                                                                CupertinoActivityIndicator(),
                                                          )
                                                        : child,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    items.name,
                                    style: const TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    items.description,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontFamily: 'Rubik',
                                        color: ColorsApp.kDescriptionText,
                                        letterSpacing: 1),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\u0024${items.price}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18),
                                      ),
                                      (items.isBought)
                                          ? CircleAvatar(
                                              radius: 21,
                                              backgroundColor:
                                                  ColorsApp.kPrimaryColor,
                                              child: Image.asset(
                                                'assets/icons/check.png',
                                                height: 18,
                                                width: 18,
                                              ),
                                            )
                                          : Material(
                                              color: ColorsApp.kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: InkWell(
                                                onTap: () {
                                                  provider.addCart(
                                                    Shoes(
                                                      id: items.id,
                                                      image: items.image,
                                                      name: items.name,
                                                      description:
                                                          items.description,
                                                      price: items.price,
                                                      color: items.color,
                                                      quantity:
                                                          items.quantity + 1,
                                                    ),
                                                  );

                                                  provider.addTotalPrice(
                                                      double.parse(items.price
                                                          .toString()));

                                                  provider.updateItems(items);
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                splashColor: Colors.black26,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: size.height * 0.05,
                                                  width: size.width * 0.35,
                                                  child: const Text(
                                                    'ADD TO CART',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rubik'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      }),
    ));
  }
}
