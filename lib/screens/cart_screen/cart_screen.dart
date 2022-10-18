import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../helpers/hex_convert.dart';
import '../../models/cart_provider.dart';
import '../../models/shoes.dart';
import '../../widgets/rounded_button.dart';

import '/constants/colors.dart';

class CartScreen extends StatefulWidget {
  List<Shoes> cartData = [];

  CartScreen({super.key, required this.cartData});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      body: Stack(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/images/nike.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Your cart',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik'),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        '\u0024 ${provider.getTotalPrice().abs().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                widget.cartData.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: widget.cartData.length,
                            itemBuilder: (context, index) {
                              var cartList = widget.cartData[index];
                              return Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: HexColor(cartList.color),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(80)),
                                        ),
                                      ),
                                      Transform.rotate(
                                        angle: -math.pi / 7,
                                        child: Image.network(
                                          cartList.image,
                                          height: 140,
                                          width: 140,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          cartList.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '\u0024${(cartList.price).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          RoundedButton(
                                            image: 'assets/icons/minus.png',
                                            color: ColorsApp.kRoundedButton,
                                            height: 10,
                                            onTap: () {
                                              double price = cartList.price;

                                              final itemExist = widget.cartData
                                                  .firstWhere((e) =>
                                                      e.id == cartList.id);

                                              if (itemExist != null) {
                                                itemExist.quantity--;

                                                if (itemExist.quantity <= 0) {
                                                  Provider.of<Cart>(context,
                                                          listen: false)
                                                      .removeCart(cartList.id);
                                                  widget.cartData.removeWhere(
                                                      (element) =>
                                                          element.id ==
                                                          cartList.id);

                                                  Provider.of<Cart>(context,
                                                          listen: false)
                                                      .updateItems(cartList);
                                                }
                                              } else {
                                                print("Empty");
                                              }

                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .removeTotalPrice(
                                                      price.abs());
                                              setState(() {});
                                            },
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          SizedBox(
                                              width: 22,
                                              child: Text(
                                                '${cartList.quantity}',
                                                textAlign: TextAlign.center,
                                              )),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          RoundedButton(
                                            color: ColorsApp.kRoundedButton,
                                            image: 'assets/icons/plus.png',
                                            height: 10,
                                            onTap: () {
                                              var price = cartList.price;

                                              final itemExist = widget.cartData
                                                  .firstWhere((e) =>
                                                      e.id == cartList.id);
                                              if (itemExist != null) {
                                                itemExist.quantity++;
                                              } else {
                                                print("Empty");
                                                widget.cartData.add(cartList);
                                              }

                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .addTotalPrice(price);

                                              setState(() {});
                                            },
                                          ),
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          RoundedButton(
                                            color: ColorsApp.kPrimaryColor,
                                            image: 'assets/icons/trash.png',
                                            height: 18,
                                            onTap: () {
                                              var price = cartList.price;
                                              var newPrice =
                                                  cartList.quantity * price;

                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .removeCart(cartList.id);
                                              widget.cartData.removeWhere(
                                                  (element) =>
                                                      element.id ==
                                                      cartList.id);

                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .removeTotalPrice(
                                                      double.parse(
                                                          newPrice.toString()));

                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
