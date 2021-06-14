
namespace TwilightBattle
{

    public class Weapon
    {
        public DamageTypes DamageType { get; set; }
        public int PowerUsage { get; set; }
        public float Damage { get; set; }
        public float Speed { get; set; }
    }

    public enum DamageTypes
    {
        Electrical,
        Physical,
    }
}