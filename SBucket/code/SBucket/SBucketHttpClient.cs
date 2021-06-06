using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace SBucket
{
    public class SBucketResponse<T>
    {
        [JsonInclude, JsonPropertyName("results")]
        public int Results;
        [JsonInclude, JsonPropertyName("data")]
        public T Data;
    }

    public class Pagination<T>
    {
        [JsonInclude, JsonPropertyName("count")]
        public int Count;
        [JsonInclude, JsonPropertyName("records")]
        public List<T> Records;
    }

    public class PaginationResponse<T>
    {

        [JsonInclude, JsonPropertyName("results")]
        public int Results;
        [JsonInclude, JsonPropertyName("data")]
        public Pagination<T> Data;
    }

    public class SbucketHttpPayload<T>
    {
        public string Path { get; set; }
        public T Data { get; set; }

        public Dictionary<string, string> Headers { get; set; }
        public Dictionary<string, string> QueryParams { get; set; }
        public Dictionary<string, string> UrlParams { get; set; }
        public SbucketHttpPayload(string path, Dictionary<string, string> queryParams, T data)
        {
            Path = path;
            QueryParams = queryParams;
            Data = data;
            Headers = null;
        }
        public SbucketHttpPayload()
        {
        }
        public SbucketHttpPayload(string path, Dictionary<string, string> queryParams, Dictionary<string, string> urlParams)
        {
            Path = path;
            QueryParams = queryParams;
            UrlParams = urlParams;
        }

        public SbucketHttpPayload(string path, Dictionary<string, string> queryParams)
        {
            Path = path;
            QueryParams = queryParams;
        }
    }
    public class SBucketHttpClient
    {
        public static HttpClient client = new HttpClient();

        public static string serialize(object data)
        {
            var options = new JsonSerializerOptions { IncludeFields = true };
            string jsonString = JsonSerializer.Serialize(data, options);
            return jsonString;
        }
        public static T deserialize<T>(string json)
        {
            var deserialised = JsonSerializer.Deserialize<T>(json);
            return deserialised;
        }

        public static string processQuery(Dictionary<string, string> queryParams)
        {
            try
            {
                List<string> parts = new List<string>();
                foreach (KeyValuePair<string, string> entry in queryParams)
                {
                    try
                    {
                        var keyEncoded = System.Web.HttpUtility.UrlEncode(entry.Key);
                        var valueEncoded = System.Web.HttpUtility.UrlEncode(entry.Value);
                        var combination = $"{keyEncoded}={valueEncoded}";
                        parts.Add(combination);
                    }
                    catch (Exception e)
                    {

                    }
                }

                return string.Join("&", parts);
            }
            catch (Exception e)
            {
                return "";
            }
        }

        public static string processPath(string template, Dictionary<string, string> obj)
        {
            if (obj == null)
            {
                return template;
            }
            foreach (var item in obj)
            {
                try
                {
                    var stringToReplace = $":{item.Key}";
                    var value = item.Value;
                    if (value == null) value = "";
                    template = template.Replace(stringToReplace, value.ToString());
                }
                catch (Exception)
                {

                }
            }
            return template;
        }

        public static async Task<SBucketResponse<T>> PostJson<T>(SbucketHttpPayload<string> payload)
        {
            var query = processQuery(payload.QueryParams);
            var pathBase = $"{processPath(payload.Path, payload.UrlParams)}";
            if (query?.Length > 0)
            {
                pathBase = $"{pathBase}?{query}";
            }

            var content = new System.Net.Http.StringContent(payload.Data, Encoding.UTF8, "application/json");
            HttpResponseMessage response = await client.PostAsync(pathBase, content);

            var responseObject = await response.Content.ReadAsStringAsync();
            var result = deserialize<SBucketResponse<T>>(responseObject);

            return result;
        }

        public static async Task<T> Get<T>(SbucketHttpPayload<T> payload)
        {
            var query = processQuery(payload.QueryParams);
            var pathBase = $"{processPath(payload.Path, payload.UrlParams)}";
            if (query?.Length > 0)
            {
                pathBase = $"{pathBase}?{query}";
            }
            HttpResponseMessage response = await client.GetAsync(pathBase);
            response.EnsureSuccessStatusCode();

            var responseObject = await response.Content.ReadAsStringAsync();
            var result = deserialize<T>(responseObject);


            return result;
        }

    }
}
