import 'package:flutter/material.dart';

class Country {
  String name;
  String phoneCode;

  Country(this.name, this.phoneCode);
}

class PhoneCountryDropdown extends StatefulWidget {
  final Function(Country)? onCountryChanged; // Make onCountryChanged nullable

  // Make key optional
  const PhoneCountryDropdown({super.key, this.onCountryChanged});

  @override
  _PhoneCountryDropdownState createState() => _PhoneCountryDropdownState();
}

class _PhoneCountryDropdownState extends State<PhoneCountryDropdown> {
  List<Country> countries = [
    Country('IDN', 'ID'),
    Country('USA', 'US'),
    Country('AUS', 'AU'),
    // Add more countries here
  ];

  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = countries.firstWhere((country) => country.name == 'IDN');
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Country>(
      value: selectedCountry,
      onChanged: (Country? newValue) {
        setState(() {
          selectedCountry = newValue;
          widget.onCountryChanged?.call(newValue!); // Use null-aware call
        });
      },
      items: countries.map<DropdownMenuItem<Country>>((Country country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Text('${country.name} (${country.phoneCode})'),
        );
      }).toList(),
    );
  }
}
