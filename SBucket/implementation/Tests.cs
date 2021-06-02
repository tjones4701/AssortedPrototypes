using System;
using System.Collections.Generic;
using System.Timers;

namespace SBucket
{

    class Tests
    {
        public static void RunTests()
        {
            TestsPlayer.RunPlayerSerialisation();
            RunAsyncTests();
        }
        public static async void RunAsyncTests()
        {
            await TestsPlayer.RunCreatePlayer();
        }
        public Tests()
        {

        }

    }

}