import 'package:appecommerce/constants.dart';
import 'package:appecommerce/models/Category.dart';
import 'package:appecommerce/models/Food.dart';
import 'package:appecommerce/pages/Cart.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/pages/Search.dart';
import 'package:appecommerce/pages/detailcate.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum Complexity { Simple, Medium, Hard }

const FAKE_CATEGORIES = const [
  Category(
      id: 1,
      content: 'Thời trang nam',
      img: "assets/categories/categories_main/cate1.png"),
  Category(
      id: 2,
      content: 'Điện thoại & Phụ kiệm',
      img: "assets/categories/categories_main/cate2.png"),
  Category(
      id: 3,
      content: 'Thiết bị điện tử',
      img: "assets/categories/categories_main/cate3.png"),
  Category(
      id: 4,
      content: 'Thời trang nữ',
      img: "assets/categories/categories_main/cate4.png"),
  Category(
      id: 5,
      content: 'Mẹ & Bé',
      img: "assets/categories/categories_main/cate5.png"),
  Category(
      id: 6,
      content: 'Nhà cửa & Đời sống',
      img: "assets/categories/categories_main/cate6.png"),
  Category(
      id: 7,
      content: 'Máy tính & Laptop',
      img: "assets/categories/categories_main/cate7.png"),
  Category(
      id: 8,
      content: 'Sức khỏe & Sắc đẹp',
      img: "assets/categories/categories_main/cate8.png"),
  Category(
      id: 9,
      content: 'Máy ảnh - Máy quay',
      img: "assets/categories/categories_main/cate9.png"),
  Category(
      id: 10,
      content: 'Giày dép nữ',
      img: "assets/categories/categories_main/cate10.png"),
  Category(
      id: 11,
      content: 'Đồng hồ',
      img: "assets/categories/categories_main/cate11.png"),
  Category(
      id: 12,
      content: 'Túi vúi',
      img: "assets/categories/categories_main/cate12.png"),
  Category(
      id: 13,
      content: 'Giày dép nam',
      img: "assets/categories/categories_main/cate13.png"),
  Category(
      id: 14,
      content: 'Phụ kiên thời trang',
      img: "assets/categories/categories_main/cate14.png"),
];
var FAKE_FOODS = [
  //array of food's objects
  Food(
      name: "sushi - 寿司",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes: 25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "sushi - 寿司1",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes: 25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "sushi - 寿司2",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes: 25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "sushi - 寿司3",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes: 25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "sushi - 寿司4",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes: 25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "sushi - 寿司5",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes: 25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "Pizza tonda",
      urlImage: "https://www.angelopo.com/filestore/images/pizza-tonda.jpg",
      duration: Duration(minutes: 15),
      complexity: Complexity.Hard,
      ingredients: [
        'Tomato sauce',
        'Fontina cheese',
        'Pepperoni',
        'Onions',
        'Mushrooms',
        'pepperoncini'
      ],
      categoryId: 2),
  Food(
      name: "Pizza tonda1111111",
      urlImage: "https://www.angelopo.com/filestore/images/pizza-tonda.jpg",
      duration: Duration(minutes: 15),
      complexity: Complexity.Hard,
      ingredients: [
        'Tomato sauce',
        'Fontina cheese',
        'Pepperoni',
        'Onions',
        'Mushrooms',
        'pepperoncini'
      ],
      categoryId: 2),
  Food(
      name: "Makizushi",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/0/0b/KansaiSushi.jpg",
      complexity: Complexity.Simple,
      duration: Duration(minutes: 20),
      categoryId: 1),
  Food(
      name: "Tempura",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/a/ac/Peixinhos_da_horta.jpg",
      duration: Duration(minutes: 15),
      complexity: Complexity.Simple,
      categoryId: 1),
  Food(
      name: "Neapolitan pizza",
      urlImage:
          "https://img-global.cpcdn.com/recipes/7f1a5380090f6300/1280x1280sq70/photo.jpg",
      duration: Duration(minutes: 20),
      complexity: Complexity.Medium,
      ingredients: ['Fontina cheese', 'Tomato sauce', 'Onions', 'Mushrooms'],
      categoryId: 2),
  Food(
      name: "Sashimi",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Sashimi_-_Tokyo_-_Japan.jpg/2880px-Sashimi_-_Tokyo_-_Japan.jpg",
      duration: Duration(hours: 1, minutes: 5),
      complexity: Complexity.Medium,
      categoryId: 1),
  Food(
      name: "Homemade Humburger",
      urlImage:
          "https://upload.wikimedia.org/wikipedia/commons/5/58/Homemade_hamburger.jpg",
      duration: Duration(minutes: 20),
      complexity: Complexity.Hard,
      categoryId: 3),
];

