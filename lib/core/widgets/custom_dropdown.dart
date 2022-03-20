import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {Key key,
      this.menu,
      this.callBack,
      this.hintText,
      this.value,
      this.unAvilabletimes,
      this.selectedTime,
      this.isNotDeafult = false})
      : super(key: key);
  final List<String> menu;
  final String hintText;
  final List<String> unAvilabletimes;
  final String selectedTime;
  final bool isNotDeafult;
  final Function(String) callBack;
  final String value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value != null ? value : null,
      hint: FittedBox(fit: BoxFit.contain, child: Text(hintText)),
      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          filled: true,
          fillColor: Colors.white,
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        callBack(newValue);
      },
      items: menu.map<DropdownMenuItem<String>>((String value) {
        print(value);
        return dropdownMenuItem(
            selectedValue: selectedTime, isNotDeafult: isNotDeafult, unavailableValues: unAvilabletimes, value: value);
      }).toList(),
    );
  }

  DropdownMenuItem<String> dropdownMenuItem(
      {String selectedValue = "", List<String> unavailableValues, String value = "", bool isNotDeafult = false}) {
    var items = DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(color: Colors.black),
      ),
    );

    if (isNotDeafult) {
      if ((selectedValue != null && value == selectedValue) ||
          (unavailableValues != null && unavailableValues.contains(value))) {
        items = DropdownMenuItem<String>(
          value: value,
          enabled: false,
          child: Text(
            value,
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }

    return items;
  }
}
