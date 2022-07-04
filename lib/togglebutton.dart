import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  Function? onTap;
  ToggleButton({
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool on = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
          setState(() {
            on = !on;
          });
        },
        child: Container(
          width: 100,
          height: 40,
          color: Colors.grey[300],
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 100),
            alignment:
                on == false ? Alignment.centerLeft : Alignment.centerRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500]!,
                    offset: const Offset(3, 3),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-3, -3),
                      blurRadius: 5,
                      spreadRadius: 0),
                ],
                //color: on == false ? Colors.red : Colors.blue,
              ),
              child: Center(
                child: Text(
                  on == false ? "Off" : "On",
                  style:
                      TextStyle(color: on == false ? Colors.red : Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
