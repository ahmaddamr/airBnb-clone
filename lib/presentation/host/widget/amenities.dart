import 'package:flutter/material.dart';

class Amenities extends StatefulWidget {
  const Amenities(
      {super.key,
      required this.type,
      required this.startValue,
      required this.decreaseValue,
      required this.increaseValue});
  final String type;
  final int startValue;
  final Function decreaseValue;
  final Function increaseValue;

  @override
  State<Amenities> createState() => _AmenitiesState();
}

class _AmenitiesState extends State<Amenities> {
  int? valueDigit;
  @override
  void initState() {
    super.initState();
    valueDigit = widget.startValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.type,
          style: const TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                widget.decreaseValue();
                valueDigit = valueDigit! - 1;
                if (valueDigit! < 0) {
                  valueDigit = 0;
                }
                setState(() {});
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              valueDigit.toString(),
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                widget.increaseValue();
                valueDigit = valueDigit! + 1;
                if (valueDigit! < 0) {
                  valueDigit = 0;
                }
                setState(() {});
              },
              icon: const Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }
}
