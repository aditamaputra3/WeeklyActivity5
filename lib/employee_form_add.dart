import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:office_crud/employee_model.dart';

import 'restapi.dart';



class EmployeeFormAdd extends StatefulWidget {
  const EmployeeFormAdd({super.key});

  @override
  _EmployeeFormAddState createState() => _EmployeeFormAddState();
}

class _EmployeeFormAddState extends State<EmployeeFormAdd> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final birthday = TextEditingController();
  final adress = TextEditingController();
  String gender = 'Male';

  late Future<DateTime?> selectedDate;
  String date = "-";

  DataService ds = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Employee Form Add"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Full Name'),
            ),
          ),
          // Gender
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    filled: false, border: InputBorder.none),
                value: gender,
                onChanged: (String? newValue) {
                  if (kDebugMode) {
                    print(newValue);
                  }

                  setState(() {
                    gender = newValue!;
                  });
                },
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ),
          // Birthday
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: birthday,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Birthday",
              ),
              onTap: () {
                showDialogPicker(context);
              },
            ),
          ),
          // Phone
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Phone Number",
              ),
            ),
          ),
          // Email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email Address",
              ),
            ),
          ),
          // Address
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: adress,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Address",
              ),
            ),
          ),
          // Submit Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen, elevation: 0),
                onPressed: () async {
                  List response = jsonDecode(await ds.insertEmployee(
                      "63476ceb99b6c11c094bd5ed",
                      name.text,
                      phone.text,
                      email.text,
                      adress.text,
                      gender,
                      birthday.text,
                      "-"));

                  List<EmployeeModel> employee =
                      response.map((e) => EmployeeModel.fromJson(e)).toList();

                  if (employee.length == 1) {
                    Navigator.pop(context, true);
                  } else {
                    if (kDebugMode) {
                      print(response);
                    }
                  }
                },
                child: const Text("SUBMIT"),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // Date Picker
  void showDialogPicker(BuildContext context) {
    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    selectedDate.then((value) {
      setState(() {
        if (value == null) return;

        final DateFormat formatter = DateFormat.yMMMMd('en_US');
        final String formattedDate = formatter.format(value);
        birthday.text = formattedDate;
      });
    }, onError: (err) {
      if (kDebugMode) {
        print(err);
      }
    });
  }
}