
namespace TwilightBattle
{


    public enum InputButton : ulong
    {
        Attack1 = 1,
        Jump = 2,
        Duck = 4,
        Forward = 8,
        Back = 16,
        Use = 32,
        Cancel = 64,
        Left = 128,
        Right = 256,
        Attack2 = 512,
        Run = 1024,
        Reload = 2048,
        Alt1 = 4096,
        Alt2 = 8192,
        Walk = 16384,
        Weapon1 = 32768,
        Weapon2 = 65536,
        LookSpin = 131072,
        Zoom = 262144,
        Grenade1 = 524288,
        Grenade2 = 1048576,
        Score = 2097152,
        Drop = 4194304,
        View = 8388608,
        Menu = 16777216,
        Slot1 = 33554432,
        Slot2 = 67108864,
        Slot3 = 134217728,
        Slot4 = 268435456,
        Slot5 = 536870912,
        Slot6 = 1073741824,
        Slot7 = 2147483648,
        Slot8 = 4294967296,
        Slot9 = 8589934592,
        Slot0 = 17179869184,
        Next = 34359738368,
        Prev = 68719476736,
        Voice = 137438953472,
        Flashlight = 274877906944
    }
    public enum InputTypes
    {
        Weapons,
        Shields,
        Accessories,
        Bank,
    }
    public class Vector3
    {

        public float z { get; set; }
        public float y { get; set; }
        public float x { get; set; }

        public Vector3(float X, float Y, float Z)
        {
            x = X;
            y = Y;
            z = Z;
        }
    }

    public class Rotation
    {

        public float z { get; set; }
        public float y { get; set; }
        public float x { get; set; }

        public Rotation(float X, float Y, float Z)
        {
            x = X;
            y = Y;
            z = Z;
        }
    }
}