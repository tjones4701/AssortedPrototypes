
using System;
using System.Collections.Generic;

namespace GameManager
{

    public struct PlayerTurn
    {
        private PlayerInterface player;
        public float MaxDuration;

        internal PlayerInterface Player { get => player; set => player = value; }
    }
    partial class GameInstance
    {
        public GameManager GameManager { get; set; }
        public string GameName { get; set; }
        public string GameId { get; set; }
        public List<PlayerInterface> Players { get; set; }
        public GameInstanceStates GameState { get; set; }
        public List<PlayerTurn> Turns { get; set; }
        public int CurrentTurn { get; set; }
        public int CurrentRound { get; set; }

        public float DefaultMaxDuration { get; set; }

        public GameInstance()
        {

        }



        public PlayerInterface GetPlayerById(string PlayerId)
        {
            foreach (var player in Players)
            {
                if (player.PlayerId == PlayerId)
                {
                    return player;
                }
            }
            return null;
        }

        public bool IsJoinable(PlayerInterface player)
        {
            return this.GameState == GameInstanceStates.WAITING;
        }

        public void OnRegister()
        {

        }
        public void OnDeRegister()
        {

        }

        public void Init(GameManager gameManager, string gameName, string gameId = null)
        {
            Players = new List<PlayerInterface>();
            GameState = GameInstanceStates.WAITING;
            GameName = gameName;
            GameManager = gameManager;
            if (gameId == null)
            {
                gameId = GameManager.GenerateRandomId();
            }
            GameManager.Register(this);
            OnInit();
        }

        public void Join(PlayerInterface playerInterface)
        {
            if (IsJoinable(playerInterface))
            {
                playerInterface.GameJoin(this);
                Players.Add(playerInterface);
                playerInterface.Game = this;
                OnPlayerJoin(playerInterface);
            }
            else
            {
                throw new Exception($"Player {playerInterface.PlayerId} not able to join.");
            }
        }

        public void RoundStart()
        {
            var newTurnOrder = new List<PlayerTurn>();
            foreach (var player in Players)
            {
                PlayerTurn turn = new PlayerTurn();
                turn.Player = player;
                turn.MaxDuration = DefaultMaxDuration;
                newTurnOrder.Add(turn);
            }
            OnRoundStart();
            Turns = newTurnOrder;
            CurrentTurn = 0;
            TurnStart();
        }

        public void RoundEnd()
        {

            OnRoundEnd();
            foreach (var player in this.Players)
            {
                player.RoundEnd(this.CurrentRound);
            }
            RoundStart();
        }
        public void TurnStart()
        {
            int MaxTurns = Turns.Count;
            if (CurrentTurn >= MaxTurns)
            {
                RoundEnd();
            }
            else
            {
                var playerTurn = GetPlayerTurn();
                if (playerTurn == null)
                {
                    throw new Exception("No Players Turn!");
                }

                OnTurnStart((PlayerTurn)playerTurn);
                foreach (var player in this.Players)
                {
                    player.TurnStart(((PlayerTurn)playerTurn).Player);
                }
            }
        }

        public PlayerTurn? GetPlayerTurn(int? turnIndex = null)
        {
            if (turnIndex == null)
            {
                turnIndex = CurrentTurn;
            }

            if (turnIndex != null && turnIndex >= 0 && turnIndex < this.Turns.Count)
            {
                return this.Turns[(int)turnIndex];
            }
            return null;
        }

        public int GetMaxTurns()
        {
            return Turns.Count - 1;
        }

        public void TurnEnd(bool forced, float duration)
        {


            Console.WriteLine(CurrentTurn + "/" + GetMaxTurns());
            PlayerTurn? playerTurn = GetPlayerTurn();
            if (playerTurn == null)
            {
                throw new Exception("No players turn to end!");
            }

            OnTurnEnd((PlayerTurn)playerTurn, forced, duration);
            foreach (var player in this.Players)
            {
                player.TurnEnd(((PlayerTurn)playerTurn).Player);
            }
            CurrentTurn = CurrentTurn + 1;

            if (CurrentTurn > GetMaxTurns())
            {
                RoundEnd();
            }
            else
            {
                TurnStart();
            }
        }

        public void GameEnd()
        {
            this.OnGameEnd();
            this.GameState = GameInstanceStates.FINISHED;
        }
        public void GameStart()
        {
            this.GameState = GameInstanceStates.STARTED;
            this.OnGameStart();

            RoundStart();
        }

        // Hooks, should eventually make these actually event driven.
        public virtual void OnInit() { }
        public virtual void OnRoundStart() { }
        public virtual void OnRoundEnd() { }
        public virtual void OnTurnStart(PlayerTurn playerTurn) { }
        public virtual void OnTurnEnd(PlayerTurn playerTurn, bool forced, float duration) { }
        public virtual void OnGameEnd() { }
        public virtual void OnGameStart() { }

        public virtual void OnPlayerJoin(PlayerInterface player) { }


    }

    enum GameInstanceStates
    {
        WAITING,
        STARTED,
        FINISHED
    }
}