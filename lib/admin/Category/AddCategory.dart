import 'dart:io';

import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddCategory extends StatefulWidget {
  final String cateID;

  AddCategory({this.cateID});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _ID = "";
  String _Content = "";
  FocusNode _contentFocusNode;
  bool _loading = false;

  @override
  void initState() {
    _contentFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
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
            "ADD CATEGORY",
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
                  "Content: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              CustomInput(
                onChanged: (value) {
                  _Content = value;
                  print("${_Content}");
                },
                hintText: "Content",
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
                      _firebaseServices.cateRef.doc(widget.cateID).set({
                        "id": int.parse(_ID),
                        "content": _Content,
                        "img": value,
                        "search_string": _Content.toLowerCase()
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
