import 'package:flutter/material.dart';
import '../src/color.dart';

class RoundedGenderSelectionField extends StatelessWidget {
  const RoundedGenderSelectionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: myPinkColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          hintText: "Gender",
          border: InputBorder.none,
        ),
        items: ['Male', 'Female']
            .map((gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) {
          // Handle the selected gender
          print(value);
        },
        isExpanded: true,
      ),
    );
  }
}
