using System;
using System.Collections.Generic;
using System.Timers;

namespace GridSystem
{

    class Player : GridItem
    {

        public static string Message = "";
        public override void OnRemove()
        {

        }
        public override void OnAdded()
        {
            Message = "I am ready for an adventure!!";
        }
        public override void OnMove(GridPosition newPosition, GridPosition oldPosition)
        {
            Message = "I have just moved";
        }
    }
    class GridSystemImplementation
    {
        public GridSystemImplementation()
        {
            Console.WriteLine("Starting Game");

            var map = new GridMap();
            map.Init<GridSpace>(10, 10);

            var player = new Player();
            var hasAdded = map.AddItem(player, new GridPosition(2, 2));
            if (hasAdded)
            {
                Console.WriteLine("ADDED");
            }
            else
            {
                Console.WriteLine("NOPE");
            }



            while (true)
            {
                var userInput = GetUserInput();
                var newPosition = player?.GetPosition()?.Clone();
                var moving = player.MoveBy(userInput);
                if (moving == false)
                {
                    Player.Message = "I can't move that way";
                }
                else
                {
                    Player.Message = newPosition?.ToString();
                }
                RenderGrid(map);
            }

        }


        public static void RenderGrid(GridMap map)
        {
            Console.Clear();
            Console.WriteLine();
            Console.WriteLine(Player.Message);
            Console.WriteLine();
            for (int y = 0; y < map.YSize; y++)
            {
                string line = "";
                for (int x = 0; x < map.XSize; x++)
                {
                    var items = map.GetItems(new GridPosition(x, y));
                    if (items.Count > 0)
                    {
                        line = line + "[0]";
                    }
                    else
                    {
                        line = line + "[-]";
                    }
                }
                Console.WriteLine(line);
            }
        }

        public static GridPosition GetUserInput()
        {
            var key = GetKey().Trim();
            var position = new GridPosition(0, 0);
            switch (key)
            {
                case "UpArrow":
                    return new GridPosition(0, -1);
                case "DownArrow":
                    return new GridPosition(0, 1);
                case "LeftArrow":
                    return new GridPosition(-1, 0);
                case "RightArrow":
                    return new GridPosition(1, 0);
            }

            return null;
        }

        public static string GetKey()
        {
            System.ConsoleKeyInfo key;
            key = Console.ReadKey();
            return key.Key.ToString();

        }


        public static string AskUser(string question)
        {
            string line;
            Console.WriteLine(question);
            Console.WriteLine();
            line = Console.ReadLine();
            do
            {
                if (line != null)
                {
                    return line;
                }
            } while (line != null);

            return line;
        }
    }
}
