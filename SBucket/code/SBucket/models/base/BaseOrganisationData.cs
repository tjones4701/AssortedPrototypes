
using System.Collections.Generic;
using System.Text.Json;
using System;
using System.Text.Json.Serialization;

// Autogenerated 2021-06-13T01:13:10+10:00
namespace SBucket
{
    public class BaseOrganisationData<T1> {
        
        
                
        [JsonInclude, JsonPropertyName("metadata")]
        public T1 Metadata { get; set; } = default(T1);

            
                
        [JsonInclude, JsonPropertyName("code")]
        public string Code { get; set; } = null;

            
                
        [JsonInclude, JsonPropertyName("organisationId")]
        public string OrganisationId { get; set; } = null;

            
                
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

        public BaseOrganisationData<T1> Deserialise(string json)
        {
            
            var deserialised = CreateFromJson(json);

            
            Metadata = deserialised.Metadata;
            Code = deserialised.Code;
            OrganisationId = deserialised.OrganisationId;
            Id = deserialised.Id;
            Active = deserialised.Active;
            CreatedAt = deserialised.CreatedAt;
            UpdatedAt = deserialised.UpdatedAt;
            return this;
        }
           

        public static BaseOrganisationData<T1> CreateFromJson(string json)
        {
            return JsonSerializer.Deserialize<BaseOrganisationData<T1>>(json);
        }

        public BaseOrganisationData()
        {

        }
        
        public BaseOrganisationData(string json)
        {
            Deserialise(json);
        }

        public override string ToString() {
            return Serialise();
        }
    }    
}

