import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/one_draft.dart';

class Drafts extends StatefulWidget {
  const Drafts({super.key});

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  List<String> drafts = [
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
    "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱㄱ 모두 다시 내년에 모여서 즐겁게 보내봐요~🥸 다시 캠핑의 끝을 달려봅시다용. 앞으로",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Draft(text: drafts[index]),
      itemCount: drafts.length,
      shrinkWrap: true,
    );
  }
}
