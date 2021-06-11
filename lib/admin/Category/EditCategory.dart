import 'package:appecommerce/pages/MainMenu/firebasesevice.dart';
import 'package:appecommerce/signin/custom_btn.dart';
import 'package:appecommerce/signin/custom_input.dart';
import 'package:appecommerce/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class EditCategory extends StatefulWidget {
  final String CateID;
  EditCategory({this.CateID});
  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  FirebaseServices _firebaseServices = FirebaseServices();
  bool Loading = false;
  String _ID = "";
  String _Content = "";
  String img = "";
  bool check = true;
  FocusNode _contentFocusNode;

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
    taskSnapshot.ref.getDownloadURL().then(
            (value) {
          print("Done: $value");
          img = value;
          return value;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Categories",
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
        body: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.cateRef
                    .get(),
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
                    return  ListView(
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data.docs.map((documnent){
                          print("${documnent.id}");
                          print("${widget.CateID}");
                          return documnent.id == widget.CateID ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.0,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 24.0),
                                child: Text("ID:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                  ),),
                              ),
                              CustomInput(
                                hintText: documnent.data()['id'].toString(),
                                textInputAction: TextInputAction.next,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 24.0),
                                child: Text("Name:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                  ),),
                              ),
                              CustomInput(
                                hintText: documnent.data()['content'],
                                textInputAction: TextInputAction.next,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 24.0),
                                child: Text("Image",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                  ),),
                              ),
                              _imageFile != null
                                  ? Container(
                                  height: 50, width: 50, child: Image.file(_imageFile))
                                  : CustomBtn(
                                  text: "Upload",
                                  onPressed: () {
                                    _showPicker(context);
                                  }
                              ),
                              SizedBox(height: 30.0,),
                              CustomBtn(
                                text: "Save",
                                onPressed: () async{
                                  //Loading = true;
                                  String fileName = basename(_imageFile.path);
                                  Reference firebaseStorageRef =
                                  FirebaseStorage.instance.ref().child('images/$fileName');
                                  UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
                                  TaskSnapshot taskSnapshot = await uploadTask;
                                  taskSnapshot.ref.getDownloadURL().then(
                                          (value) {
                                        print("Done: $value");
                                        img = value;
                                        return value;
                                      }
                                  );
                                  setState(() {
                                    uploadImageToFirebase(context);
                                    check = false;
                                    _firebaseServices.cateRef
                                        .doc(widget.CateID)
                                        .set({
                                      "id": int.parse(_ID),
                                      "content": _Content,
                                      "img": img,
                                    });
                                  });
                                },
                                isLoading: Loading,
                              )
                            ],
                          ) :  Text("");
                        }
                        ).toList()
                    );
                  }
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(""),
                    ),
                  );
                })
          ],
        ));
  }
}
