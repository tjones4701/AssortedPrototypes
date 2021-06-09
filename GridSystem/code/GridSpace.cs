
using System;
using System.Collections.Generic;

namespace GridSystem
{

    partial class GridSpace
    {
        public GridPosition Position { get; set; }

        public GridMap Map { get; set; }


        public List<GridItem> Items = new List<GridItem>();

        public GridSpace()
        {

        }


        public void AddItem(GridItem item, bool triggerEvents = true)
        {
            item.Space = this;
            Items.Add(item);
            if (triggerEvents)
            {
                this.OnItemAdded(item);
                item.OnAdded();
            }
        }

        public void RemoveItem(GridItem item, bool triggerEvents = true)
        {
            item.Space = null;
            Items.Remove(item);
            if (triggerEvents)
            {
                OnItemRemoved(item);
                item.OnRemove();
            }
        }

        public virtual void OnItemAdded(GridItem item) { }
        public virtual void OnItemRemoved(GridItem item) { }

        public override string ToString()
        {
            return $"SPACE [{Position.x},{Position.y}]";
        }
    }
}