import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';
import 'package:intl/intl.dart';

import 'models/tugas.dart';

class TambahTugas extends StatefulWidget {
  @override
  _TambahTugasState createState() => _TambahTugasState();
}

class _TambahTugasState extends State<TambahTugas> {
  final matakuliahController = TextEditingController();
  final uraianTugasController = TextEditingController();
  final deadlineController = TextEditingController();

  int userId;

  DbHelper dbHelper = new DbHelper();
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        deadlineController.text = DateFormat("dd MMMM y").format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tugas')),
      body: Container(
          constraints: BoxConstraints.expand(),
          // is used to create container full screen with filled content.
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: matakuliahController,
                                  decoration: InputDecoration(
                                    hintText: 'matakuliah',
                                    labelText: 'Matakuliah',
                                    icon: Icon(Icons.input),
                                  ),
                                ),
                                TextFormField(
                                  controller: uraianTugasController,
                                  decoration: InputDecoration(
                                    hintText: 'uraian ringkas tugas',
                                    labelText: 'Uraian Tugas',
                                    icon: Icon(Icons.edit),
                                  ),
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                ),
                                TextFormField(
                                  controller: deadlineController,
                                  decoration: InputDecoration(
                                    hintText: 'select date',
                                    labelText: deadlineController.text,
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ])),
                ElevatedButton(
                    onPressed: () {
                      //input ke tabel tugas
                      Tugas tugas = new Tugas(
                          matakuliahController.text,
                          uraianTugasController.text,
                          DateFormat("yyyy-MM-dd").format(selectedDate),
                          'belum');
                      dbHelper.insertTugas(tugas);
                      dbHelper.selectAllTugas().then((mapList) {
                        mapList.forEach((element) {
                          print(element);
                        });
                      });

                      Navigator.pushNamed(context, '/dashboard',
                          arguments: userId);
                    },
                    child: Text('Simpan'))
              ],
            ),
          )),
    );
  }
}
