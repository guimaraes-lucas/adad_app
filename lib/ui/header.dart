import 'dart:math';

import 'package:flutter/material.dart';
import 'package:adad_app/blocs/floating_cards_bloc.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FloatingCardsBloc floatingCardBloc =
        Provider.of<FloatingCardsBloc>(context);

    return StreamBuilder(
      stream: floatingCardBloc.topPercentage.stream,
      initialData: floatingCardBloc.topPercentage.value,
      builder: (_, AsyncSnapshot<double> snapshot) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (snapshot.data == 100) {
              floatingCardBloc.animateTopEventSink.add(AnimateTopToUpEvent());
            } else if (snapshot.data == 0) {
              floatingCardBloc.animateTopEventSink.add(AnimateTopToDownEvent());
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/adad-logo.png'),
                    height: 30,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Lucas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Trueno',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Transform.rotate(
                angle: -(pi / 100 * snapshot.data),
                child: Opacity(
                  opacity: 0.5,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
