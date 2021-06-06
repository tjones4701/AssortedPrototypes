using System;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace SBucket
{

    class TestsPlayer
    {
        public static bool RunPlayerSerialisation()
        {
            Logger.header("RunPlayerSerialisation");

            var player = new Player<RpMetadata>();
            player.PlayerId = "WAT";
            player.Name = "TESTING";
            player.OrganisationId = "--organisationid--";
            player.Metadata = new RpMetadata();
            player.Metadata.FavouriteColour = "RED";
            player.Metadata.Money = 50;

            var playerJson = player.Serialise();

            Console.WriteLine(playerJson);

            var deserialisePlayer = new Player<RpMetadata>();
            Console.WriteLine(deserialisePlayer?.Metadata);
            deserialisePlayer.Deserialise(playerJson);
            deserialisePlayer.Metadata.FavouriteColour = "GREEN";

            var deserialisePlayerJson = deserialisePlayer.Serialise();

            Console.WriteLine(deserialisePlayerJson);
            return true;
        }

        public static async Task<bool> RunCreatePlayer()
        {
            Logger.header("RunCreatePlayer");

            var tasks = new List<Task<Player<RpMetadata>>>();
            for (int i = 0; i < 2; i++)
            {

                var rnd = new Random();
                var newPlayer = new Player<RpMetadata>();
                newPlayer.PlayerId = System.Guid.NewGuid().ToString();
                newPlayer.Name = "Random player";
                newPlayer.Metadata = new RpMetadata();
                newPlayer.Metadata.Money = rnd.Next(0, 1000);
                var task = newPlayer.Save();
                tasks.Add(task);
            }
            var completed = await Task.WhenAll(tasks.ToArray());
            return true;
        }

        public static async Task<bool> GetPlayer()
        {
            Logger.header("RunGetPlayer");

            var player = await Player<RpMetadata>.GetPlayer("TEST");
            if (player == null)
            {
                Console.WriteLine("Player null");
                player = new Player<RpMetadata>();
                player.PlayerId = "TEST";

                player.Name = "Testing";
                await player.Save();

                player = await Player<RpMetadata>.GetPlayer("TEST");
            }

            return true;
        }

        public static async Task<bool> ChangingMetadata()
        {
            Logger.header("RunChangingMetadata");

            var player = await Player<RpMetadata>.GetPlayer("TEST");

            if (player.Metadata == null)
            {
                player.Metadata = new RpMetadata();
            }

            player.Metadata.Money = (player?.Metadata?.Money ?? 0) + 1;

            player = await player.Save();
            Console.WriteLine(player.Metadata.Money);

            return true;
        }

    }
}
