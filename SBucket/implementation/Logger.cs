using System;

namespace SBucket
{
    public class Logger
    {

        public static void error(string message)
        {
            Console.WriteLine($"[ERROR]{message}");
        }

        public static void info(string message)
        {
            Console.WriteLine($"[INFO]{message}");
        }

        public static void header(string message)
        {
            Console.WriteLine($"----------------");
            Console.WriteLine($"{message}");
            Console.WriteLine($"----------------");
        }
    }
}
