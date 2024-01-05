import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/show_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceCheck extends StatefulWidget {
  const ServiceCheck({super.key});

  @override
  State<ServiceCheck> createState() => _ServiceCheckState();
}

class _ServiceCheckState extends State<ServiceCheck> {
  int selectedIndex = -1;
  List<String> options = ["입력 속도 불만", "기능 미흡", "더 이상 필요하지 않음", "기타"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "탈퇴 사유 입력"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "탈퇴 사유",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemExtent: 40,
                itemBuilder: (context, index) {
                  bool isSelected = (index == selectedIndex);
                  return ListTile(
                    onTap: () {
                      setState(() {
                        isSelected = !isSelected;
                        if (isSelected) {
                          selectedIndex = index;
                        }
                      });
                    },
                    splashColor: Colors.transparent,
                    leading: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: SvgPicture.asset(
                        (index == selectedIndex)
                            ? 'images/radio_button_selected.svg'
                            : 'images/radio_button_unselected.svg',
                      ),
                    ),
                    title: Text(
                      selectionColor: Colors.white,
                      options[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "의견 제출",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                minLines: 4,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: '텍스트를 입력하세요.',
                  hintStyle: const TextStyle(
                      color: Color(0xFFAEAEB2),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF7C7C80)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF7C7C80)),
                  ),
                  filled: true, // Set filled to true
                  fillColor: Color(0xFF444446),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "서비스 이용과정에서 불편했던 부분을 기재해주시면 서비스 개선에 참고하도록 하겠습니다.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  selectedIndex != -1
                      ? CustomPopUp.showPopupText(
                          context, "탈퇴가 완료 되었습니다.", 30, 16)
                      : null;
                },
                child: Container(
                  width: double.maxFinite,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: selectedIndex != -1
                          ? Color(0xFFDBFF00)
                          : Color(0xFFAEAEB2)),
                  child: Center(
                    child: Text(
                      "탈퇴",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF242426)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
