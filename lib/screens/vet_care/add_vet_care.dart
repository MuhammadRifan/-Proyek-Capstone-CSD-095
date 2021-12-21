import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petto/core/helper/permission.dart';
import 'package:petto/core/widget/button.dart';
import 'package:petto/core/widget/crop_image.dart';
import 'package:petto/core/widget/flushbar.dart';
import 'package:petto/core/widget/text_fied.dart';

class AddVetCare extends StatefulWidget {
  const AddVetCare({Key? key}) : super(key: key);

  @override
  State<AddVetCare> createState() => _AddVetCareState();
}

class _AddVetCareState extends State<AddVetCare> {
  final _ctrlName = TextEditingController();
  final _ctrlDesc = TextEditingController();
  final _ctrlAddress = TextEditingController();
  final _ctrlCity = TextEditingController();
  final _ctrlPhone = TextEditingController();
  final _ctrlHour = TextEditingController();
  final Set _ctrlDay = {};

  final _focusNodeName = FocusNode();
  final _focusNodeDesc = FocusNode();
  final _focusNodeAddress = FocusNode();
  final _focusNodeCity = FocusNode();
  final _focusNodePhone = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.grey.shade900,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Image.asset("assets/images/heart.png"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "My Vet Care",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                          // crossAxisAlignment: CrossAxisAlignment.end,
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
                                    maxLength: 20,
                                    onSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                        _focusNodeDesc,
                                      );
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      } else if (val.length < 5) {
                                        return "Name must at least 5 characters";
                                      }
                                    },
                                  ),
                                  FieldInput(
                                    controller: _ctrlDesc,
                                    focusNode: _focusNodeDesc,
                                    hint: "Description",
                                    maxLength: 150,
                                    maxLines: 5,
                                    canNext: true,
                                    onSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                        _focusNodeAddress,
                                      );
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      }
                                    },
                                  ),
                                  FieldInput(
                                    controller: _ctrlAddress,
                                    focusNode: _focusNodeAddress,
                                    hint: "Address",
                                    canNext: true,
                                    maxLength: 20,
                                    onSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                        _focusNodeCity,
                                      );
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      }
                                    },
                                  ),
                                  FieldInput(
                                    controller: _ctrlCity,
                                    focusNode: _focusNodeCity,
                                    hint: "City",
                                    canNext: true,
                                    maxLength: 20,
                                    onSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                        _focusNodePhone,
                                      );
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      }
                                    },
                                  ),
                                  FieldInput(
                                    controller: _ctrlPhone,
                                    focusNode: _focusNodePhone,
                                    hint: "Phone",
                                    maxLength: 15,
                                    numberInput: true,
                                    onSubmitted: (value) {
                                      _focusNodePhone.unfocus();
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "This field is required";
                                      } else if (val.length < 10) {
                                        return "Phone must at least 10 characters";
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 5),
                                  FieldDateTime(
                                    ctrlText: _ctrlHour,
                                    timeInput: true,
                                    borderOutline: false,
                                    hint: "Work Hour",
                                    onSaved: (val) {},
                                  ),
                                  const SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Work Day",
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ButtonWeek(
                                        week: "Sun",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Sun")) {
                                            _ctrlDay.remove("Sun");
                                          } else {
                                            _ctrlDay.add("Sun");
                                          }
                                        },
                                      ),
                                      ButtonWeek(
                                        week: "Mon",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Mon")) {
                                            _ctrlDay.remove("Mon");
                                          } else {
                                            _ctrlDay.add("Mon");
                                          }
                                        },
                                      ),
                                      ButtonWeek(
                                        week: "Tue",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Tue")) {
                                            _ctrlDay.remove("Tue");
                                          } else {
                                            _ctrlDay.add("Tue");
                                          }
                                        },
                                      ),
                                      ButtonWeek(
                                        week: "Wed",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Wed")) {
                                            _ctrlDay.remove("Wed");
                                          } else {
                                            _ctrlDay.add("Wed");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ButtonWeek(
                                        week: "Thu",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Thu")) {
                                            _ctrlDay.remove("Thu");
                                          } else {
                                            _ctrlDay.add("Thu");
                                          }
                                        },
                                      ),
                                      ButtonWeek(
                                        week: "Fri",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Fri")) {
                                            _ctrlDay.remove("Fri");
                                          } else {
                                            _ctrlDay.add("Fri");
                                          }
                                        },
                                      ),
                                      ButtonWeek(
                                        week: "Sat",
                                        onTap: () {
                                          clearFocus();
                                          if (_ctrlDay.contains("Sat")) {
                                            _ctrlDay.remove("Sat");
                                          } else {
                                            _ctrlDay.add("Sat");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                clearFocus();
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
                                              "Add your vet care photo",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade400,
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
                                    child: const Text(
                                      "View Vet Care",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    clearFocus();

                                    if (_formKey.currentState!.validate()) {
                                      if (_ctrlDay.isEmpty) {
                                        return Alert.error(
                                          context: context,
                                          msg: "Please select one work day",
                                        );
                                      }
                                      if (_image == null) {
                                        return Alert.error(
                                          context: context,
                                          msg:
                                              "Please insert your vet care photo",
                                        );
                                      }

                                      setState(() => _loading = true);

                                      // Function go here

                                      setState(() => _loading = false);
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
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
    _focusNodeDesc.unfocus();
    _focusNodeAddress.unfocus();
    _focusNodeCity.unfocus();
    _focusNodePhone.unfocus();
  }
}
