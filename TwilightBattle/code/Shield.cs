
using System;

namespace TwilightBattle
{

    public class Shield
    {
        public DamageTypes DamageType { get; set; }
        public float[] DamageReductions { get; set; }
        public float BaseDamageReduction { get; set; } = 0;

        public Shield()
        {
            var values = Enum.GetValues(typeof(DamageTypes));
            if (DamageReductions == null)
            {
                DamageReductions = new float[values.Length];
                foreach (var item in values)
                {
                    DamageReductions[(int)item] = BaseDamageReduction;
                }
            }
        }
    }

}