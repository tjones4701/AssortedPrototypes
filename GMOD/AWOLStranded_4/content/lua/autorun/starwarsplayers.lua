if (SERVER) then
	player_manager.AddValidModel( "Battle Droid", "models/player/combine_droider.mdl" )  
	AddCSLuaFile( "starwarsplayers.lua" )
end

list.Set( "PlayerOptionsModel",  "Battle Droid", "models/player/combine_droider.mdl" )