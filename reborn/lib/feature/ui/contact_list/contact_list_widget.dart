
import 'package:flutter/material.dart';
import 'package:reborn/feature/ui/widget/base_widget/base_contact_widget.dart';


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
