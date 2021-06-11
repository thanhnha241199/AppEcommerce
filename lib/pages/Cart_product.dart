import 'package:flutter/material.dart';
import 'package:appecommerce/models/Product.dart';
import 'package:appecommerce/pages/ProductPage.dart';

class Cart_product extends StatefulWidget {
  final Product product;

  Cart_product({@required this.product});

  @override
  _Cart_productState createState() => _Cart_productState();
}

class _Cart_productState extends State<Cart_product> {
  int quantity = 1;
  List<Product> products = [
    Product(
        image: "assets/product1.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "iPad mini"),
    Product(
        image: "assets/product2.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "iPad Pro"),
    Product(
        image: "assets/product3.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "iPhone Pro Max"),
    Product(
        image: "assets/product4.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "Apple Watch Series 3"),
    Product(
        image: "assets/product5.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "Apple Watch Series 4"),
    Product(
        image: "assets/product6.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "Macbook Pro 16 inch"),
    Product(
        image: "assets/product7.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "Macbook Pro"),
    Product(
        image: "assets/product8.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "iMac 4k Retina"),
    Product(
        image: "assets/product9.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "T-Shirts"),
    Product(
        image: "assets/product10.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "Ethnic Wear - Dress"),
    Product(
        image: "assets/product11.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "Dress"),
    Product(
        image: "assets/product12.jpg",
        description:
            "Repudiandae quibusdam quis harum odit.Autem sunt sit. Neque sapiente officia laudantium voluptatem dolores itaque dolore odio. Voluptatem reprehenderit beatae eum eligendi dolorem laborum voluptate nihil vel.",
        price: "100",
        productName: "T-Shirt"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: <Widget>[
            _buildItemList(),
          ],
        ),
      ),
    );
  }

  // widget for the items
  Widget _buildItemList() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        shrinkWrap: true,
        //children: products.map((product) {
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(product: products.last),
                  ));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage(
                      placeholder: AssetImage("assets/placeholder.jpg"),
                      image: AssetImage(products[i].image),
                      width: 150,
                      height: 150,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          products[i].productName,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "\$${products[i].price}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                minus();
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                add();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void add() {
    setState(() {
      quantity++;
    });
  }

  void minus() {
    setState(() {
      quantity--;
    });
  }
}
