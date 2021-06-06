using System.Collections.Generic;
using System.Threading.Tasks;

namespace SBucket
{
    public class PlayerData<T1> : BasePlayerData<T1>
    {


        public static async Task<PlayerData<T1>> GetPlayerData(string playerId, string code)
        {
            var urlParams = new Dictionary<string, string>();
            urlParams.Add("PlayerId", playerId);
            urlParams.Add("Code", code);
            var player = await WebserviceRequest.Get<SBucketResponse<PlayerData<T1>>>("PLAYER_PLAYER_DATA", null, urlParams);

            return player?.Data;
        }

        public async Task<PlayerData<T1>> Save()
        {
            var urlParams = new Dictionary<string, string>();
            urlParams.Add("PlayerId", this.PlayerId);
            urlParams.Add("Code", this.Code);
            var player = await WebserviceRequest.PostJson<PlayerData<T1>>("PLAYER_PLAYER_DATAS", Serialise(), urlParams);
            return player?.Data;
        }
    }
}
