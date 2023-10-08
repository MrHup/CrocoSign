import 'package:country_picker/country_picker.dart';
import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountryPickerWidget extends StatefulWidget {
  CountryPickerWidget(this.controller, {super.key});
  TextEditingController controller;

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  void getCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          widget.controller.text = country.displayNameNoCountryCode;
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
        // Optional. Styles the text in the search field
        searchTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getCountry,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Globals.backgroundColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.controller.text.isNotEmpty
                    ? widget.controller.text
                    : 'Select a country',
                style: TextStyle(
                  color: widget.controller.text.isNotEmpty
                      ? Colors.black
                      : Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
