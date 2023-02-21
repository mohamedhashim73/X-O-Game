/*
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currentPlayer ;
  late String winner ;
  late bool gameEnd ;
  int filledBoxedNumber = 0 ;
  late List<String> gameData ;
  // Todo: winning options mean Cases that Game will be end it & there will be a winner
  List<List<int>> winningOptions = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
  ];
  String player1 = "x";
  String player2 = "O";
  void gameInitialization(){
    gameEnd = false;
    filledBoxedNumber = 0 ;
    gameData = ["","","","","","","","",""];
    currentPlayer = player1;
  }

  @override
  void initState() {
    gameInitialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("X - O Game"),toolbarHeight: 45,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12.5),
        child: Column(
          children:
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Expanded(child: playerItem("Mohamed Hashim","X","images/mohamed.png")),
                SizedBox(width: 20),
                Expanded(child: playerItem("Saleh Gomaa","O","images/saleh.png")),
              ],
            ),
            const SizedBox(height: 20,),
            const Text("Current Player ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5),),
            Text(currentPlayer,style: const TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 30),),
            const SizedBox(height: 10,),
            Expanded(
                child: gameContent()
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              color: Colors.deepPurple,
              onPressed: ()
              {
                setState(() {
                  gameInitialization();
                });
              },
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: const Text("Reset Game",style: TextStyle(color: Colors.white,fontSize: 17),),
            )
          ],
        ),
      ),
    );
  }

  Widget playerItem(String playerName,String playerCode,String playerImage){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 12.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.withOpacity(0.22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          const CircleAvatar(radius: 28,backgroundColor: Colors.deepPurple,child: Icon(Icons.person,color: Colors.white,),),
          const SizedBox(height: 11,),
          FittedBox(fit:BoxFit.scaleDown,child: Text(playerName,style: TextStyle(fontSize: 17.5,fontWeight: FontWeight.w500),)),
          const SizedBox(height: 5,),
          Text(playerCode,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  Widget gameContent(){
    return GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 12.5,mainAxisSpacing: 12.5),
        itemBuilder: (context,index){
          return boxComponent(index,context);
        }
    );
  }

  Widget boxComponent(int index,BuildContext context){
    return InkWell(
      onTap: ()
      {
        if( gameData[index].isEmpty )
        {
          setState(()
          {
            gameData[index] = currentPlayer;
            filledBoxedNumber++;
          });
          boxTapped(index,context);
        }
        else
        {
          if( filledBoxedNumber != 9 )
          {
            ScaffoldMessenger.of(context).showSnackBar(snackBarContent("This item has been clicked before !"));
          }
          else
          {
            resetGame(context, "Game Finished without Winner !");
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        child: Text(gameData[index].isNotEmpty ? gameData[index] : "",style: const TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
      ),
    );
  }

  void boxTapped(int index,BuildContext context){
    checkGameStatus(context);
    if( gameEnd == true )
    {
      if( winner == player1 || winner == player2 )
      {
        ScaffoldMessenger.of(context).showSnackBar(snackBarContent("Game finished, Winner is $winner"));
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(snackBarContent("There is no Winner !"));
      }
      gameInitialization();
    }
    else
    {
      debugPrint("Filled boxes number is : $filledBoxedNumber by $currentPlayer ");
      setState(() {
        currentPlayer == player1 ? currentPlayer = player2 : currentPlayer = player1 ;
      });
    }
  }

  // Todo: to know if it end or not
  void checkGameStatus (BuildContext context) {
    if( filledBoxedNumber <= 9 )
      {
        for( var item in winningOptions ) {
          if( gameData[item[0]] == player1 && gameData[item[1]] == player1 && gameData[item[2]] == player1 )
          {
            setState(() {
              gameEnd = true ;
              winner = player1;
              return;
            });
          }
          else if( gameData[item[0]] == player2 && gameData[item[1]] == player2 && gameData[item[2]] == player2 )
          {
            setState(() {
              gameEnd = true ;
              winner = player2;
              return;
            });
          }
        }
      }
    else
    {
      setState(() {
        gameEnd = true ;
        winner = "No Winner";
      });
    }
  }

  SnackBar snackBarContent(String message){
    return SnackBar(
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.deepPurpleAccent,
      content: Container(
        width: double.infinity,
        height: 35,
        alignment: Alignment.center,
        child: FittedBox(fit:BoxFit.scaleDown,child: Text(message,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.5),)),
      ),
    );
  }

  void resetGame(BuildContext context,String message){
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(snackBarContent(message));
      gameInitialization();
    });
  }

}

 */