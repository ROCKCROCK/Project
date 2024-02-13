import 'package:angle_one/otppage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class aadhar_page extends StatefulWidget {
  const aadhar_page({super.key});

  @override
  State<aadhar_page> createState() => _aadhar_pageState();
}

class _aadhar_pageState extends State<aadhar_page> {
  final aadharedditor = TextEditingController();
  List<String> languageOptions = ['English', 'Hindi', 'Spanish'];
  String selectedLanguage = 'English';
  bool isChecked = false;
  bool showWarning = false;
  bool hasFinishedEditing = false;
  Color getButtonColor() {
    if (isAadharNumberValid(aadharedditor.text) && isChecked) {
      return Colors.blue[900]!;
    } else {
      return Colors.grey;
    }
  }

  bool isAadharNumberValid(String aadharNumber) {
    return aadharNumber.length == 12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Image.asset('assets/angle.png', height: 125, width: 125),
        backgroundColor: Colors.white,
        elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(0.7), // Adjust the height of the line
        //   child: Container(
        //     color: Colors.grey, // Change the color of the line
        //     height: 1.0,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/aadhar.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: const Text('Powered by',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 20,
                          ),
                          child: Image.asset(
                            'assets/setu.png',
                            height: 25,
                            width: 75,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Document Name', // Replace with the actual document name
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Adjust spacing as needed
                    Row(
                      children: [
                        Icon(Icons.description_outlined,
                            color: Colors
                                .blue[700]), // Replace with the desired icon
                        const SizedBox(width: 10),
                        const Text('ANGELOne_KYC_Onboarding_\nForm.pdf',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight
                                    .bold)), // Replace with the document type
                      ],
                    ),
                    const Divider(), // Add a horizontal line
                    const Text(
                      'You are eSigning this document using your\nAaadhar.to complete eSigning,an OTP will be \nsent to your mobile number linked to Aadhaar.', // Replace with actual content
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter your Aadhar Number/VID',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: aadharedditor,
                        maxLength: 12,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (aadharedditor) {
                          // Show warning only when typing and the length is not 12
                          setState(() {
                            showWarning = hasFinishedEditing &&
                                aadharedditor.isNotEmpty &&
                                aadharedditor.length != 12;
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            hasFinishedEditing = true;
                          });
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (showWarning)
                        const Text(
                          'Please enter a valid Aadhar Number/VID',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Review terms and condititons',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                isDense: true,
                                value: selectedLanguage,
                                items: languageOptions.map((String language) {
                                  return DropdownMenuItem<String>(
                                    value: language,
                                    child: Text(language),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedLanguage = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.play_arrow, color: Colors.blue[900]),
                                SizedBox(width: 5),
                                Text('Play Audio',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text(
                          'I agree to the terms and conditions',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add functionality for Cancel button
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                              onPressed:
                                  isAadharNumberValid(aadharedditor.text) &&
                                          isChecked
                                      ? () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      otp_page()));
                                        }
                                      : null,
                              child: Text(
                                'Send OTP',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: getButtonColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
