import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class GameCubit extends Cubit<GameStates>{
  GameCubit() : super(InitialAppState());
  late String currentPlayer;
  late String winner;
  late int filledBoxesNumber;
  String player1 = "X";
  String player2 = "O";
  List<String> boxesData = ["","","","","","","","",""];
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
  
  // get Instance from This Cubit
  static GameCubit getInstance(BuildContext context){
    return BlocProvider.of<GameCubit>(context);
  }
  
  void gameInitialization(){
    winner = "";
    filledBoxesNumber = 0 ;  // Todo: when filled = 9 mean that all boxes have Data on It ( X or O )
    boxesData = ["","","","","","","","",""];
    currentPlayer = player1 ;
    emit(GameInitializationSuccessState());
  }

  Future<void> boxClicked({required int index}) async {
    if( filledBoxesNumber <= 8 )
      {
        if( boxesData[index].isEmpty )
          {
            boxesData[index] = currentPlayer ;
            filledBoxesNumber++;
            debugPrint("Filled Numbers is : $filledBoxesNumber , Data on index : $index become ${boxesData[index]}");
            currentPlayer == player1 ? currentPlayer = player2 : currentPlayer = player1;
            emit(MoveToAnotherPlayerState());
            // Todo: Check if The Game finished or not
            bool oneOfThePlayersWin = await checkTheEndOfTheGame();
            if( oneOfThePlayersWin )
              {
                debugPrint("Data on Boxes is $boxesData");
                emit(GameFinishedWithWinnerState(winner: winner));
              }
            else if ( filledBoxesNumber == 9 && oneOfThePlayersWin == false )
              {
                // Tapped on the last Box and there is no option for winning has achieved
                emit(GameFinishedWithoutWinnerState());
              }
          }
        else
          {
            emit(BoxAlreadyHaveDataState( message : "This Box already have Data !") );
          }
      }
  }

  Future<bool> checkTheEndOfTheGame() async {
    bool oneOfThemWin = false ;
    for( var item in winningOptions )
      {
        if( boxesData[item[0]] == player1 && boxesData[item[1]] == player1 && boxesData[item[2]] == player1 && player1 != "" )
        {
          oneOfThemWin = true;
          winner = player1;
          debugPrint("The Winner is : Player1 ");
          emit(OneOfThemWinTheGameState());
        }
        else if( boxesData[item[0]] == player2 && boxesData[item[1]] == player2 && boxesData[item[2]] == player2 && player2 != "" )
        {
          oneOfThemWin = true;
          winner = player2;
          debugPrint("The Winner is : Player2 ");
          emit(OneOfThemWinTheGameState());
        }
      }
    return oneOfThemWin;
  }

}