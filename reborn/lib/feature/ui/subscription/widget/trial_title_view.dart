


import 'package:flutter/cupertino.dart';

class TrialTitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Text('How your free trial works'),
          Text('Loved by ${'7' + 'Million'}  People'),
          Text('${50} % off yearly subscription'),
          Text('Total due today \$${0.00}'),
        ],
      ),
    );
  }
}