import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/components/types.dart';
import 'package:school_app/user/location.dart';
import 'package:school_app/extensions/extensions.dart' as ext;

class User extends ChangeNotifier {
  Firestore db = Firestore.instance;
  FirebaseStorage storage = new FirebaseStorage(
      storageBucket: 'gs://school-app-dff02.appspot.com/'
  );

  String _userId, _school, _email, _description, _employer, _title, _name;
  List<String> _ideologies, _interests, _religions;
  UserType _userType;
  Product _product;
  int _age;
  Gender _gender;
  UserLocation _userLocation;
  Image _profilePicture;
  NetworkImage _profilePictureNetwork;
  String _profilePictureUrl;

  String get userId => _userId;
  String get name => _name;
  String get school => _school;
  String get email => _email;
  String get description => _description;
  String get employer => _employer;
  String get title => _title;
  UserLocation get userLocation => _userLocation;
  List<dynamic> get ideologies => _ideologies;
  List<String> get interests => _interests;
  List<String> get religions => _religions;
  UserType get userType => _userType;
  Product get product => _product;
  int get age => _age;
  Gender get gender => _gender;
  Image get profilePicture => _profilePicture;
  NetworkImage get profilePictureNetwork => _profilePictureNetwork;
  String get profilePictureUrl => _profilePictureUrl;

  set setProfilePicture(Image value) {
    print("setProfilePicture: " + value.toString());
    _profilePicture = value;
    notifyListeners();
  }

  set setProfilePictureNetwork(NetworkImage value) {
    print("setProfilePictureNetwork: " + value.toString());
    _profilePictureNetwork = value;
    notifyListeners();
  }

  set setProfilePictureUrl(String value) {
    print("setProfilePictureNetwork: " + value.toString());
    _profilePictureUrl = value;
    notifyListeners();
  }

  set setName(String value) {
    _name = value;
    notifyListeners();
  }

  set setSchool(String value) {
    _school = value;
    notifyListeners();
  }
  set setEmail(String value) {
    _email = value;
    notifyListeners();
  }
  set setDescription(String value) {
    _description = value;
    notifyListeners();
  }
  set setEmployer(String value) {
    _employer = value;
    notifyListeners();
  }
  set setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  set setAge(int value) {
    _age = value;
    notifyListeners();
  }

  set setProduct(Product value) {
    _product = value;
    notifyListeners();
  }

  set setIdeologies(List<String> value) {
    _ideologies = value;
    notifyListeners();
  }

  set setReligions(List<String> value) {
    _religions = value;
    notifyListeners();
  }

  set setInterests(List<String> value) {
    _interests = value;
    notifyListeners();
  }

  set setUserLocation(UserLocation value) {
    _userLocation = value;
    notifyListeners();
  }

  String getFirstLetterOfName() {
    var fName = name == null ? '' : this.name[0].toUpperCase();
    return fName;
  }

  Gender stringToGender([String genderInput]){
    if(genderInput == null){
      return Gender.missing;
    }
    else{
      switch(genderInput){
        case "male": return Gender.male;
        case "female": return Gender.female;
        case "unknown": return Gender.unknown;
      }
    }
  }



  Product stringToProduct([String productInput]){
    if(productInput == null){
      return Product.free;
    }
    else{
      switch(productInput){
        case "premium": return Product.premium;
        case "free": return Product.free;
      }
    }
  }

  Future profileURL() async {
    StorageReference imageLink = storage
        .ref()
        .child(_userId)
        .child("profile_picture.png");
    Future imageUrl = await imageLink.getDownloadURL();
    return imageLink.getDownloadURL();
  }
  Future<String> getProfilePicture() async {
    StorageReference imageLink = storage
        .ref()
        .child(_userId)
        .child("profile_picture.png");
    final imageUrl = await imageLink.getDownloadURL();
    //_profilePicture = NetworkImage(imageUrl);
    print(imageUrl.toString());
    _profilePicture = Image.network(imageUrl.toString());
    _profilePictureNetwork = NetworkImage(imageUrl.toString());
    _profilePictureUrl = imageUrl.toString();

    setProfilePicture = Image.network(imageUrl.toString());
    setProfilePictureNetwork = NetworkImage(imageUrl.toString());
    setProfilePictureUrl = imageUrl.toString();
    print("imageUrl.toString(): " + imageUrl.toString());
    notifyListeners();

    //return Future.value(NetworkImage(imageUrl));
    return Future.value(imageUrl.toString());
  }

  Future<bool> setUserSuccessful(String userId) async {
    print(userId);
    //db.collection("path").where(field)
    try{
      DocumentSnapshot userResult = (await db
          .collection('user')
          .document(userId)
          .get());
      print(userResult.data);

      Iterable ideologiesRaw = userResult.data["ideologies"] == null ? [] : userResult.data["ideologies"];
      Iterable interestsRaw = userResult.data["interests"] == null ? [] : userResult.data["interests"];
      Iterable religionsRaw = userResult.data["religions"] == null ? [] : userResult.data["religions"];

      _userId = userId;
      _name = userResult.data["name"];
      _school = userResult.data["school"];
      _email = userResult.data["email"];
      _userType = stringToUserType(userResult.data["user_type"]);
      _product = stringToProduct(userResult.data["product"]);
      _age = userResult.data["age"];
      _gender = stringToGender(userResult.data["gender"]);
      _description = userResult.data["description"];
      _ideologies = List.from(ideologiesRaw);
      _interests = List.from(interestsRaw);
      _religions = List.from(religionsRaw);
      _title = userResult.data["title"];
      _employer = userResult.data["employer"];
      notifyListeners();
      return true;
    }
    catch(error){
      print(error);
      _userId = userId;
      _name = null;
      _school = null;
      _email =null;
      _userType = UserType.unknown;
      _gender =Gender.missing;
      _description ='';
      _ideologies =[];
      _interests =[];
      _religions =[];
      _title = null;
      _employer = null;
      notifyListeners();
      return false;
    }

  }

}
