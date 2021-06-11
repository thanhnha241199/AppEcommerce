import 'dart:io';

import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class AddProduct extends StatefulWidget {
  final String productId;
  AddProduct({this.productId});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _ID = "";
  String _Name = "";
  String _Price = "";
  String _Size = "";
  String _Desc = "";
  FocusNode _nameFocusNode;
  FocusNode _priceFocusNode;
  FocusNode _sizeFocusNode;
  FocusNode _descFocusNode;
  bool _loading = false;

  @override
  void initState() {
    _nameFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _sizeFocusNode = FocusNode();
    _descFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _sizeFocusNode.dispose();
    _descFocusNode.dispose();
    super.dispose();
  }

  File _imageFile;
  final picker = ImagePicker();

  Future pickCamera() async {
    final pickedCamera = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedCamera.path);
    });
  }

  Future pickLibrary() async {
    final pickeeLibrary = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickeeLibrary.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(EvaIcons.imageOutline),
                      title: new Text('Photo Library'),
                      onTap: () {
                        pickLibrary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(EvaIcons.cameraOutline),
                    title: new Text('Camera'),
                    onTap: () {
                      pickCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) {
      //print("Done: $value");
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Product",
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
              onPressed: () {},
              icon: Icon(EvaIcons.search),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Text(
                  "ID:",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              CustomInput(
                onChanged: (value) {
                  _ID = value;
                  print("${_ID}");
                },
                hintText: "ID",
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  "Name: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              CustomInput(
                onChanged: (value) {
                  _Name  = value;
                  print("${_Name}");
                },
                hintText: "Name",
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  "Price: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              CustomInput(
                onChanged: (value) {
                  _Price = value;
                  print("${_Price}");
                },
                hintText: "Price",
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  "Size: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              CustomInput(
                onChanged: (value) {
                  _Size = value;
                  print("${_Size}");
                },
                hintText: "Size",
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 24.0,
                ),
                child: Text(
                  "Description: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              CustomInput(
                onChanged: (value) {
                  _Desc = value;
                  print("${_Desc}");
                },
                hintText: "Discription",
                textInputAction: TextInputAction.next,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Text(
                  "Image",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              _imageFile != null
                  ? Container(
                  height: 50, width: 50, child: Image.file(_imageFile))
                  : CustomBtn(
                  text: "Upload",
                  onPressed: () {
                    _showPicker(context);
                  }),
              SizedBox(
                height: 30.0,
              ),
              CustomBtn(
                text: "Save",
                onPressed: () async {
                  Loading();
                  setState(() async {
                    String fileName = basename(_imageFile.path);
                    Reference firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child('images/$fileName');
                    UploadTask uploadTask =
                    firebaseStorageRef.putFile(_imageFile);
                    TaskSnapshot taskSnapshot = await uploadTask;
                    taskSnapshot.ref.getDownloadURL().then((value) {
                      var list=[value];
                      var size=[_Size];
                      _firebaseServices.productsRef
                          .doc(widget.productId)
                          .set({
                      //  "id": int.parse(_ID),
                        "name": _Name,
                        "images": FieldValue.arrayUnion(list),
                        "price": int.parse(_Price),
                        "size":size,
                        "rating": 0,
                        "desc":_Desc,
                        "search_string": _Name.toLowerCase()
                      });
                    });
                    taskSnapshot.ref.getDownloadURL().whenComplete(() {
                      Navigator.pop(context);
                    });
                  });
                },
                isLoading: _loading,
              )
            ],
          ),
        ));
  }
}
