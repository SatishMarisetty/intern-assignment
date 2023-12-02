import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utilities.dart';
import 'DropDown.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.yellow,
      body:SingleChildScrollView(child: MyApp()),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    List changes = [];
    List restore = [];
    changes.add([text,size,colour,dropdownValue]);

    setState(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
    Future colorPickerDialog() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: colour,
              onColorChanged: (color){colour=color;},
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Ok', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );
    }
    return SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(onPressed: (){

                    setState(() {
                      if (changes.length > 1)
                    {
                      restore.add(changes.first);
                      changes.removeAt(0);
                    }
                      text=changes.last[0];
                      size=changes.last[1];
                      colour=changes.last[2];
                      dropdownValue=changes.last[3];
                      print("triggered 1");
                    });
                  }, child: Text('<- undo')),
                  Divider(),
                  TextButton(onPressed: (){

                    setState(() {
                      if (restore.length!=0)
                    {
                      print("triggered 2");
                      text=restore[0][0];
                      size=restore[0][1];
                      colour=restore[0][2];
                      dropdownValue=restore[0][1];
                      changes.add(restore.first);
                      restore.removeAt(0);
                    }

                    });
                  }, child: Text('redo ->'))
                ],
              ),//undo and redo
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(150, 0, 20, 0),
                        height: 250,
                        width: 250,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: ListView(
                          children: [
                            Center(child: Text('$text',style: TextStyle(fontFamily: dropdownValue,color: colour,fontSize: size,),)),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        child: Column(
                          children: [
                            Text('Font'),
                            DropDownMenu(),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Size'),
                                    Container(
                                      height: 70,
                                      width: 100,
                                      padding: EdgeInsets.all(5),
                                      child: NumberInputWithIncrementDecrement(
                                        controller: TextEditingController(),
                                        onChanged: (value) {
                                          size=value.toDouble();
                                        },
                                        onIncrement: (value) {
                                          size=value.toDouble();
                                        },
                                        onDecrement: (value) {
                                          size=value.toDouble();
                                        },
                                        min: 1,
                                        max: 50,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Colour'),
                                    MaterialButton(onPressed: colorPickerDialog,color: Colors.black,padding: EdgeInsets.all(5), child: Text('click me',style: TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 50,
                                width: 200,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Edit Text',
                                  ),
                                  onChanged: (value){text=value;},
                                ),
                              ),
                            ),
                            MaterialButton(onPressed: (){setState(() { changes.add([text,size,colour,dropdownValue]);});},color: Colors.black,padding: EdgeInsets.all(5), child: Text('Apply',style: TextStyle(color: Colors.white),)),
                          ],
                        ),
                      ),//Editing
                    ],
                  ),//Main 2
                ],
              ),//Main
            ],
          ),
        );
  }
}