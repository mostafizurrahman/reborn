import 'package:reborn/feature/data_model/entity/service_entity.dart';
import 'package:reborn/feature/data_model/sqlite_manager.dart';
import 'package:reborn/feature/home/rx_secret/secret_bloc.dart';
import 'package:reborn/feature/home/rx_secret/secret_events.dart';
import 'package:reborn/utility/app_enum.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/screen_data.dart';
import 'package:flutter/material.dart';

import '../../utility/image_ext.dart';

class HomePrivateWidget extends HomeSecretWidget {
  @override
  BoxDecoration getShadow() {
    return CCAppTheme.shadowDec.copyWith(color:   Colors.transparent);

  }

  @override
  TextStyle get header1 => CCAppTheme.txtHL2;
  @override
  TextStyle get header3 => CCAppTheme.txtHL3;
  @override
  TextStyle get txt1 => CCAppTheme.txt1;
  @override
  TextStyle get header2 => CCAppTheme.txtHL2;
  @override
  List<dynamic> get contacts => [];//sqlDatabase.privateList;
  @override
  String get secretTitle => "PRIVATE";
  @override
  String get lowerTitle => "Private";
  @override
  String get contactDescription => "Your private contacts is here!";
  @override
  String get emptyDescription => "You have no private contact. Tap to add one!";

  const HomePrivateWidget({Key? key, required SecretBloc secretBloc})
      : super(key: key, secretBloc: secretBloc);

  @override
  Color get background => Colors.grey.shade200;

  @override
  Widget get secretIcon => Container(
        decoration: iconShadow,
        child: const Icon(Icons.private_connectivity_outlined, color: Colors.pinkAccent, size: 40),
      );

  @override
  void onTapRight() {
    secretBloc.add(SecretInitEvent());
    secretBloc.add(SecretHomeTapEvent(secretTapType: SecretTapType.tapRightPrivate));
  }

  @override
  void onTapParent() {
    secretBloc.add(SecretInitEvent());
    secretBloc.add(SecretHomeTapEvent(secretTapType: SecretTapType.tapParentPrivate));
  }
}

class HomeSecretWidget extends StatelessWidget {
  final SecretBloc secretBloc;
  Color get background => const Color.fromARGB(200, 30, 30, 75);
  Widget get secretIcon => Container(
        decoration: iconShadow.copyWith(color: Colors.pinkAccent),
        child: ImageExt.get("icons/ic_incognito.png", widgetHeight: 40, widgetWidth: 40),
      );
  List<dynamic> get contacts => [];//sqlDatabase.secretList;
  String get secretTitle => "SECRET";
  String get lowerTitle => "Secret";
  String get contactDescription => "Your privacy protected secret contacts.";
  String get emptyDescription => "You have no secret contact. Tap to add one!";
  TextStyle get header1 => CCAppTheme.txtHL2.copyWith(color: Colors.white);
  TextStyle get header3 => CCAppTheme.txtHL3.copyWith(color: Colors.grey.shade300);
  TextStyle get header2 => CCAppTheme.txtHL1;
  TextStyle get txt1 =>
      CCAppTheme.txt1.copyWith(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold);
  BoxDecoration get iconShadow =>
      CCAppTheme.shadowDec.copyWith(borderRadius: const BorderRadius.all(Radius.circular(25)));

  BoxDecoration getShadow() {
    const borderColor = Colors.pinkAccent;
    const background = Colors.transparent;
    final shadowColor = Colors.black54.withAlpha(180);
    return BoxDecoration(
      color: background,
      border: Border.all(color: borderColor, width: 2),
      borderRadius: CCAppTheme.borderRadius,
      boxShadow: [
        BoxShadow(
          color: shadowColor.withAlpha(80),
          spreadRadius: 4,
          blurRadius: 12,
        ),
      ],
    );
  }

  const HomeSecretWidget({Key? key, required this.secretBloc}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final contactList = [];//sqlDatabase.secretList;
    final _widget = _getContent();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text("$secretTitle  CONTACTS", style: header2),
          ),
          const SizedBox(height: 12),
          contactList.isEmpty ? _getMaterialTapWidget(_widget, onTapParent) : _widget,
        ],
      ),
    );
  }

  Widget _getMaterialTapWidget(final Widget innerWidget, final VoidCallback onTapAction) {
    return Material(
      borderRadius: CCAppTheme.borderRadius,
      color: background,
      child: Ink(
        child: InkWell(
          borderRadius: CCAppTheme.borderRadius,
          focusColor: Colors.blue,
          splashColor: Colors.blueAccent,
          onTap: onTapAction,
          child: innerWidget,
        ),
      ),
    );
  }

  Widget _getContent() {
    return Container(
      decoration: getShadow(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Row(
              children: [
                Expanded(child: Text("$secretTitle CONTACTS", style: header1)),
                secretIcon,
                const SizedBox(width: 12),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Text(contacts.isEmpty ? emptyDescription : contactDescription, style: header3),
          ),
          _getAddRow(),
        ],
      ),
    );
  }

  void onTapRight() {
    secretBloc.add(SecretInitEvent());
    secretBloc.add(SecretHomeTapEvent(secretTapType: SecretTapType.tapRight, isSecret: true));
  }

  void onTapParent() {
    secretBloc.add(SecretInitEvent());
    secretBloc.add(SecretHomeTapEvent(secretTapType: SecretTapType.tapParent, isSecret: true));
  }

  Widget _getAddRow() {
    final _width = (screenData.width - 40.5) / 2;
    return SizedBox(
      height: 75,
      child: Padding(
        padding: contacts.isEmpty
            ? const EdgeInsets.only(
                top: 12,
              )
            : const EdgeInsets.only(top: 8),
        child: Center(
          child: contacts.isEmpty
              ? Text("Add Some - $lowerTitle Contacts", style: txt1)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(9)),
                      child: Container(
                        height: 60,
                        width: _width,
                        color: Colors.white,
                        child: _getMaterialTapWidget(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("ADD CONTACT"),
                              SizedBox(width: 8),
                              Icon(Icons.add_circle),
                            ],
                          ),
                          onTapParent,
                        ),
                      ),
                    ),


                    const VerticalDivider(width: 2.5, color: Colors.pinkAccent),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(9)),
                      child: Container(
                        height: 60,
                        width: _width,
                        color: Colors.white,
                        child: _getMaterialTapWidget(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("MANAGE"),
                              SizedBox(width: 8),
                              Icon(Icons.manage_accounts),
                            ],
                          ),
                          onTapRight,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
