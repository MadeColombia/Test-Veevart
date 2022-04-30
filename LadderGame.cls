public class LadderGame {
    
    public static void start(){
        SnakeNLadder game = new SnakeNLadder();
		game.startGame();
    }
	

	
    class SnakeNLadder {
    //WinPont es el punto limite del tablero, de esta manera calculamos is gana o no el juego    
    Integer WinPoint = 25;
    // Se crean map para las snakes y ladders, funciona de manera similar a las list de python (key, value)
	Map<Integer, Integer>snake = new Map<Integer,Integer>();
	Map<Integer, Integer>ladder = new Map<Integer,Integer>();
	{
		snake.put(14,4);
		snake.put(19,8);
		snake.put(22,20);
		snake.put(24,16);

		ladder.put(3,11);
		ladder.put(6,17);
		ladder.put(9,18);
		ladder.put(10,12);
	}
       //Estos son los dice que da un valor aleatorio de 1 a 6
       public Integer rollDice() {
		Integer dice = Integer.valueOf((Math.random() * 6));
        System.debug(dice);
		return dice;
	}
    
        //En PlayerValueDice, nos encargamos de sumar ubicación con el numero de los dados
    public Integer PlayerValueDice(Integer playerPosition, Integer dice) {
        
		Integer playerNewPosition = playerPosition + dice;

		if (playerNewPosition > WinPoint)
			return playerPosition;		
		//Se realizan condicionales para definir si el usuario está en una escalera ó snake
		if (null != snake.get(playerNewPosition)) {
			System.debug('Encontraste una serpiente!');
			playerNewPosition= snake.get(playerNewPosition) ;
		}
		
		if (null != ladder.get(playerNewPosition)) {
			System.debug('Muy bien!, encontraste una escalera');
			playerNewPosition= ladder.get(playerNewPosition);
		}
		
		return playerNewPosition;
	}
    
        //Realiza un check si tu posicion es igual a WinPoint, de esta manera, se sabe si ganaste o no.
    public boolean check_Win(Integer playerPosition){
        return WinPoint <= playerPosition;
        
    }
    
        // Esta es la clase que empieza el juego, se encarga de set las variables principales.
    public void startGame(){
        Integer player1Position = 0, player2Position = 0;
        Integer currentPlayer= -1;
        
        //Se decide manejar el ENTER de una manera distinta ya que manejar un input solo en código apex no es posible,
        //por lo cual, se maneja un booleano el cual se encarga de lanzar true (es decir, que siga la partida),
        //hasta que alguno de los jugadores pase el marcador máximo de los 25.
        boolean nPressed = true;
		Integer diceValue = 0;
        
        //Logica del juego
        do {
			System.debug(currentPlayer == -1 ? '\nTurno de primer jugador' : '\nTurno de segundo jugador');
			System.debug('Jugador lanza los dados');
			diceValue = rollDice();
			
            //evalua pos de player 1, realiza el cambio a partir del numero del dado y le hace un update. Al final hace check
            //si el jugador ya ganó.
			if (currentPlayer == -1) {
				player1Position = PlayerValueDice(player1Position, diceValue);
				System.debug('Posición del primer jugador: '+ player1Position);
				System.debug('Posición del segundo jugador: '+ player2Position);

				if (check_Win(player1Position)) {
					System.debug('Felicidades!, el primer jugador ha ganado el juego.');
                    nPressed = false;
					return;
				}
			} else {
				player2Position = PlayerValueDice(player2Position, diceValue);
				System.debug('Posición del primer jugador: '+ player1Position);
				System.debug('Posición del segundo jugador: '+ player2Position);
                
				if (check_Win(player2Position)) {
					System.debug('Felicidades!, el segundo jugador ha ganado el juego.');
                    nPressed = false;
					return;
				}
			}
			currentPlayer = -currentPlayer;
		} while (nPressed = true);
    }
}
}