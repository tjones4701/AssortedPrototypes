using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace SBucket
{


    public class SbucketHttpPayload<T>
    {
        public string Path { get; set; }
        public T Data { get; set; }

        public Dictionary<string, string> Headers { get; set; }
        public Dictionary<string, string> QueryParams { get; set; }
        public SbucketHttpPayload(string path, Dictionary<string, string> queryParams, T data)
        {
            Path = path;
            QueryParams = queryParams;
            Data = data;
            Headers = null;
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
            List<string> parts = new List<string>();
            foreach (KeyValuePair<string, string> entry in queryParams)
            {
                var keyEncoded = System.Web.HttpUtility.UrlEncode(entry.Key);
                var valueEncoded = System.Web.HttpUtility.UrlEncode(entry.Value);
                var combination = $"{keyEncoded}={valueEncoded}";
                parts.Add(combination);
            }

            return string.Join("&", parts);
        }

        public static string processPath<T>(string template, T obj)
        {
            foreach (var property in typeof(T).GetProperties())
            {
                var stringToReplace = $"{property.Name}";
                var value = property.GetValue(obj);
                if (value == null) value = "";
                template = template.Replace(stringToReplace, value.ToString());
            }
            return template;
        }

        public static async Task<T> Post<T>(SbucketHttpPayload<T> payload)
        {
            Console.WriteLine(payload.Path);
            var content = new System.Net.Http.StringContent(serialize(payload.Data), Encoding.UTF8, "application/json");
            HttpResponseMessage response = await client.PostAsync(payload.Path, content);
            response.EnsureSuccessStatusCode();

            var responseObject = await response.Content.ReadAsStringAsync();
            return deserialize<T>(responseObject);
        }

        public static async Task<T> Get<T>(SbucketHttpPayload<T> payload)
        {
            var pathBase = $"{processPath(payload.Path, payload.Data)}{processQuery(payload.QueryParams)}";
            HttpResponseMessage response = await client.GetAsync(pathBase);
            response.EnsureSuccessStatusCode();

            var responseObject = await response.Content.ReadAsStringAsync();
            return deserialize<T>(responseObject);
        }

    }
}
