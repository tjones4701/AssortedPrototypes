using System;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace SBucket
{


    // An example of storing player data.
    public class CharacterMetadata
    {
        public string Name { get; set; }
        public string OwnerId { get; set; }
        public int Experience { get; set; } = 0;
        public int Level { get; set; } = 1;

        public override string ToString()
        {
            return $"({Level}){Name}";
        }
    }

    class CharacterSystemTest
    {

        public static async Task<CharacterMetadata> GetCharacter(string name)
        {
            // Here we load the character from the server and the related metadata.
            var character = (await OrganisationData<CharacterMetadata>.GetData("CHARACTER_" + name))?.Metadata;
            return character;
        }

        public static async Task<CharacterMetadata> SaveCharacter(CharacterMetadata character)
        {

            // Create the organisation data payload, this will create the character at an organisation level.
            // You can also look at the Tests/PlayerData.cs file on how to create data at a player level.
            var organisationData = new OrganisationData<CharacterMetadata>();
            organisationData.Code = "CHARACTER_" + character.Name;
            organisationData.Metadata = character;

            // Save the character then return the metadata for them.
            var data = (await organisationData.Save());
            return data?.Metadata;
        }


        // This will create a player with a given name and owner id.
        public static async Task<CharacterMetadata> CreateCharacter(string name, string ownerId)
        {
            // Here we create the character metadata
            var character = new CharacterMetadata();
            character.Name = name;
            character.OwnerId = ownerId;

            // Then save that character.

            return await SaveCharacter(character);
        }

        public static async Task<bool> RunCharacterSystemTest()
        {
            Logger.header("RunCharacterSystemTest");
            Logger.info("Creating 10 random characters");
            var rnd = new Random();
            var names = new List<string>();
            names.Add("LittleBigFrench");
            names.Add("Ognik");
            names.Add("Garry");
            names.Add("Cip");


            var tasks = new List<Task<SBucket.CharacterMetadata>>();
            for (int i = 0; i < 10; i++)
            {
                var name = names[rnd.Next(0, names.Count - 1)];
                name = name + rnd.Next(0, 1000000) + i;
                var task = CreateCharacter(name, "OWNER1");
                tasks.Add(task);
            }

            var completed = await Task.WhenAll(tasks.ToArray());
            foreach (var item in completed)
            {
                Console.WriteLine(item);
            }



            // Here we should already have a character called Rusty (if not it will create one). We get the character every time this test runs and increase the level by 1.
            Logger.info("Increasing Rusty's level by 1.");
            var rusty = new CharacterMetadata();
            rusty.Name = "Rusty";

            rusty = (await GetCharacter(rusty.Name)) ?? rusty;
            rusty.Level = rusty.Level + 1;
            rusty = await SaveCharacter(rusty);
            Console.WriteLine(rusty);

            return true;
        }

    }
}
