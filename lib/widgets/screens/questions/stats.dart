import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/containers/glass_background_container.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';

class Stats extends StatelessWidget {
  final Map user;
  final int points;
  final int coins;
  final int lives;
  final Function stopTime;
  final Function penalty;
  final Function varMethod;
  final Function stoppageTime;
  const Stats(
      {super.key,
      required this.user,
      required this.points,
      required this.coins,
      required this.lives, required this.stopTime, required this.penalty, required this.varMethod, required this.stoppageTime});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 22,
          left: 75,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bolt,
                          color: Colors.black,
                          size: 28,
                        ),
                        TextWidget(
                          title: points.toString(),
                          fontSize: 13,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.heart_broken,
                          color: Colors.red,
                          size: 28,
                        ),
                        TextWidget(
                          title: lives.toString(),
                          fontSize: 13,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.donut_large,
                          color: Colors.yellow,
                          size: 28,
                        ),
                        TextWidget(
                          title: coins.toString(),
                          fontSize: 13,
                          color: Colors.black,
                        )
                      ],
                    )
                  ],
                ),
              ),
              GlassBackgroundContainer(
                radius: true,
                margin: 0,
                padding: 3,
                body: Row(children: [
                GestureDetector(
                  onTap: ()=>stoppageTime(),
                  child: Image.asset('assets/images/image90.png',fit: BoxFit.cover,width: 35,)),
                  const SizedBox(width: 5,),
                  GestureDetector(
                  onTap: ()=>penalty(),
                  child: Image.asset('assets/images/halfTime.png',fit: BoxFit.cover,width: 35,)),
                  const SizedBox(width: 5,),
                  GestureDetector(
                  onTap: ()=>varMethod(),
                  child: Image.asset('assets/images/VAR.png',fit: BoxFit.cover,width: 35,)),
                  const SizedBox(width: 5,),
                  GestureDetector(
                  onTap: ()=>stopTime(),
                  child: Image.asset('assets/images/stopTime.png',fit: BoxFit.cover,width: 35,)),
              ],))
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 4)),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.network(
                  user['selectedAvatar']['image'],
                  fit: BoxFit.cover,
                  height: 75,
                  width: 75,
                ),
              )),
        ),
      ],
    );
  }
}
