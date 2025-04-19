

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kineticx/Firebase/firebase_auth.dart';
import 'package:kineticx/Utils/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    super.key,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {

final ImagePicker picker = ImagePicker();
File? selectedImage;

Future getImage()async{
var image = await picker.pickImage(source: ImageSource.gallery);
  if ( image != null) {
setState(() {
selectedImage = File(image.path);
  });
saveImage(image.path);
  }
}

Future<void> saveImage(String path) async {
final prefs = await SharedPreferences.getInstance();
  await prefs.setString('saved_image', path);
  }

Future<void> loadImage() async {
final prefs = await SharedPreferences.getInstance();
String? savedImagePath = prefs.getString('saved_image');
if (savedImagePath != null) {
setState(() {
selectedImage = File(savedImagePath);
});
}
}

@override
void initState() {
super.initState();
loadImage();
  }

  @override
  Widget build(BuildContext context) {
return Column( crossAxisAlignment: CrossAxisAlignment.center,
children: [

GestureDetector( onTap: (){getImage();
 },
  child: selectedImage != null?  CircleAvatar(  radius: MediaQuery.of(context).size.width/7.5,
  backgroundImage:  FileImage(selectedImage!),
  ) : CircleAvatar( backgroundColor: whiteColor, radius: MediaQuery.of(context).size.width/7.5,
child: Icon(MdiIcons.camera),
) 
),
SizedBox( height: 10),
Text('John Doe', style: Theme.of(context).textTheme.titleLarge!.copyWith( color: Theme.of(context).primaryColorDark),),
SizedBox( height: 10),

InkWell( onTap: ()  async{
await  FirebaseAuthMethods(FirebaseAuth.instance, context).signOutUser();
      },
child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('Logout', style: Theme.of(context).textTheme.bodyMedium),
SizedBox( width: 5  ),
Icon(Icons.logout, color: Theme.of(context).colorScheme.onPrimaryFixedVariant)
],),
      )
      ],
      );
  }
}