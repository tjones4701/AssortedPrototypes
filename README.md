# Who Am I?
I go by either Stinkfire, DrJones, or bithmar [Steam ID](https://steamcommunity.com/id/stinkfire).

My public Github profile [GitHub](https://github.com/tjones4701).

## What I would bring to the SBox community
I an an accomplished and experienced software developer with over 15 years in the industry. I enjoy modding and game development as a hobby and I am currently working as technical lead at a large university.

Over the last 15 years i have had experience in the following:
- Building intuative designs and complex systems.
- 4+ years in managing and moderating gaming communities (GMOD - TEAM AWOL)
- Developing gamemodes/addons for Rust and GMOD
- Enterprise level software development.
    -   Complex systems with a lot of interactions with a need for high performance.
### More specifically, experience in the following will contribute greatly to the S&box community.
-   Hobby game development (**gmod**, **rust**, lua2d, javascript, **unity**, **unreal**)
-   Extensive frontend development experience
-   Extensive backend development experience (integration, microservice, monolithic applications across various languages and frameworks)
-   Extensive experience in Database design
-   Experience in integration development
-   Leadership and project management experience.

## Modding Experience
### Garrys Mod - Team AWOL
I was part of a group that managed one of the most popular Australian GMOD servers.
As part of this group I was responsible for developing and maintaining our gamemodes, addons, and engaging with the community.

The gamemodes I was a primary developer for were as follows:
- Main Developer Team AWOL GMOD Stranded
https://github.com/tjones4701/AssortedPrototypes/tree/master/GMOD
- Contributor to Team AWOL Parkour
    - [Old link to a parkour group](https://steamcommunity.com/groups/awolparkour)

### Rust
During the early days of rust (anyone remember building bases on rocks?)

I was paid to build various addons including:
-   Minigame system
    -   Deathmatch/ hungergames systems that handled spawning, rounds, weapons etc..
-   Administration management tool
    -   kicking, baning, muting, reporting etc...
-   Experience/Achievement system
    -   Every action you did in the game gave you points and you earnt badges which were shown on the website./
-   Player statitics reporting systems
    -   You could look up kills, playtime and various stats of all players playing on the server.

This code was closed source and I do not own this code.

### Where are the videos or pictures?
Unfortunately I have not been able to find any of the screenshots or videos of the mods I had.

## S&Box Work
I have been an active memeber of the S&Box community since the discord was created. I have also started developing tools and building a repository of ideas that I plan to build in SBox. **These are listed at the bottom of this readme**

## Professional Background
I work as a technical lead for a university building student and governance systems. I have a background as a fullstack developer and have been building enterprise level systems for over 5 years.

Due to the nature of my work most of my "portfolio" can't be shown due to NDA.
I am able to show off some screenshots for the current product I am the technical lead for.
This product is a progressive web application built in typescript react, utilising a headless cms for content and a microservice integration platform for student apis.
#### Today Page
![Imgur Image](https://imgur.com/vw4G4zU.jpg)
#### Calendar
![Imgur Image](https://imgur.com/DKQ2u0o.jpg)
#### Discover Page
![Imgur Image](https://imgur.com/gtvS7bm.jpg)
![Imgur Image](https://imgur.com/w4WiCh9.jpg)
#### Notifications
![Imgur Image](https://imgur.com/RfOre8N.jpg)
#### Study Page (Shows historic information)
![Imgur Image](https://imgur.com/1z8CWNz.jpg)


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

#  Grid System

A basic grid system that handles a map, spaces and individual items.
You can download this project and run dotnet watch run and try it out. Up, Down, Left, Right updates the position and rerenders the grid.

