import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_game/business_logic/cubit.dart';
import 'package:xo_game/business_logic/states.dart';
import 'package:xo_game/modules/widgets/alert_dialog.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit()..gameInitialization(),
      child: BlocConsumer<GameCubit,GameStates>(
          listener:(context,state) {
            if( state is GameFinishedWithWinnerState )
            {
              awesomeDialog(
                  context:context,
                  message:"The Winner is ${state.winner}",
                  dialogType:DialogType.success,
                  messageColor: Colors.green,
                  dialogTitle: "Congratulations",
                  gameEnd: true
              );
            }
            else if( state is GameFinishedWithoutWinnerState )
            {
              awesomeDialog(
                  context:context,
                  message:"Game finished without Winner !",
                  dialogType:DialogType.error,
                  messageColor: Colors.red,
                  dialogTitle: "Game Over",
                  gameEnd: true
              );
            }
            else if( state is BoxAlreadyHaveDataState )
            {
              awesomeDialog(
                  context:context,
                  message:"This Box already has Data !",
                  dialogType:DialogType.warning,
                  messageColor: Colors.red,
                  dialogTitle: "Warning",
                  gameEnd: false
              );
            }
          },
          builder: (context,state) {
            return Scaffold(
              appBar: AppBar(title: const Text("X - O",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.5),)),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),
                child: Column(
                  children:
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children:
                      [
                        Expanded(flex:4,child: playerItem("Current Player",17.5,FontWeight.w500,Colors.black)),
                        const SizedBox(width: 15),
                        Expanded(flex:2,child: playerItem(GameCubit.getInstance(context).currentPlayer,25,FontWeight.bold,Colors.deepPurpleAccent)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                        child: Center(child: gameContent(GameCubit.getInstance(context)))
                    ),
                    const SizedBox(height: 10,),
                    MaterialButton(
                      color: Colors.deepPurple,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      ),
                      onPressed: ()
                      {
                        GameCubit.getInstance(context).gameInitialization();
                      },
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      child: const Text("Restart Game",style: TextStyle(color: Colors.white,fontSize: 18),),
                    )
                  ],
                ),
              ),
            );
          }
      )
    );
  }

  // Todo: used on The Row( current player : playerName )
  Widget playerItem(String title,double fontSize,FontWeight fontWeight,Color color){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12.5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.withOpacity(0.22),
      ),
      child: Text(title,style: TextStyle(color: color,fontSize: fontSize,fontWeight: fontWeight),)
    );
  }

  Widget gameContent(GameCubit cubit){
    return GridView.builder(
        shrinkWrap: true,
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 8,mainAxisSpacing: 8,childAspectRatio: 0.8),
        itemBuilder: (context,i){
          return boxItem(index:i,context:context,cubit:cubit);
        }
    );
  }

  Widget boxItem({required int index,required BuildContext context,required GameCubit cubit}){
    return InkWell(
      onTap: ()
      {
        cubit.boxClicked(index: index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: cubit.boxesData[index] == cubit.player1 ? Colors.orange :
          cubit.boxesData[index] == cubit.player2 ? Colors.deepOrange : Colors.grey.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
          child: Text(
              cubit.boxesData[index] == cubit.player1 ? cubit.player1 :
              cubit.boxesData[index] == cubit.player2 ? cubit.player2 : ""
          ),
        ),
      ),
    );
  }
}
