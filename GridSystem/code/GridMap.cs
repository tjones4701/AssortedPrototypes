
using System;
using System.Collections.Generic;

namespace GridSystem
{


    // Grid map is an instance of a space. This is the top level "grid" itself.
    partial class GridMap
    {

        public GridSpace[,] Grid { get; set; }
        public int XSize { get; set; }
        public int YSize { get; set; }

        public GridMap()
        {

        }

        public void Init<T>(int xSize, int ySize) where T : GridSpace, new()
        {
            XSize = xSize;
            YSize = ySize;
            Grid = new GridSpace[xSize, ySize];
            for (int y = 0; y < YSize; y++)
            {
                for (int x = 0; x < XSize; x++)
                {
                    var newSpace = new T();
                    newSpace.Map = this;
                    newSpace.Position = new GridPosition(x, y);
                    Console.WriteLine(newSpace);
                    Grid[x, y] = newSpace;
                }
            }
        }



        public GridSpace GetSpace(GridPosition position)
        {
            var x = position.x;
            var y = position.y;
            if ((x < XSize && x >= 0) && (y < YSize && y >= 0))
            {
                return Grid[x, y];
            }
            else
            {
                return null;
            }
        }

        public bool MoveItem(GridItem item, GridPosition newPosition)
        {
            var oldSpace = item.Space;
            var newSpace = GetSpace(newPosition);
            if (newSpace == null)
            {
                return false;
            }
            oldSpace.RemoveItem(item, false);
            newSpace.AddItem(item, false);

            item.OnMove(newPosition, oldSpace.Position);

            return true;
        }

        public bool AddItem(GridItem item, GridPosition newPosition)
        {
            if (item.Space != null)
            {
                return MoveItem(item, newPosition);
            }

            var newSpace = GetSpace(newPosition);
            Console.WriteLine(newPosition);
            if (newSpace == null)
            {
                return false;
            }

            newSpace.AddItem(item);
            return true;
        }

        public List<GridItem> GetItems(GridPosition position)
        {
            var space = GetSpace(position);
            if (space == null)
            {
                return new List<GridItem>();
            }
            else
            {
                return space.Items;
            }
        }
    }

}