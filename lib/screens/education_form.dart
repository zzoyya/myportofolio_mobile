import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _degree = "";
  String _major = "";

  DateTime? _startDate;
  DateTime? _endDate;

  String formatDate(DateTime? date) {
    if (date == null) return "Belum dipilih";

    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> selectDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      drawer: const LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Institution Name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Institution Name",
                    hintText: "Nama universitas atau sekolah",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _institution = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama institusi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Degree
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Degree",
                    hintText: "Contoh: Bachelor's Degree",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _degree = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Degree tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Major
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Major",
                    hintText: "Contoh: Computer Science",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _major = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Major tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Start Date
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => selectDate(true),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Start Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(formatDate(_startDate)),
                  ),
                ),
              ),

              // End Date
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => selectDate(false),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "End Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(formatDate(_endDate)),
                  ),
                ),
              ),

              // Save Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_startDate == null || _endDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Start Date dan End Date wajib dipilih!",
                              ),
                            ),
                          );
                          return;
                        }

                        if (_endDate!.isBefore(_startDate!)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "End Date tidak boleh sebelum Start Date!",
                              ),
                            ),
                          );
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Education berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Institution: $_institution'),
                                    Text('Degree: $_degree'),
                                    Text('Major: $_major'),
                                    Text(
                                      'Start Date: ${formatDate(_startDate)}',
                                    ),
                                    Text('End Date: ${formatDate(_endDate)}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
