
namespace GridSystem
{

    // A grid item is an individual item on a grid.
    abstract class GridItem
    {
        // An offset is where this item would sit on the grid.
        // When porting to SBox this will allow me to have an item on a "grid" but then it could be slightly left or right of the centre.
        public Vector3 offset { get; set; }
        public GridSpace Space { get; set; }

        public GridItem()
        {
        }

        public void Remove()
        {
            Space = null;
            OnRemove();
        }

        public GridMap GetMap()
        {
            return Space?.Map;
        }

        public bool Move(GridPosition newPosition)
        {
            var map = GetMap();
            if (map == null)
            {
                return false;
            }

            return map.MoveItem(this, newPosition);
        }
        public bool MoveBy(GridPosition changes)
        {
            var newPosition = GetPosition().Clone().Add(changes);
            return this.Move(newPosition);
        }

        public GridPosition GetPosition()
        {
            return Space?.Position;
        }

        public virtual void OnRemove()
        {

        }
        public virtual void OnAdded()
        {

        }
        public virtual void OnMove(GridPosition newPosition, GridPosition oldPosition)
        {

        }
    }
}