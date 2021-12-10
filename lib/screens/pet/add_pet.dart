import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/helper/permission.dart';
import '../../core/widget/crop_image.dart';
import '../../core/widget/flushbar.dart';
import '../../core/widget/text_fied.dart';

class AddPet extends StatefulWidget {
  const AddPet({Key? key}) : super(key: key);

  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final _ctrlName = TextEditingController();
  final _ctrlPet = TextEditingController();

  final _focusNodeName = FocusNode();
  final _focusNodePet = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  bool _loading = false;
  String? _kelamin;

  @override
  void dispose() {
    _ctrlName.dispose();
    _ctrlPet.dispose();

    _focusNodeName.dispose();
    _focusNodePet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFA1A1),
                Colors.white,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.05,
                ),
                child: Column(
                  children: [
                    Image.asset("assets/heart.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pet Register",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.75,
                minChildSize: 0.75,
                builder: (_, scrollController) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                              child: Column(
                                children: [
                                  FieldInput(
                                    controller: _ctrlName,
                                    focusNode: _focusNodeName,
                                    hint: "Name",
                                    canNext: true,
                                    maxLength: 15,
                                    onSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                        _focusNodePet,
                                      );
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      }
                                    },
                                  ),
                                  FieldInput(
                                    controller: _ctrlPet,
                                    focusNode: _focusNodePet,
                                    hint: "Pet (ex. Cat, Dog, etc.)",
                                    maxLength: 15,
                                    onSubmitted: (value) {
                                      _focusNodePet.unfocus();
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            RadioListTile(
                              title: const Text("Male"),
                              value: "M",
                              groupValue: _kelamin,
                              onChanged: (String? val) {
                                setState(() {
                                  _kelamin = val;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Female"),
                              value: "F",
                              groupValue: _kelamin,
                              onChanged: (String? val) {
                                setState(() {
                                  _kelamin = val;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width - 50,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 20,
                                ),
                                decoration: (_image == null)
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade700,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                    : null,
                                child: (_image != null)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          _image!,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Expanded(
                                            child: Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              size: 50,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 15,
                                            ),
                                            child: Text(
                                              "Add your pet photo",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                clearFocus();

                                if (_formKey.currentState!.validate()) {
                                  if (_kelamin == null) {
                                    return Alert.error(
                                      context: context,
                                      msg: "Please select the gender",
                                    );
                                  }
                                  if (_image == null) {
                                    return Alert.error(
                                      context: context,
                                      msg: "Please insert your pet photo",
                                    );
                                  }

                                  setState(() => _loading = true);

                                  setState(() => _loading = false);
                                  log("message");
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF5C5C),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 30,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 20,
                                ),
                                child: (_loading)
                                    ? const SpinKitChasingDots(
                                        color: Colors.white,
                                        size: 25,
                                      )
                                    : const Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final permissionStatus = await Permissions.getPhotosPermission();

    if (permissionStatus == PermissionStatus.granted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = await CropImage.crop(
          image: File(pickedFile.path),
        );

        setState(() {});
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Can't access gallery",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: const Text(
            "Please enable gallery access in system settings",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void clearFocus() {
    _focusNodeName.unfocus();
    _focusNodePet.unfocus();
  }
}
