import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/screens/profile_service/service_check.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileService extends StatefulWidget {
  const ProfileService({super.key});

  @override
  State<ProfileService> createState() => _ProfileServiceState();
}

class _ProfileServiceState extends State<ProfileService> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363638),
      appBar: const CustomAppBar(text: "위갭 탈퇴"),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "😢 위갭 탈퇴",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "탈퇴하기 전에 아래 내용을 꼭 확인하세요.",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    "탈퇴하시면 프로필과 사용자 정보가 위갭에서 영구적으로 제거됩니다.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2. ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    "게시물, 댓글 및 메시지는 계정에서 연결 해제됩니다.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "3. ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    "게시물, 댓글 및 메시지는 삭제 되지 않습니다.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "4. ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    "서비스 이용 과정에서 불편한 점이 있으셨다면, [서비스 개선 문의]로 내용을 남겨주세요.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: isChecked
                        ? SvgPicture.asset("images/checked.svg")
                        : SvgPicture.asset("images/un_checked.svg")),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "위의 내용을 확인하였습니다.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                isChecked
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServiceCheck(),
                        ))
                    : null;
              },
              child: Container(
                width: double.maxFinite,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isChecked
                        ? const Color(0xFFDBFF00)
                        : const Color(0xFFAEAEB2)),
                child: const Center(
                  child: Text(
                    "탈퇴 하기",
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
    );
  }
}
