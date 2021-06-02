
using System.Collections.Generic;
using System;

namespace GameManager
{

    partial class GameManager
    {

        public List<GameInstance> Games { get; set; }

        public GameManager()
        {
            this.Games = new List<GameInstance>();
        }


        public List<GameInstance> GetJoinableGames(PlayerInterface player)
        {
            List<GameInstance> foundGames = new List<GameInstance>();
            foreach (var game in this.Games)
            {
                if (game.IsJoinable(player))
                {
                    foundGames.Add(game);
                }
            }
            return foundGames;
        }

        public GameInstance GetGameInstanceById(string id)
        {
            foreach (var game in this.Games)
            {
                if (game.GameId == id)
                {
                    return game;
                }
            }
            return null;
        }

        public string GenerateRandomId(int characters = 4)
        {
            Random rnd = new Random();
            string randomId = "";

            for (int i = 0; i < characters; i++)
            {
                char randomChar = (char)rnd.Next('A', 'Z');
                randomId = randomId + randomChar;
            }

            if (this.GetGameInstanceById(randomId) == null)
            {
                return randomId.ToUpper();
            }
            else
            {
                return GenerateRandomId(characters);
            }
        }

        public void Register(GameInstance game)
        {
            if (this.GetGameInstanceById(game.GameId) != null)
            {
                throw new Exception($"Unable to register game {game.GameId}, game id taken.");
            }
            else
            {
                if (game.GameManager != null && game.GameManager != this)
                {
                    throw new Exception($"Unable to register game {game.GameId}, game is already registered to a different game manager.");
                }
                else
                {
                    this.Games.Add(game);
                    game.OnRegister();
                }
            }
        }
        public void DeRegister(GameInstance game)
        {
            if (game.GameManager != this)
            {
                throw new Exception($"Unable to de-register game {game.GameId}, game is registered to a different game manager.");
            }
            this.Games.Remove(game);
            game.GameManager = null;
            game.OnDeRegister();
        }

        public List<GameInstance> GetGameInstancesByName(string name, bool ignoreCase = true)
        {
            List<GameInstance> foundGames = new List<GameInstance>();
            foreach (var game in this.Games)
            {
                if (ignoreCase)
                {
                    if (name.ToLower() == game.GameName.ToLower())
                    {
                        foundGames.Add(game);
                    }
                }
                else
                {
                    if (name == game.GameName)
                    {
                        foundGames.Add(game);
                    }
                }
            }

            return foundGames;
        }



    }

}