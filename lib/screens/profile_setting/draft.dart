import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/drafts.dart';
import 'package:flutter_app_gap/components/no_draft.dart';
import 'package:flutter_app_gap/components/one_draft.dart';

class ProfileDraft extends StatefulWidget {
  const ProfileDraft({super.key});
  @override
  State<ProfileDraft> createState() => _ProfileDraftState();
}

class _ProfileDraftState extends State<ProfileDraft> {
  bool hasDraft = true;
  @override
  void initState() {
    super.initState();
    hasDraft = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF363638),
        appBar: CustomAppBar(text: "작성중인 갭"),
        body: hasDraft ? Drafts() : NoDraft());
  }
}
