import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

// ignore: must_be_immutable
class StepperRegistration extends StatefulWidget {
  StepperRegistration({this.activeStep = 1, super.key});
  int activeStep;

  @override
  State<StepperRegistration> createState() => _StepperRegistrationState();
}

class _StepperRegistrationState extends State<StepperRegistration> {
  final int _dotCount = 3;
  // static const double bubbleWidth = 6;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DotStepper(
          dotCount: _dotCount,
          dotRadius: 15,

          /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
          activeStep: widget.activeStep,
          shape: Shape.circle,
          spacing: 35,
          indicator: Indicator.jump,
          lineConnectorsEnabled: true,

          tappingEnabled: true,

          /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
          onDotTapped: (tappedDotIndex) {
            setState(() {
              widget.activeStep = tappedDotIndex;
            });
          },

          // DOT-STEPPER DECORATIONS
          fixedDotDecoration: const FixedDotDecoration(
            // strokeWidth: bubbleWidth,
            color: Color.fromARGB(255, 0, 0, 0),
          ),

          indicatorDecoration: const IndicatorDecoration(
            // strokeWidth: bubbleWidth,
            color: Colors.green,
          ),
          lineConnectorDecoration: const LineConnectorDecoration(
            color: Color.fromARGB(255, 174, 206, 175),
            strokeWidth: 0,
            linePadding: 2,
          ),
        ),
      ),
    );
  }
}
