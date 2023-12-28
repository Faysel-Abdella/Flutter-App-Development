import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter_app_gap/screens/join/register_profile/lounge_select.dart';
import 'package:image_picker/image_picker.dart';

class NameRegisterPage extends StatefulWidget {
  const NameRegisterPage({Key? key}) : super(key: key);

  @override
  State<NameRegisterPage> createState() => _NameRegisterPageState();
}

class _NameRegisterPageState extends State<NameRegisterPage> {
  late TextEditingController _nameController;
  late bool _isNameIncorrect;
  late bool _isButtonNotYellow;

  final _focusNode = FocusNode();

  File? _image;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _isNameIncorrect = false;
    _isButtonNotYellow = true;

    // Set the focus on the text field when the screen is shown
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _checkName() {
    String profileName = _nameController.text;
    // Hi Kim's developer for the below use the actual real data
    // 아래의 김안녕님 개발자는 실제 실제 데이터를 사용합니다.
    if (profileName == "aaa") {
      // It is the condition where the inserted name is not correct or already used
      setState(() {
        _isNameIncorrect = true;
        _isButtonNotYellow = true;
      });
    } else {
      if (profileName.length == 3) {
        setState(() {
          _isNameIncorrect = false;
          _isButtonNotYellow = false;
        });
        // Perform actions for correct input
      }
    }

    if (profileName == "" || profileName.length < 3) {
      setState(() {
        _isButtonNotYellow = true;
        _isNameIncorrect = false;
      });
    }
  }

  void showBottomSheet(BuildContext context, text1, icon1, icon2, text2, btnTxt,
      [text3, icon3, pickFromGallery]) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: text3 != null ? 300 : 170,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              color: Color(0xFF545456)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon1,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text1,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async => await pickImage(),
                child: Row(
                  children: [
                    Image.asset(
                      icon2,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              text3 != null
                  ? Row(
                      children: [
                        Image.asset(icon3!),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(text3!),
                      ],
                    )
                  : const SizedBox.shrink(),
              CustomFreeButton(
                  height: 36,
                  textColor: Color(0xFF242426),
                  color: Color(0xFFDBFF00),
                  content: btnTxt)
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF363638),
        appBar: AppBar(
          backgroundColor: const Color(0xFF242426),
          elevation: 0,
          toolbarHeight: 64,
          centerTitle: true,
          title: const Text(
            "프로필 꾸미기",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 20.5,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                iconSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset("images/first_step.png"),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 18, bottom: 54),
                    child: const Text(
                      "WeGab (위갭) 에서 사용할 사진과 대화명을 넣어서\n프로필을 꾸며주세요.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showBottomSheet(
                            context,
                            "카메라",
                            "images/from_camera.png",
                            "images/from_gallary.png",
                            "사진 앨범",
                            "닫기");
                      },
                      child: _image == null
                          ? Image.asset("images/update_profile.png")
                          : Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  _image!,
                                  height: 96,
                                  width: 96,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    "images/edit-btn.png",
                                    width: 30,
                                    height: 30,
                                  ))
                            ])),
                  const SizedBox(
                    height: 36,
                  ),
                  Stack(children: [
                    TextField(
                      controller: _nameController,
                      focusNode: _focusNode,
                      autofocus: true,
                      cursorColor: const Color.fromRGBO(255, 255, 255, 1),

                      // Hi developer, use the maximum length of the normal name
                      maxLength: 3,
                      decoration: InputDecoration(
                          hintText: '대화명을 입력해주세요.',
                          hintStyle: const TextStyle(color: Color(0xFFAEAEB2)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: _isNameIncorrect
                              ? OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFFF0089)),
                                  borderRadius: BorderRadius.circular(12),
                                )
                              : (_nameController.text.length == 3
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFDBFF00)),
                                    )
                                  : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF7C7C80)),
                                    )),
                          suffixIcon: _isNameIncorrect
                              ? Image.asset(
                                  "images/warning.png",
                                  height: 16,
                                  width: 16,
                                )
                              : (_nameController.text.length == 3
                                  ? Image.asset(
                                      "images/correct.png",
                                      height: 16,
                                      width: 16,
                                    )
                                  : null),
                          filled: true,
                          fillColor: const Color(0xFF444446),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16)),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      // textAlign: TextAlign.center,
                      onChanged: (value) {
                        _checkName();
                      },
                    ),
                    if (_isNameIncorrect)
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            child: const Text(
                              "중복된 대화명입니다.",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFF0089)),
                            ),
                          ))
                  ]),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // margin: const EdgeInsets.only(top: 118),
                  height: 36,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: _isButtonNotYellow
                          ? MaterialStateProperty.all<Color>(
                              const Color(0xFFAEAEB2))
                          : MaterialStateProperty.all<Color>(
                              const Color(0xFFDBFF00)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BrandSelect(),
                          ));
                      // Handle button press
                    },
                    child: const Text(
                      "다음",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF242426),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
