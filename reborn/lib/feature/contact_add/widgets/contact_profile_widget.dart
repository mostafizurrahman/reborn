

import 'package:reborn/feature/ui/widget/ink_widget.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ContactProfileWidget extends StatefulWidget {
  const ContactProfileWidget({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ContactProfileState();
  }
}

class _ContactProfileState extends State<ContactProfileWidget> {
  final BehaviorSubject<bool> _nameBehavior = BehaviorSubject();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(color: CCAppTheme.primaryColor, width: 6),
            ),
            width: 100,
            height: 100,
            child: Icon(Icons.person, color: CCAppTheme.primaryColor, size: 75),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StreamBuilder(
              builder: _getTextFieldWidgets,
              stream: _nameBehavior.stream,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTextFieldWidgets(final BuildContext context, final AsyncSnapshot<bool> snapshot) {
    final hasExtended = snapshot.data ?? false;
    final List<Widget> textWidgets = [
      Row(
        children: [
          const Expanded(child: Spacer()),
          RIButton(
            dimension: 35,
            iconColor: CCAppTheme.primaryColor,
            onTap: () => _nameBehavior.sink.add(!hasExtended),
            radius: 17,
            iconData: hasExtended ? Icons.remove : Icons.add,
          ),
          const SizedBox(width: 16),
        ],
      ),
      TextField(
        decoration: InputDecoration(
          labelStyle: CCAppTheme.txt1,
          border: const UnderlineInputBorder(),
          labelText: 'First Name',
          isDense: true, // Added this
        ),
      ),
      const SizedBox(height: 12),
      TextField(
        decoration: InputDecoration(
          labelStyle: CCAppTheme.txt1,
          border: const UnderlineInputBorder(),
          labelText: 'Last Name',
          isDense: true, // Added this
        ),
      ),
    ];
    if (hasExtended) {}

    return Column(
      children: textWidgets,
    );
  }
}
