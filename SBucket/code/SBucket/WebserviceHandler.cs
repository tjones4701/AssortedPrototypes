using System.Collections.Generic;
using System.Threading.Tasks;

namespace SBucket
{

    public class SbucketEndpoint
    {
        public string Code { get; set; }
        public string Url { get; set; }
        public int Version { get; set; }
        public SbucketEndpoint(string code, string url, int version)
        {
            Code = code;
            Url = url;
            Version = version;
            WebserviceRequest.Endpoints.Add(code, this);
        }
    }

    public class WebserviceRequest
    {

        public static Dictionary<string, SbucketEndpoint> Endpoints = new Dictionary<string, SbucketEndpoint>();

        //  THIS IS A PUBLIC KEY AND TOKEN THAT ANYONE CAN USE, DO NOT USE THIS FOR REAL STUFF. I WILL EVENTUALLY UPDATE THIS TO USE ENV VARS OR SECRETS.
        // public static string PublicKey = "d243aec4-c3d4-4093-8e2f-5ef9bb452bf6";
        // public static string PublicSecret = "1b7b620c-2c0b-49c4-8fc5-a4c4ce27ac68";
        // public static string OrganisationId = "ebf074fb-06f7-4aed-b873-fe0869f88b9c";
        public static string PublicKey = "441a7e0f-0349-42b2-a288-6a26dbe0c2a2";
        public static string PublicSecret = "2056aeb7-15fe-4ed0-bcd2-e9c2a17fdb9f";
        public static string OrganisationId = "260e1483-2302-4582-b9b9-5e91e713b371";





        public static string CurrentDetails = "";
        public static string ServerId = PublicKey;

        public static bool isInitialised { get; set; } = false;
        public static bool Initialise()
        {
            if (!isInitialised)
            {
                isInitialised = true;
                new SbucketEndpoint("ORGANISATIONS", "", 1);
                new SbucketEndpoint("ME", "me", 1);
                new SbucketEndpoint("ORGANISATION", "", 1);
                new SbucketEndpoint("SERVERS", "", 1);
                new SbucketEndpoint("SERVER_KEYS", "", 1);
                new SbucketEndpoint("PLAYER_EVENTS", "", 1);


                new SbucketEndpoint("PLAYER", $"organisations/{OrganisationId}/players/:PlayerId", 1);
                new SbucketEndpoint("PLAYERS", $"organisations/{OrganisationId}/players", 1);
                new SbucketEndpoint("PLAYER_PLAYER_DATAS", $"organisations/{OrganisationId}/players/:PlayerId/player-data", 1);
                new SbucketEndpoint("PLAYER_PLAYER_DATA", $"organisations/{OrganisationId}/players/:PlayerId/player-data/:Code", 1);

                SBucketHttpClient.client.BaseAddress = new System.Uri("http://localhost:8080");
                SBucketHttpClient.client.DefaultRequestHeaders.Add("server-api-id", PublicKey);
                SBucketHttpClient.client.DefaultRequestHeaders.Add("server-api-key", PublicSecret);
            }

            return true;
        }
        public static string GeneratePath(string code)
        {
            var item = Endpoints[code];
            if (item == null)
            {
                return null;
            }
            return $"/api/v{item.Version}/{item.Url}";
        }
        public static async Task<T> Get<T>(string code, Dictionary<string, string> queryParams, Dictionary<string, string> urlParams = null)
        {
            Initialise();
            var payload = new SbucketHttpPayload<T>();
            payload.UrlParams = urlParams;
            payload.QueryParams = queryParams;
            payload.Path = GeneratePath(code);

            return await SBucketHttpClient.Get<T>(payload);
        }
        public static async Task<SBucketResponse<T>> PostJson<T>(string code, string data, Dictionary<string, string> urlParams = null)
        {
            Initialise();
            var payload = new SbucketHttpPayload<string>();
            payload.UrlParams = urlParams;
            payload.Data = data;
            payload.Path = GeneratePath(code);

            return await SBucketHttpClient.PostJson<T>(payload);
        }
    }
}
