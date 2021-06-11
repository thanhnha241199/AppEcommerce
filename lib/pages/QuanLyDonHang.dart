import 'package:appecommerce/login/shared/constant.dart';
import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/pages/MainMenu/menu1.dart';
import 'package:appecommerce/signin/DetailOrder.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/size_config.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';


class ManageOrder extends StatefulWidget {
  ManageOrder({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ManageOrderState createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  FirebaseServices _firebaseServices =FirebaseServices();
  List<String> data = ['Chờ xác nhân', 'Đã xác nhận', 'Đang giao', "Đã giao","Hủy"];
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Quản lý đơn hàng",
          style: TextStyle(color: Colors.black),
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
      body: SafeArea(
        child: CustomTabView(
          initPosition: initPosition,
          itemCount: data.length,
          tabBuilder: (context, index) => Tab(text: data[index]),
          pageBuilder: (context, index) => Container(
            child: Stack(
              children: [
                FutureBuilder<QuerySnapshot>(
                  future: _firebaseServices.orderRef
                      .where("uid",isEqualTo: _firebaseServices.getUserId())
                      .where("trang thai",isEqualTo: index==0 ? "Chưa xác nhận" : index ==1 ?"Đã xác nhận": index==2 ?"Đang giao" : index==3 ? "Đã giao":"Đã hủy").get(),
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
                        children: snapshot.data.docs.map((document) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 24.0,
                            ),
                            child: GestureDetector(
                              onTap: (){
                                  Get.to(OrderDetail(detail: document.id,));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, -15),
                                      blurRadius: 20,
                                      color: Color(0xFFDADADA)
                                          .withOpacity(0.15),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      child: AspectRatio(
                                        aspectRatio: 0.9,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF5F6F9),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          child: FadeInImage(
                                            fit: BoxFit.scaleDown,
                                            image: NetworkImage(
                                              "https://www.mageworx.com/media/catalog/product/o/r/order_editor.png",
                                            ),
                                            placeholder: AssetImage(
                                              'assets/shared/loading.gif',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${document.id}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "${document.data()['price']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "${document.data()['trang thai']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
              ],
            ),
          ),
          onPositionChange: (index) {
            print('current position: $index');
            initPosition = index;
          },
          onScroll: (position) => print('$position'),
        ),
      ),
    );
  }

}
class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget stub;
  final ValueChanged<int> onPositionChange;
  final ValueChanged<double> onScroll;
  final int initPosition;

  CustomTabView({
    @required this.itemCount,
    @required this.tabBuilder,
    @required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView> with TickerProviderStateMixin {
  TabController controller;
  int _currentCount;
  int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 :
        _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            if(mounted) {
              widget.onPositionChange(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            controller: controller,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
                  (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: controller,
            children: List.generate(
              widget.itemCount,
                  (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll(controller.animation.value);
    }
  }
}