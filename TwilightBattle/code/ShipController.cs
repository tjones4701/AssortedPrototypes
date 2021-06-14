

namespace TwilightBattle
{


    public class ShipPawn : Ship
    {
        public void OnKeyDown(InputButton button)
        {
            switch (button)
            {
                case InputButton.Attack1:
                    base.WeaponFiring = 1;
                    break;
                case InputButton.Attack2:
                    base.WeaponFiring = 2;
                    break;
                case InputButton.Forward:
                    base.Accelleration = base.Accelleration + 1;
                    break;
                case InputButton.Back:
                    base.Accelleration = base.Accelleration - 1;
                    break;
            }
        }

        public void OnKeyUp(InputButton button)
        {
            switch (button)
            {
                case InputButton.Attack1:
                    base.WeaponFiring = 0;
                    break;
                case InputButton.Attack2:
                    base.WeaponFiring = 0;
                    break;
                case InputButton.Forward:
                    base.Accelleration = base.Accelleration - 1;
                    break;
                case InputButton.Back:
                    base.Accelleration = base.Accelleration + 1;
                    break;
            }
        }
    }
}