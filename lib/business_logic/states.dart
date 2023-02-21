abstract class GameStates{}

class InitialAppState extends GameStates{}

class GameInitializationSuccessState extends GameStates{}

class AllBoxesFilledWithDataState extends GameStates{}

class MoveToAnotherPlayerState extends GameStates{}

class BoxAlreadyHaveDataState extends GameStates{
  late String message;
  BoxAlreadyHaveDataState({required this.message});
}

class GameFinishedWithWinnerState extends GameStates{
  late String winner;
  GameFinishedWithWinnerState({required this.winner});
}

class GameFinishedWithoutWinnerState extends GameStates{}

class OneOfThemWinTheGameState extends GameStates{}
