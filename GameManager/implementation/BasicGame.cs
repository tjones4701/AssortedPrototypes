using System;
using System.Collections.Generic;
using System.Timers;

namespace GameManager
{


    class GameSetup
    {
        public GameSetup()
        {
            Console.WriteLine("Starting Game");
            var gameManager = new GameManager();

            var players = new List<string>();
            players.Add("Bob");
            players.Add("James");
            players.Add("Michael");
            players.Add("Jannet");
            players.Add("Karen");

            var game = new BasicGameInstance();
            game.Init(gameManager, "My Test Game");
            foreach (var player in players)
            {
                var playerInstance = new BasicPlayer();
                playerInstance.Init(player);
                game.Join(playerInstance);
            }

            game.GameStart();
        }
    }

    class BasicPlayer : PlayerInterface
    {

        public static int MinNumber = 0;
        public static int MaxNumber = 5;
        public static int MinGuessDuration = 0;
        public static int MaxGuessDuration = 1000;

        public int CorrectGuesses = 0;
        int MyNumber { get; set; }
        bool isGuessing { get; set; }
        Timer myTimer { get; set; }

        public void Log(string content)
        {
            Console.WriteLine(this.PlayerId + '-' + content);
        }

        public BasicGameInstance GetGame()
        {
            return (BasicGameInstance)Game;
        }

        public override void OnMyTurnStart()
        {
            if (GetGame() == null)
            {
                Log("Game not set!");
                return;
            }
            else
            {
                Log("Found game!");
            }
            var rnd = new Random();
            MyNumber = rnd.Next(MinNumber, MaxNumber);
            GetGame().SetNumberToGuess(MyNumber);
            Log($"I have my random number, it is {MyNumber}");
        }

        public override void OnGameJoin(GameInstance gameInstance)
        {
            Log("Has Joined!");
        }
        public void Guess(Object source, ElapsedEventArgs e)
        {
            Random rnd = new Random();
            this.myTimer.Interval = rnd.Next(MinGuessDuration, MaxGuessDuration);
            var myGuess = rnd.Next(MinNumber, MaxNumber);

            if (Game == null)
            {
                Log("Game is null");
                return;
            }

            try
            {
                var isCorrect = GetGame().GuessNumber(this, myGuess);
                if (isCorrect)
                {
                    Log($"guessed {myGuess} and was correct");
                }
            }
            catch (Exception error)
            {
                Log(error.ToString());
            }

        }
        public override void OnInit()
        {
            Random rnd = new Random();
            myTimer = new Timer(rnd.Next(MinGuessDuration, MaxGuessDuration));
            myTimer.AutoReset = true;
        }

        public override void OnTurnStart(PlayerInterface player)
        {
            if (!this.IsMyTurn)
            {
                myTimer.Elapsed += this.Guess;
                myTimer.Start();
            }
        }
        public override void OnTurnEnd(PlayerInterface player)
        {
            isGuessing = false;
            myTimer.Stop();
        }
    }

    class BasicGameInstance : GameInstance
    {
        int NumberToGuess { get; set; }
        BasicPlayer correctPlayer { get; set; }

        public void Log(string content)
        {
            Console.WriteLine(content);
        }

        public List<BasicPlayer> GetPlayers()
        {
            var players = new List<BasicPlayer>();

            foreach (var player in Players)
            {
                players.Add(player as BasicPlayer);
            }
            return players;

        }


        public void SetNumberToGuess(int NumberToGuess)
        {
            this.NumberToGuess = NumberToGuess;
        }
        public bool GuessNumber(BasicPlayer player, int numberToGuess)
        {
            if (correctPlayer == null)
            {
                if (NumberToGuess == numberToGuess)
                {
                    TurnEnd(false, 0);
                    return true;
                }
            }

            return false;
        }


        public override void OnGameStart()
        {
            Log("Game started");
        }
        public override void OnGameEnd()
        {
            Log("Game started");
        }
        // Hooks, should eventually make these actually event driven.
        public override void OnInit()
        {
            Log("Initialised");
        }
        public override void OnRoundStart()
        {
            Log($"Round Started {this.CurrentRound}");
        }
        public override void OnRoundEnd()
        {
            List<BasicPlayer> players = GetPlayers();
            foreach (var player in players)
            {
                if (player.CorrectGuesses > 3)
                {
                    Log($"Game is over {player.PlayerId} has won!");
                    GameEnd();
                }
            }
            Log($"Round Ended {this.CurrentRound}");
        }
        public override void OnTurnStart(PlayerTurn playerTurn)
        {
            Log($"Turn started {playerTurn.Player.PlayerId}");
        }
    }

}
