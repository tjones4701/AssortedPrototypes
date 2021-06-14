

namespace TwilightBattle
{

    public enum InventoryTypes
    {
        Weapons,
        Shields,
        Accessories,
        Bank,
    }

    public class Ship
    {
        public Rotation Rot { get; set; }
        public Vector3 Acc { get; set; }
        public Vector3 Pos { get; set; }
        public float BaseSpeed { get; set; }
        public float BaseHandling { get; set; }
        public float BaseShield { get; set; }
        public float BasePower { get; set; }

        public int WeaponSlots { get; set; }
        public int ShieldSlots { get; set; }
        public int AccessorySlots { get; set; }

        public int Accelleration { get; set; }
        public int WeaponFiring { get; set; }

        public Inventory[] Inventories { get; set; }

        public T AddItem<T>(InventoryTypes inventoryType, T item, int? slotIndex) where T : InventoryItem
        {
            var typeIndex = (int)inventoryType;
            if (typeIndex >= 0 && typeIndex < Inventories.Length)
            {
                var inventory = Inventories[typeIndex];
                var addedItem = inventory.AddInventoryItem(item, slotIndex);

                OnAddItem(item, (int)slotIndex);
                return addedItem;
            }

            return null;
        }

        public void Spawn()
        {

        }
        public void FireWeapon(int index)
        {

        }

        public void Special(int index)
        {

        }

        public void MoveTo(Vector3 NewPosition)
        {

        }


        public virtual void OnAddItem(InventoryItem item, int slotIndex) { }
        public virtual void OnSpawn() { }
        public virtual void OnFireWeapon(int weaponId) { }
        public virtual void OnSpecial(int Special) { }
        public virtual void OnMove(int Special) { }
    }
}