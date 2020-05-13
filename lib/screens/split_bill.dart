import 'package:flutter/material.dart';
import 'package:split_bill/util/hexcolor.dart';

class SplitBillScreen extends StatefulWidget {
  @override
  _SplitBillScreenState createState() => _SplitBillScreenState();
}

class _SplitBillScreenState extends State<SplitBillScreen> {
  //creating the variable for the splitter
  int _tipPercentage = 0;
  int _personCounter = 1; //because person can not be zero
  double _billAmount = 0.0;
  Color _purple = HexColor("#6908D6");
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
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height *
                0.1), //margin is the outer spacing
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total per Person',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: _purple,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$${calculateTotalPerPerson( _billAmount,_personCounter,_tipPercentage)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: _purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 1, color: Colors.blueGrey.shade100),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixText: 'Bill Amount',
                      prefixIcon: Icon(Icons.attach_money),
                      // labelText: 'Bill Amount'
                    ),
                    onChanged: (String value) {
                      //this will record the user input what user is  typing before the form is submitted
                      try {
                        _billAmount = double.parse(value);
                        print(_billAmount);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Split',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter = _personCounter - 1;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: _purple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$_personCounter',
                            style: TextStyle(
                              color: _purple,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter >= 1) {
                                  _personCounter = _personCounter + 1;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: _purple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '\$${(calculateTotalTip(
                            _billAmount,
                            _personCounter,
                            _tipPercentage,
                          )).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Slider
                  Column(
                    children: <Widget>[
                      Text(
                        '$_tipPercentage %',
                        style: TextStyle(
                          color: _purple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //slider
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          divisions: 10,
                          inactiveColor: Colors.grey,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double val) {
                            setState(() {
                              _tipPercentage = val.round();
                              // print(_tipPercentage);
                            });
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson( double billAmount, int splitBy ,int tipPercentage) {
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage)+ billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int slpitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      //no go
    } else {
      totalTip = (billAmount *tipPercentage) / 100;
    }
    return totalTip;
  }
}
