

using System.Collections.Generic;

namespace TwilightBattle
{


    public class InventoryItem
    {
        public static int EmptyItemId { get; set; } = -1;
        public int ItemId { get; set; }
        public int StackSize { get; set; }
        public int Quantity { get; set; }
    }


    public class Inventory
    {
        public string Name { get; set; }
        public InventoryItem[] Slots { get; set; }
        public int Size { get; set; }
        public Inventory(string name, int size)
        {
            if (size > 0)
            {
                Slots = new InventoryItem[size];
                Size = size;
            }
            else
            {
                Size = 0;
            }
        }

        public InventoryItem[] Resize(int newSize)
        {
            var removedItems = new List<InventoryItem>();
            var newSlots = new InventoryItem[newSize];
            for (int i = 0; i < Size; i++)
            {
                if (IsInBounds(i))
                {
                    if (i > newSize)
                    {
                        removedItems.Add(Slots[i]);
                    }
                    else
                    {
                        newSlots[i] = Slots[i];
                    }
                }
            }

            Slots = newSlots;

            return removedItems.ToArray();
        }

        public bool IsInBounds(int slotId)
        {
            if (slotId >= 0 && slotId < Slots.Length)
            {
                return true;
            }
            return false;
        }

        public T AddInventoryItem<T>(T item, int? slotIndex) where T : InventoryItem
        {
            if (slotIndex == null)
            {
                slotIndex = GetItemIndexWithSpace(item);
            }

            if (!IsValidSlot((int)slotIndex, item))
            {
                return null;
            }
            if (IsInBounds((int)slotIndex))
            {
                int index = (int)slotIndex;
                var currentQuantity = item.Quantity;
                var slot = Slots[index];
                slot.ItemId = item.ItemId;
                slot.Quantity = slot.Quantity + item.Quantity;
            }

            return null;
        }

        public int[] GetItemIndexesById(int id)
        {
            var indexes = new List<int>();
            if (Slots != null && id > 0 && id < Slots.Length)
            {
                for (int i = 0; i < Slots.Length; i++)
                {
                    var item = Slots[id];
                    if (item.ItemId == id)
                    {
                        indexes.Add(id);
                    }
                }
            }
            return indexes.ToArray();
        }

        public T[] GetItemsById<T>(int id) where T : InventoryItem
        {
            var indexes = GetItemIndexesById(id);
            var slots = new List<T>();
            foreach (var index in indexes)
            {
                slots.Add((T)Slots[index]);
            }

            return slots.ToArray();
        }

        public int GetItemIndexWithSpace(InventoryItem item)
        {
            return GetItemIndexWithSpace(item.ItemId, item.StackSize);
        }
        public int GetItemIndexWithSpace(int itemId, int quantity)
        {
            var indexes = GetItemIndexesById(itemId);

            foreach (var index in indexes)
            {
                if (IsValidSlot(index, itemId, quantity))
                {
                    return index;
                }
            }
            return -1;
        }

        public bool IsValidSlot(int slotIndex, InventoryItem item)
        {
            return IsValidSlot(slotIndex, item.ItemId, item.Quantity);
        }

        public bool IsValidSlot(int slotIndex, int itemId, int quantity)
        {
            if (IsInBounds(slotIndex))
            {
                var slot = Slots[slotIndex];
                if (slot.ItemId == InventoryItem.EmptyItemId)
                {
                    return true;
                }
                if (slot.ItemId == itemId)
                {
                    var newQuantity = (slot.Quantity + quantity);
                    if (newQuantity <= slot.StackSize)
                    {
                        return true;
                    }
                }
            }

            return false;
        }

    }
}