
using System.Collections.Generic;
using System.Text.Json;
using System;
using System.Text.Json.Serialization;

// Autogenerated 2021-06-13T01:13:10+10:00
namespace SBucket
{
    public class BaseGroupServer {
        
        
                
        [JsonInclude, JsonPropertyName("groupId")]
        public string GroupId { get; set; } = null;

            
                
        [JsonInclude, JsonPropertyName("serverId")]
        public string ServerId { get; set; } = null;

            
                
        [JsonInclude, JsonPropertyName("id")]
        public string Id { get; set; } = null;

            
                
        [JsonInclude, JsonPropertyName("active")]
        public bool Active { get; set; } = true;

            
                
        [JsonInclude, JsonPropertyName("createdAt")]
        public DateTime? CreatedAt { get; set; } = null;

            
                
        [JsonInclude, JsonPropertyName("updatedAt")]
        public DateTime? UpdatedAt { get; set; } = null;

                    
        public string Serialise()
        {
            var options = new JsonSerializerOptions { WriteIndented = true, IncludeFields = true };
            string jsonString = JsonSerializer.Serialize(this, options);
            return jsonString;
        }

        public BaseGroupServer Deserialise(string json)
        {
            
            var deserialised = CreateFromJson(json);

            
            GroupId = deserialised.GroupId;
            ServerId = deserialised.ServerId;
            Id = deserialised.Id;
            Active = deserialised.Active;
            CreatedAt = deserialised.CreatedAt;
            UpdatedAt = deserialised.UpdatedAt;
            return this;
        }
           

        public static BaseGroupServer CreateFromJson(string json)
        {
            return JsonSerializer.Deserialize<BaseGroupServer>(json);
        }

        public BaseGroupServer()
        {

        }
        
        public BaseGroupServer(string json)
        {
            Deserialise(json);
        }

        public override string ToString() {
            return Serialise();
        }
    }    
}

