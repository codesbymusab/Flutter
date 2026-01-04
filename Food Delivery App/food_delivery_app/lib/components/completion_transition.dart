import 'package:flutter/material.dart';

class CompletionTransition extends StatefulWidget {
  const CompletionTransition({super.key});

  @override
  State<CompletionTransition> createState() => _CompletionTransitionState();
}

class _CompletionTransitionState extends State<CompletionTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 2000),
    vsync: this,
  )..repeat();

  late final Animation<double> animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCirc,
  );

  late final AnimationController _controller2 = AnimationController(
    duration: Duration(milliseconds: 1500),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> animation2 = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCirc,
  );
  late final Animation<double> animation3 = Tween<double>(
    begin: 1,
    end: 1.2,
  ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInCirc));

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        width: 400,
        child: AlertDialog(
          alignment: AlignmentDirectional.center,
          backgroundColor: Colors.amberAccent,
          actionsAlignment: MainAxisAlignment.start,
          actionsPadding: EdgeInsets.only(left: 20, right: 20, bottom: 40),

          title: Column(
            children: [
              Text(
                'Order Placed Successfully',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.white,
                radius: BorderRadius.circular(20),
                thickness: 2,
              ),
            ],
          ),
          actions: [
            Text(
              'Thankyou!! We have recieved your order',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
          content: ScaleTransition(
            scale: animation3,
            child: Stack(
              children: [
                Center(
                  child: RotationTransition(
                    turns: animation,
                    child: Icon(Icons.donut_large_rounded, size: 150),
                  ),
                ),
                Center(
                  child: RotationTransition(
                    turns: animation,
                    child: Icon(
                      Icons.donut_large_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),

                Center(child: Icon(Icons.done_rounded, size: 40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
