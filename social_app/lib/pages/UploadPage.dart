// import 'dart:html';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/pages/HomePage.dart';
import 'package:social_app/widgets/ProgressWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:buddiesgram/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as ImD;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadPage extends StatefulWidget {
  // @override
  // void initState() {
  //   getUserId();
  //   super.initState();
  // }

  // String userId;
  // getUserId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   userId = sharedPreferences.getString('id');
  // }

  // final User gCurrentUser;

  // UploadPage({this.gCurrentUser});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getUserId();
    getUserName();
    super.initState();
  }

  String userIdP;
  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userIdP = sharedPreferences.getString('id');
  }

  String usernameP;
  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    usernameP = sharedPreferences.getString('name');
  }

  File file;
  bool uploading = false;
  String postId = Uuid().v4();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();

  final _picker = ImagePicker();
  captureImageWithCamera() async {
    Navigator.pop(context);

    final imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 680,
      maxWidth: 970,
    );
    setState(() {
      this.file = File(imageFile.path);
    });
  }

  pickImagefromGallery() async {
    Navigator.pop(context);
    final imageFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    // File imageFile = await ImagePicker.pickImage(
    //   source: ImageSource.gallery,
    // );
    setState(() {
      this.file = File(imageFile.path);
    });
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "New Post",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Capture Image With Camera",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select Image From Gallery",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: pickImagefromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancle",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  displayUploadScreen() {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add_photo_alternate,
            color: Colors.grey,
            size: 200.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  "Upload Image",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.green,
                onPressed: () => takeImage(context)),
          ),
        ],
      ),
    );
  }

  clearPostInfo() {
    locationTextEditingController.clear();
    descriptionTextEditingController.clear();
    setState(() {
      file = null;
    });
  }

  getUserCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark mPlaceMark = placeMarks[0];
    String completeAddressInfo =
        ' ${mPlaceMark.subThoroughfare} ${mPlaceMark.thoroughfare}, ${mPlaceMark.subLocality} ${mPlaceMark.locality}, ${mPlaceMark.subAdministrativeArea} ${mPlaceMark.administrativeArea}, ${mPlaceMark.postalCode} ${mPlaceMark.country},';
    String specificAddress = '${mPlaceMark.locality}, ${mPlaceMark.country}';
    locationTextEditingController.text = specificAddress;
  }

  compressingPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/imag_$postId.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 60));
    setState(() {
      file = compressedImageFile;
    });
  }

  controlUploadAndSaved() async {
    setState(() {
      uploading = true;
    });

    await compressingPhoto();

    String downloadUrl = await uploadPhoto(file);

    savePostInfoToFireStore(
        url: downloadUrl,
        location: locationTextEditingController.text,
        description: descriptionTextEditingController.text);

    locationTextEditingController.clear();
    descriptionTextEditingController.clear();

    setState(() {
      file = null;
      uploading = false;
      postId = Uuid().v4();
    });
  }

  // savePostInfoToFireStore({String url, String location, String description}) {
  //   postsReference
  //       .document(widget.gCurrentUser.id)
  //       .collection("usersPosts")
  //       .document(postId)
  //       .setData({
  //     "postId": postId,
  //     "ownerId": widget.gCurrentUser.id,
  //     "timestamp": timestamp,
  //     "likes": {},
  //     "username": widget.gCurrentUser.username,
  //     "description": description,
  //     "location": location,
  //     "url": url,
  //   });
  // }

  savePostInfoToFireStore({String url, String location, String description}) {
    postsReference.doc(userIdP).collection("usersPosts").doc(postId).set({
      "postId": postId,
      "ownerId": userIdP,
      "timestamp": timestamp,
      "likes": {},
      "username": usernameP,
      "description": description,
      "location": location,
      "url": url,
    });
  }

  // Future<String> uploadPhoto(mImageFile) async {
  //   firebase_storage.UploadTask mStorageUploadTask =
  //       storageReference.child("post_$postId.jpg").putFile(mImageFile);
  //   firebase_storage.UploadTask storageTaskSnapshot =
  //       await mStorageUploadTask.onComplete;
  //   String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }
  Future<String> uploadPhoto(mImageFile) async {
    firebase_storage.UploadTask mStorageUploadTask =
        storageReference.child("post_$postId.jpg").putFile(mImageFile);
    // firebase_storage.UploadTask storageTaskSnapshot =
    //     await mStorageUploadTask ;
    String downloadUrl = await (await mStorageUploadTask).ref.getDownloadURL();
    return downloadUrl;
  }

  displayUploadFormScreen() {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: clearPostInfo),
        title: Text(
          "New Post",
          style: TextStyle(
              color: Colors.lightGreenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 24.0),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: uploading ? null : () => controlUploadAndSaved(),
            child: Text(
              "Share",
              style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          uploading ? linearProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(file),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage:

                  // CachedNetworkImageProvider(currentUser),
                  AssetImage('assets/images/girl.jpeg'),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "Say something about image.",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person_pin_circle,
              color: Colors.white,
              size: 36.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: locationTextEditingController,
                decoration: InputDecoration(
                  hintText: "Write location here.",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 220.0,
            height: 110.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
              color: Colors.green,
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              label: Text(
                "Get my Current Location",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: getUserCurrentLocation,
            ),
          ),
        ],
      ),
    );
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    
    return file == null ? displayUploadScreen() : displayUploadFormScreen();
  }
}
