

using System.Collections.Generic;

namespace SBucket
{

    public class Kill
    {
        public string GameId { get; set; }
        public string Player { get; set; }
        public string Weapon { get; set; }
        public float Damage { get; set; }
    }
    public class BattleRoyalStats
    {
        public int GamesPlayed { get; set; }
        public List<Kill> Kills { get; set; }
    }
}
