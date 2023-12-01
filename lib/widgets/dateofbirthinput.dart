import 'package:flutter/material.dart';
import '../src/color.dart';
class RoundedDateInputField extends StatefulWidget {
  const RoundedDateInputField({
    Key? key,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  final String hintText;
  final IconData icon;

  @override
  _RoundedDateInputFieldState createState() => _RoundedDateInputFieldState();
}

class _RoundedDateInputFieldState extends State<RoundedDateInputField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: 0.8 * MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: myPinkColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: selectedDate == null
                  ? Text(
                      widget.hintText,
                      style: TextStyle(color: Colors.grey),
                    )
                  : Text(
                      "${selectedDate!.toLocal()}".split(' ')[0],
                      style: TextStyle(color: Colors.black),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
