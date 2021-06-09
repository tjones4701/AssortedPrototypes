# Who Am I?
I go by either Stinkfire or DrJones [Steam ID](https://steamcommunity.com/id/stinkfire).

My public Github profile [GitHub](https://github.com/tjones4701).

## Background
I work as a technical lead for a university building student and governance systems. I have a background as a fullstack developer and have been building enterprise level systems for over 5 years.

Due to the nature of my work most of my "portfolio" is locked under NDA so i am not able to easily show off past experience.
## Technical Experience
### Garrys Mod
- Main Developer Team AWOL GMOD Stranded (like 15 years ago)
- Contributor to Team AWOL Parkour (again more than 15 years ago)
    - [Old link to a parkour group](https://steamcommunity.com/groups/awolparkour)

### Rust
-   I have done some small modding for Rust about 5 years ago (maybe longer):
    -   Developed a mod that allowed servers to save kills, playtime etc.. to a website for people to view.
    -   Developed Various chat commands that made managing servers easier (kick, ban, giveItem, takeItem etc..). 

### Professional
Below is a brief overview of the frameworks, languages, concepts etc.. that i use in my day to day job.
- Languages/Frameworks
    -   Typescript (Advanced)
    -   Postgresql (Advanced)
    -   ReactJS (Advanced)
    -   PHP (Advanced)
    -   Html, CSS, Javascript etc.... (Advanced)
    -   C# (Intermediate)

- Concepts
    -   System Architecture Design (Advanced)
    -   Integration Design (Advanced)
    -   Database/Data structure design (Advanced)
    -   Automated Testing (Intermediate)
    -   DevOps/Infastructure Setup (Intermediate)

# SBucket

SBucket is a generic cross server data management service.
You can use this service to manage your organisation, servers, player data, groups, and roles.

This is currently a WIP and I am writing C# classes that abstract the api calls away from developers. I want the process of saving data across your servers as simple as a function call.
This will allow developers to quickly build new gamemodes and communities without needing to worry about designing backend infrastructure to manage it.

- List of features
    -   Organisation Management
    -   Player Data Management
    -   Groups Management
    -   Events Management
    -   Server Api Key/Secret Management


## Frontend Application (WIP)
Open [SBucket](https://sbucket.net) with your browser to see the frontend application.

## Api Documentation (WIP)
Open [SBucket Docs](https://api.sbucket.net/docs) with your browser to see api documentation.

## Fontend App (WIP)
While the backend im not releasing yet the frontend app is free to explore.
It is written in NextJS Typescript.

Open [SBucket Frontend Sourcecode](https://github.com/tjones4701/sbox-bucket-fe) with your browser to see api documentation.




#  SBox GameManager

Game Manager is my first attempt at a C# game manager that I plan to eventually build some sort of turn based game within SBox.

The classes manage registering games for players to join and taking care of the base game state (Turns, Rounds, current player etc...)