class CategoriesPage extends StatelessWidget {
  static const String routeName = '/CategoriesPage';
  final CollectionReference _productsRef =
  FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(8),
        children: FAKE_CATEGORIES
            .map((eachCategory) => CategoryItem(category: eachCategory))
            .toList(),
      ));
  }
}


class CategoryItem extends StatelessWidget {
  //1 categoryItem - 1 category object
  Category category;

  CategoryItem({this.category});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //i[ you tap to this Container, it must navigate to the list of Foods
    return InkWell(
      onTap: () {
        print('tapped to category: ${this.category.content}');
        Get.to(Cate(id: category.id.toString()));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: <Widget>[
                //Now change font's family from "Google Fonts"
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    this.category.img,
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              this.category.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            // child: Text(this.category.content, textAlign: TextAlign.center,
            //   style: Theme.of(context).textTheme.title,),
          ),
        ],
      ),
    );
  }
}

class DetailFoodPage extends StatelessWidget {
  Food food;

  DetailFoodPage({this.food});

  @override
  Widget build(BuildContext context) {
    print('ingredients : ${food.ingredients}');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${food.name}',
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              icon: Icon(EvaIcons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              icon: Icon(EvaIcons.shoppingBagOutline),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProductImages(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "product.title",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding: EdgeInsets.all(15),
                        width: 64,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: food.urlImage,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 64,
                    ),
                    child: Text(
                      "product.description",
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "See More Detail",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: Colors.red),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      pressOnSeeMore: () {},
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          ColorDots(),
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 0.15,
                                right: 0.15,
                                bottom: (40),
                                top: (15),
                              ),
                              child: DefaultButton(
                                text: "Add To Cart",
                                press: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class FoodsPage extends StatelessWidget {
  static const String routeName = '/FoodsPage';
  Category category;

  FoodsPage({this.category});

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    // Map<String, Category> arguments = ModalRoute.of(context).settings.arguments;
    // this.category = arguments['category'];
    // //Filter foods of from category
    // List<Food> foods = FAKE_FOODS
    //     .where((food) => food.categoryId == this.category.id)
    //     .toList();
    return Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
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
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      '${category.content}',
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
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search()));
                        },
                        icon: Icon(EvaIcons.search),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Cart()));
                        },
                        icon: Icon(EvaIcons.shoppingBagOutline),
                      ),
                    ],
                  ),
                  body: snapshot.data.size > 0
                      ? GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.25,
                    children: snapshot.data.docs.map((document) {
                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: FadeInImage(
                                      height: 125,
                                      width: 125,
                                      fit: BoxFit.scaleDown,
                                      image: NetworkImage(
                                        document.data()['images'][0],
                                      ),
                                      placeholder: AssetImage(
                                        'assets/shared/loading.gif',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    document.data()['name'],
                                  ),
                                  Text(
                                    "\$${document.data()['price']}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(productId: document.id),
                                    ));
                              },
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 70,
                                        child: Container(
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 250,
                                        child: Image.asset(
                                          "assets/images/empty_shopping_cart.png",
                                          height: 250,
                                          width: double.infinity,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: Container(
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          "You haven't product",
                                          style: TextStyle(
                                            color: Color(0xFF67778E),
                                            fontFamily: 'Roboto-Light.ttf',
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ))
                            ]),
                );
              }
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Loading(),
                ),
              );
            }),
      ],
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    this.pressOnSeeMore,
  }) : super(key: key);

  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: (20)),
          child: Text(
            'product.title',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all((15)),
            width: (64),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Image.asset("assets/product1.jpg"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: (20),
            right: (64),
          ),
          child: Text(
            'product.description',
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (20)),
      child: Row(
        children: [
          ...List.generate(
            5,
            (index) => ColorDot(
              isSelected: index == selectedColor,
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {},
          ),
          SizedBox(width: (20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    this.isSelected = false,
  }) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all((8)),
      height: (40),
      width: (40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key key,
    @required this.icon,
    @required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (40),
      width: (40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: (56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: (18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
  }) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: (238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: "AAAAAAA",
              child: Image.asset("assets/product1.jpg"),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(5, (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: (48),
        width: (48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset("assets/product1.jpg"),
      ),
    );
  }
}
