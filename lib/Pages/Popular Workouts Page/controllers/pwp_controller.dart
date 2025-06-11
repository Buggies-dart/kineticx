
import 'package:flutter/material.dart';
import 'package:kineticx/API/controllers/api_controller.dart';
import 'package:kineticx/Utils/pngs.dart';

class PopularWorkoutPageController{
static final getBodyParts = bodyPart;

}

class BodyAndImageUrlNotifier extends ChangeNotifier{
  String bodyPart = 'chest';
  String imageUrl = Images.chestImage;


void updateBodyPart(String newBodyPart) {
bodyPart = newBodyPart;
notifyListeners();
  }

void updateImageUrl(String newImageUrl) {
imageUrl = newImageUrl;
notifyListeners();
  }
}