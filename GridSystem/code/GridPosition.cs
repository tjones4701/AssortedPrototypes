
namespace GridSystem
{

    // Position on the grid with basic math functions.
    public class GridPosition
    {

        public int y { get; set; }
        public int x { get; set; }

        public GridPosition(int X, int Y)
        {
            x = X;
            y = Y;
        }

        public GridPosition Clone()
        {
            return new GridPosition(x, y);
        }

        public GridPosition Add(GridPosition newPosition)
        {
            x = x + (newPosition?.x ?? 0);
            y = y + (newPosition?.y ?? 0);
            return this;
        }


        public override string ToString()
        {
            return $"[{x},{y}]";
        }
    }
}