import 'package:reborn/feature/contact_add/rx_contact_entry/contact_entry_bloc.dart';
import 'package:reborn/feature/data_model/static_data.dart';
import 'package:reborn/feature/menu/app_bar_widget.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/base_widget/base_contact_widget.dart';
import '../widget/ink_widget.dart';
import 'widgets/contact_profile_widget.dart';

class ContactEntryWidget extends BaseContactWidget {
  const ContactEntryWidget({Key? key, Object? args}) : super(key: key, arguments: args);

  @override
  State<StatefulWidget> createState() {
    return _ContactEntryState();
  }
}

class _ContactEntryState extends State<ContactEntryWidget> {


  @override
  Widget build(BuildContext context) {
    final String title = widget.getData(key: "title");
    final bool isSecret = (widget.getData(key: "secret") as bool?) ?? false;
    final SecretTapType tapType =
        (widget.getData(key: ArgsKey.secretType) as SecretTapType?) ?? SecretTapType.noSecret;
    return BlocProvider(
      create: (context) => ContactEntryBloc(tapType: tapType),
      child: Scaffold(
        appBar: ContactAppBar(
          title: title + (isSecret ? "(Secret)" : ""),
          onTapDone: _onTapDone,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ContactProfileWidget(),
                      Divider(height: 1),
                      TextField(),
                      Container(
                        color: Colors.red,
                        height: 880,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: screenData.width,
                color: Colors.pinkAccent,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTapDone() {
    debugPrint("Abai Ada");
  }
}
