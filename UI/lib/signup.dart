import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _selectedCountryCode = '+1'; // Default country code
  String _selectedCountry = 'United States'; // Default country
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _dobError;
  String? _zipcodeError;
  String? _phoneError;

  final List<String> _countries = [
    'United States',
    'India',
    'United Kingdom',
    'Australia',
    'Japan'
  ];

  final List<String> _countryCodes = ['+1', '+91', '+44', '+61', '+81'];

  void validateFirstName(String value) {
    setState(() {
      _firstNameError = value.isEmpty ? 'First name is required' : null;
    });
  }

  void validateLastName(String value) {
    setState(() {
      _lastNameError = value.isEmpty ? 'Last name is required' : null;
    });
  }

  void validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    setState(() {
      _emailError = value.isEmpty
          ? 'Email is required'
          : (!emailRegex.hasMatch(value) ? 'Enter a valid email address' : null);
    });
  }

  void validateDOB(String value) {
    setState(() {
      _dobError = value.isEmpty ? 'Date of birth is required' : null;
    });
  }

  void validateZipcode(String value) {
    setState(() {
      _zipcodeError = value.isEmpty ? 'Zipcode is required' : null;
    });
  }

  void validatePhoneNumber(String value) {
    setState(() {
      _phoneError = value.isEmpty
          ? 'Phone number is required'
          : (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)
              ? 'Phone number must be 10 digits'
              : null);
    });
  }

  void _handleSignUp() {
    validateFirstName(_firstNameController.text);
    validateLastName(_lastNameController.text);
    validateEmail(_emailController.text);
    validateDOB(_dobController.text);
    validateZipcode(_zipcodeController.text);
    validatePhoneNumber(_phoneNumberController.text);

    if (_firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _dobError == null &&
        _zipcodeError == null &&
        _phoneError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sign Up Successful for $_selectedCountry ($_selectedCountryCode${_phoneNumberController.text})',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth > 600 ? 400 : screenWidth * 0.9,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    errorText: _firstNameError,
                  ),
                  onChanged: validateFirstName,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    errorText: _lastNameError,
                  ),
                  onChanged: validateLastName,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: validateEmail,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: const Icon(Icons.calendar_today),
                    errorText: _dobError,
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      _dobController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                      validateDOB(_dobController.text);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                      _selectedCountryCode =
                          _countryCodes[_countries.indexOf(value)];
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _zipcodeController,
                  decoration: InputDecoration(
                    labelText: 'Zipcode',
                    errorText: _zipcodeError,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: validateZipcode,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _selectedCountryCode,
                        items: _countryCodes.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountryCode = value!;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Country Code'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          errorText: _phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: validatePhoneNumber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
