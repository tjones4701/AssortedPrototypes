using System.Collections.Generic;
using System.Threading.Tasks;

namespace SBucket
{
    public class OrganisationData<T1> : BaseOrganisationData<T1>
    {
        public static async Task<OrganisationData<T1>> GetData(string code)
        {
            var urlParams = new Dictionary<string, string>();
            urlParams.Add("Code", code);
            var OrganisationData = await WebserviceRequest.Get<SBucketResponse<OrganisationData<T1>>>("ORGANISATION_DATA", null, urlParams);

            return OrganisationData?.Data;
        }

        public async Task<OrganisationData<T1>> Save()
        {
            var urlParams = new Dictionary<string, string>();
            urlParams.Add("Code", this.Code);
            var OrganisationData = await WebserviceRequest.PostJson<OrganisationData<T1>>("ORGANISATION_DATA", Serialise(), urlParams);
            return OrganisationData?.Data;
        }
    }
}
