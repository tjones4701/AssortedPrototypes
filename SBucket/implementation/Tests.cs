
namespace SBucket
{

    class Tests
    {
        public static void RunTests()
        {
            // TestsPlayer.RunPlayerSerialisation();
            RunAsyncTests();
        }
        public static async void RunAsyncTests()
        {
            // await TestsPlayer.RunCreatePlayer();
            // await TestsPlayer.GetPlayer();
            // await TestsPlayer.ChangingMetadata();

            // await TestsPlayerData.RunCreatePlayerData();
            await TestsPlayerData.RunGetPlayersData();

        }
        public Tests()
        {

        }

    }

}