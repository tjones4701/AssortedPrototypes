using System;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace SBucket
{



    public class MyGamemodeData
    {
        public int Money { get; set; } = 0;
        public string FavouriteColour { get; set; } = null;

        public MyGamemodeData()
        {

        }
    }

    class TestsPlayerData
    {
        public static async Task<bool> RunCreatePlayerData()
        {
            Logger.header("RunCreatePlayerData");

            var existing = await PlayerData<BattleRoyalStats>.GetPlayerData("TEST", "BR_STATS");
            if (existing == null)
            {
                existing = new PlayerData<BattleRoyalStats>();
                existing.PlayerId = "TEST";
                existing.Code = "BR_STATS";
                existing.Metadata = new BattleRoyalStats();
                existing.Metadata.Kills = new List<Kill>();
            }


            existing.Metadata.GamesPlayed = (existing?.Metadata?.GamesPlayed ?? 0) + 1;
            var rnd = new Random();
            var numberOfKills = rnd.Next(1, 2);
            var weapons = new List<string>();
            weapons.Add("FIST");
            weapons.Add("POT");
            weapons.Add("NUKE");

            for (int i = 0; i < numberOfKills; i++)
            {
                var kill = new Kill();
                kill.GameId = existing.Metadata.GamesPlayed.ToString();
                kill.Player = $"RANDOM_PLAYER_{i}";
                kill.Damage = rnd.Next(10, 100);
                kill.Weapon = weapons[rnd.Next(0, weapons.Count - 1)];

                existing.Metadata.Kills.Add(kill);
            }

            var saved = await existing.Save();

            return true;
        }

        public static async Task<bool> RunGetPlayersData()
        {
            Logger.header("RunCreatePlayerData");

            var player = await Player<BlankMetadata>.GetPlayer("STEAM_ID_HERE");

            var stats = (await player.GetData<MyGamemodeData>());
            stats.Money = stats.Money + 1;
            var newData = await player.SetData(stats);

            Console.WriteLine(newData.Money);
            Console.WriteLine(newData.FavouriteColour ?? "No favourite colour");

            return true;
        }
    }
}
