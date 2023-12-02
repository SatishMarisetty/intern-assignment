import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'utilities.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme
                .of(context)
                .hintColor,
          ),
        ),
        items: list
            .map((String item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
            .toList(),
        value: dropdownValue,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              )),
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}