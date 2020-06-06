import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool ohTurn = true;
  List <String> displayXnO = ['','','','','','','','',''];
  int ohScore = 0;
  int exScore = 0;
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  static var myFont = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3)
  );
  static var myFontWhite = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Player X', style: myFontWhite,),
                          Text(exScore.toString(), style: myFontWhite,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Player O', style: myFontWhite,),
                          Text(ohScore.toString(), style: myFontWhite,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700])
                      ),
                      child: Center(
                        child: Text(
                          displayXnO[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
            ),
          ),
        ],
      ),
    );
  }
  void _tapped(int index){
    setState(() {
      if(ohTurn && displayXnO[index].isEmpty){
        displayXnO[index] = 'O';
      }
      else if (!ohTurn && displayXnO[index].isEmpty){
        displayXnO[index] = 'X';
      }
      _checkWinner(ohTurn);
      ohTurn = !ohTurn;
    });
  }
  void _checkWinner(bool ohTurn){
    List <String> winCombinations = ['', '', '', '', '', '', '', ''];
    winCombinations[0] = displayXnO[0] + displayXnO[1] + displayXnO[2];//Top Horizontal
    winCombinations[1] = displayXnO[3] + displayXnO[4] + displayXnO[5];//Mid Horizontal
    winCombinations[2] = displayXnO[6] + displayXnO[7] + displayXnO[8];//Bot Horizontal
    winCombinations[3] = displayXnO[0] + displayXnO[3] + displayXnO[6];//Left Vertical
    winCombinations[4] = displayXnO[1] + displayXnO[4] + displayXnO[7];//Mid Vertical
    winCombinations[5] = displayXnO[2] + displayXnO[5] + displayXnO[8];//Right Vertical
    winCombinations[6] = displayXnO[0] + displayXnO[4] + displayXnO[8];//Diagonal
    winCombinations[7] = displayXnO[2] + displayXnO[4] + displayXnO[6];//Diagonal

    if(winCombinations.contains('XXX') || winCombinations.contains('OOO')){
      _showWinDialog();
    }
    else if(checkFull()){
      _displayDraw();
    }
  }
  void _showWinDialog(){
    String currentPlayer = '';
    if(ohTurn){
      currentPlayer = 'O';
      ohScore +=1;
    }else{
      currentPlayer = 'X';
      exScore += 1;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("The winner is "+currentPlayer+"!", textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again?'),
                onPressed: (){
                  initializeBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );

  }
  void initializeBoard(){
    setState(() {
      displayXnO = ['','','','','','','','',''];
    });
  }

  // ignore: missing_return
  bool checkFull(){
    var iterarorBoard = displayXnO.iterator;

    while(iterarorBoard.moveNext()){
      if(iterarorBoard.current.isEmpty){
        return false;
      }
    }
    return true;
  }
  void _displayDraw(){
    initializeBoard();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("It's a Draw!", textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                child: Text('Play again?'),
                onPressed: (){
                  initializeBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
}