using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SBucket
{
    public class Player<T1> : BasePlayer<T1> where T1 : class, new()
    {
        public static async Task<Pagination<Player<T1>>> GetPlayers(int page, int itemsPerPage)
        {
            var queryParams = new Dictionary<string, string>();
            queryParams.Add("page", page.ToString());
            queryParams.Add("itemsPerPage", itemsPerPage.ToString());
            var player = await WebserviceRequest.Get<PaginationResponse<Player<T1>>>("PLAYERS", queryParams);

            return player?.Data;
        }

        public static async Task<Player<T1>> GetPlayer(string playerId, bool createNew = true)
        {
            var urlParams = new Dictionary<string, string>();
            urlParams.Add("PlayerId", playerId);
            var player = await WebserviceRequest.Get<SBucketResponse<Player<T1>>>("PLAYER", null, urlParams);

            if (player?.Data == null && createNew == true)
            {
                var playerData = new Player<T1>();
                playerData.PlayerId = playerId;
                playerData.Metadata = default(T1);
                return playerData;
            }
            return player?.Data;
        }
        public async Task<Player<T1>> Save()
        {
            var player = await WebserviceRequest.PostJson<Player<T1>>("PLAYERS", Serialise());
            return player?.Data;
        }

        public async Task<T> GetData<T>(string code = null) where T : new()
        {
            if (code == null)
            {
                code = WebserviceRequest.ServerId;
            }

            try
            {
                var playerData = (await PlayerData<T>.GetPlayerData(this.PlayerId, code));
                if (playerData.Metadata == null)
                {
                    return new T();
                }
                return playerData.Metadata;
            }
            catch (Exception)
            {
                return new T();
            }
        }

        public async Task<T> SetData<T>(T data, string code = null)
        {
            if (code == null)
            {
                code = WebserviceRequest.ServerId;
            }

            try
            {
                var playerData = new PlayerData<T>();
                playerData.Code = code;
                playerData.PlayerId = this.PlayerId;
                playerData.Metadata = data;
                playerData = await playerData.Save();

                return playerData.Metadata;
            }
            catch (Exception e)
            {
                return default(T);
            }

        }
    }
}
