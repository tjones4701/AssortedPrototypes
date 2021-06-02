using System;
namespace GameManager
{

    partial class PlayerInterface
    {
        public GameInstance Game { get; set; }
        public string PlayerId = null;
        public Boolean IsMyTurn = false;

        public PlayerInterface()
        {

        }

        public void Init(string PlayerId)
        {
            this.PlayerId = PlayerId;
            this.OnInit();
        }

        public void GameJoin(GameInstance gameInstance)
        {
            Game = gameInstance;
            Console.WriteLine(gameInstance.GetType());
            OnGameJoin(gameInstance);
        }

        public void GameLeave()
        {
            Game = null;
        }


        public void TurnStart(PlayerInterface player = null)
        {

            this.IsMyTurn = player.PlayerId == this.PlayerId;

            if (this.IsMyTurn)
            {
                this.OnMyTurnStart();
            }

            this.OnTurnStart(player);
        }
        public void TurnEnd(PlayerInterface player)
        {
            if (this.IsMyTurn)
            {
                this.IsMyTurn = false;
                this.OnMyTurnEnd();
            }
            this.OnTurnEnd(player);
        }
        public void GameStart()
        {
            this.OnGameStart();
        }
        public void GameEnd()
        {
            this.OnGameEnd();
        }
        public void RoundStart(int roundNumber)
        {
            this.OnRoundStart(roundNumber);
        }
        public void RoundEnd(int roundNumber)
        {
            this.OnRoundEnd(roundNumber);
        }

        public virtual void OnTurnEnd(PlayerInterface player) { }
        public virtual void OnTurnStart(PlayerInterface player) { }
        public virtual void OnMyTurnStart() { }
        public virtual void OnMyTurnEnd() { }
        public virtual void OnGameStart() { }
        public virtual void OnGameEnd() { }
        public virtual void OnInit() { }
        public virtual void OnGameJoin(GameInstance gameInstance) { }
        public virtual void OnGameLeave() { }
        public virtual void OnRoundStart(int roundNumber) { }
        public virtual void OnRoundEnd(int roundNumber) { }
    }
}