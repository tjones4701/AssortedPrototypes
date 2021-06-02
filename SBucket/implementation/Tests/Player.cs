using System;
using System.Threading.Tasks;

namespace SBucket
{


    class TestsPlayer
    {
        public static bool RunPlayerSerialisation()
        {
            var player = new Player<RpMetadata>();
            player.PlayerId = "WAT";
            player.Name = "TESTING";
            player.OrganisationId = "--organisationid--";
            player.metadata = new RpMetadata();
            player.metadata.FavouriteColour = "RED";
            player.metadata.Money = 50;

            var playerJson = player.serialise();

            Console.WriteLine(playerJson);

            var deserialisePlayer = new Player<RpMetadata>(playerJson);
            deserialisePlayer.metadata.FavouriteColour = "GREEN";

            var deserialisePlayerJson = deserialisePlayer.serialise();

            Console.WriteLine(deserialisePlayerJson);
            return true;
        }

        public static async Task<bool> RunCreatePlayer()
        {
            var players = await Player<RpMetadata>.GetPlayers(0, 10);
            Console.WriteLine(players.Count);
            // var player = new Player<RpMetadata>();
            // player.PlayerId = "WAT";
            // player.Name = "TESTING";
            // player.OrganisationId = "--organisationid--";
            // player.metadata = new RpMetadata();
            // player.metadata.FavouriteColour = "RED";
            // player.metadata.Money = 50;

            // var loadedPlayer = await WebserviceRequest.Post<Player<RpMetadata>>("PLAYERS", player);

            // Console.WriteLine(loadedPlayer.serialise());
            // Console.WriteLine(player.serialise());
            return true;
        }

    }
}
