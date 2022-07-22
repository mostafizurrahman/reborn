import 'package:reborn/feature/widget/base_widget/base_contact_widget.dart';
import 'package:flutter/material.dart';


class ContactListWidget extends BaseContactWidget {
  const ContactListWidget({Key? key, Object? args}) : super(key: key, arguments: args);

  @override
  State<StatefulWidget> createState() {
    return _ContactListState();
  }
}

class _ContactListState extends State<ContactListWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.pinkAccent,
      ),
    );
  }
}
