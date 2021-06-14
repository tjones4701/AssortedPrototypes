

namespace TwilightBattle
{


    public class Player
    {
        public ShipPawn CurrentShip { get; set; }
        public void OnKeyDown(InputButton button)
        {
            if (CurrentShip != null)
            {
                CurrentShip.OnKeyDown(button);
            }
        }
        public void OnKeyUp(InputButton button)
        {
            if (CurrentShip != null)
            {
                CurrentShip.OnKeyUp(button);
            }
        }
    }
}