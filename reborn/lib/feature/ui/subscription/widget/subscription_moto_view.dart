


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';

class SubscriptionMotoView extends StatelessWidget {

  final List<LocalizedText> moto;

  const SubscriptionMotoView({Key? key, required this.moto}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: _getMotos(),
    ) ;
  }

  List<Widget> _getMotos() {
    List<Widget> widgets = [];
    for(final LocalizedText txt in moto) {
      widgets.add(
        Row(
          children: [
            SizedBox(
              width: 75,
              height: 75,
              child: Center(
                child: Icon(CupertinoIcons.circle_grid_hex_fill, color: Colors.redAccent,),
              ),
            ),
            SizedBox(width: 12),
            Expanded(child: Text(txt.en)),
          ],
        )
      );
    }


    return widgets;
  }
}