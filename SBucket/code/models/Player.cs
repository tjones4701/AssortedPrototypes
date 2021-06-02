using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace SBucket
{
    public class Player<T>
    {
        [JsonInclude]
        public string Name { get; set; }

        [JsonInclude]
        public string PlayerId { get; set; }
        [JsonInclude]
        public string OrganisationId { get; set; }

        [JsonInclude]
        public T metadata { get; set; }

        public static async Task<List<Player<T>>> GetPlayers(int page, int itemsPerPage)
        {
            var queryParams = new Dictionary<string, string>();
            queryParams.Add("page", page.ToString());
            queryParams.Add("itemsPerPage", itemsPerPage.ToString());
            List<Player<T>> players = await WebserviceRequest.Get<List<Player<T>>>("PLAYERS", queryParams);

            return players;
        }

        public string serialise()
        {
            var options = new JsonSerializerOptions { WriteIndented = true, IncludeFields = true };
            string jsonString = JsonSerializer.Serialize(this, options);
            return jsonString;
        }
        public Player<T> deserialise(string playerJson)
        {
            Player<T> deserialised = JsonSerializer.Deserialize<Player<T>>(playerJson);
            this.Name = deserialised.Name;
            this.OrganisationId = deserialised.OrganisationId;
            this.PlayerId = deserialised.PlayerId;
            this.metadata = deserialised.metadata;
            return this;
        }

        public Player()
        {

        }
        public Player(string playerJson)
        {
            deserialise(playerJson);
        }

    }
}
