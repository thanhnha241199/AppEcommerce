import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Container(
                  child: Text(
                    "Search Results",
                    style: Constants.regularDarkText,
                  ),
                ),
              )
            else
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productsRef
                    .orderBy("search_string")
                    .startAt([_searchString]).endAt(
                        ["$_searchString\uf8ff"]).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }

                  // Collection Data ready to display
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Display the data inside a list view
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 100.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        return ProductCard(
                          title: document.data()['name'],
                          imageUrl: document.data()['images'][0],
                          price: "\$${document.data()['price']}",
                          productId: document.id,
                        );
                      }).toList(),
                    );
                  }

                  // Loading State
                  return Scaffold(
                    body: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Loading(),
                      ),
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: CustomInput(
                hintText: "Search here...",
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
