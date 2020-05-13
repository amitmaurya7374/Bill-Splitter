import 'package:flutter/material.dart';

class SplitBillScreen extends StatefulWidget {
  @override
  _SplitBillScreenState createState() => _SplitBillScreenState();
}

class _SplitBillScreenState extends State<SplitBillScreen> {
  //creating the variable for the splitter
  int _tipPercentage = 0;
  int _personCounter = 1; //because person can not be zero
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BillSplitter',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}