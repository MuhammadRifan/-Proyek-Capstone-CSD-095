import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../core/helper/permission.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/user_db_service.dart';
import '../../core/widget/crop_image.dart';
import '../../core/widget/flushbar.dart';
import '../../core/widget/text_fied.dart';
import '../screen_wrapper.dart';

class AddUserData extends StatefulWidget {
  const AddUserData({Key? key}) : super(key: key);

  @override
  State<AddUserData> createState() => _AddUserDataState();
}

class _AddUserDataState extends State<AddUserData> {
  bool _checkDoctor = false;

  final _ctrlName = TextEditingController();
  final _ctrlAdress = TextEditingController();
  final _ctrlPhone = TextEditingController();
  final _ctrlStrv = TextEditingController();

  final _focusNodeName = FocusNode();
  final _focusNodeAddress = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeStrv = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  bool _loading = false;

  @override
  void dispose() {
    _ctrlName.dispose();
    _ctrlAdress.dispose();
    _ctrlPhone.dispose();
    _ctrlStrv.dispose();

    _focusNodeName.dispose();
    _focusNodeAddress.dispose();
    _focusNodePhone.dispose();
    _focusNodeStrv.dispose();
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
                    Image.asset("assets/images/heart.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Data User",
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FieldInput(
                              hint: "Name",
                              controller: _ctrlName,
                              focusNode: _focusNodeName,
                              canNext: true,
                              maxLength: 50,
                              onSubmitted: (value) {
                                FocusScope.of(context).requestFocus(
                                  _focusNodeAddress,
                                );
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field is required";
                                } else if (val.length < 3) {
                                  return "Name must at least 3 characters";
                                }
                              },
                            ),
                            FieldInput(
                              hint: "Address",
                              controller: _ctrlAdress,
                              focusNode: _focusNodeAddress,
                              canNext: true,
                              maxLength: 100,
                              onSubmitted: (value) {
                                FocusScope.of(context).requestFocus(
                                  _focusNodePhone,
                                );
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field is required";
                                } else if (val.length < 5) {
                                  return "Address must at least 5 characters";
                                }
                              },
                            ),
                            FieldInput(
                              hint: "Phone",
                              controller: _ctrlPhone,
                              focusNode: _focusNodePhone,
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
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                clearFocus();
                                pickImage();
                              },
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width - 50,
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
                                              "Add your photo",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkDoctor,
                                  onChanged: (val) => setState(
                                    () => _checkDoctor = val!,
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => _checkDoctor = !_checkDoctor,
                                    ),
                                    child: const Text(
                                      "Register as a Veteriner",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (_checkDoctor)
                                ? FieldInput(
                                    hint:
                                        "STRV (Surat Tanda Registrasi Veteriner)",
                                    controller: _ctrlStrv,
                                    focusNode: _focusNodeStrv,
                                    numberKeyboard: true,
                                    onSubmitted: (value) {
                                      _focusNodeStrv.unfocus();
                                    },
                                    validator: (val) {
                                      if (_checkDoctor && val!.isEmpty) {
                                        return "This field is required";
                                      }
                                    },
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                clearFocus();

                                if (_formKey.currentState!.validate()) {
                                  if (_image == null) {
                                    Alert.error(
                                      context: context,
                                      msg: "Please insert your photo",
                                    );
                                  }
                                  setState(() => _loading = true);

                                  var userData =
                                      context.read<AuthService>().userData;

                                  await context
                                      .read<UserDatabaseService>()
                                      .updateUserData(
                                        uid: userData!.uid,
                                        name: _ctrlName.text,
                                        phone: _ctrlPhone.text,
                                        picture: _image!,
                                        address: _ctrlAdress.text,
                                        strv: (_checkDoctor)
                                            ? _ctrlStrv.text
                                            : null,
                                        jenis: (_checkDoctor) ? 1 : 0,
                                      );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ScreenWrapper(),
                                    ),
                                  );

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
    _focusNodeAddress.unfocus();
    _focusNodePhone.unfocus();
    _focusNodeStrv.unfocus();
  }
}
