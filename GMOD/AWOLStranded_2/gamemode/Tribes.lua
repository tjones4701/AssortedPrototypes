StrandedTribes = {}

function LoadTribes()

end

function SaveAllTribes()

end

function SaveTribe(id)

end

function CreateTribe(id,name,colour,leadersteamid,leadername)
	if Stranded.Tribes[id] then
	
	else
		local c = Stranded.Tribes[id]
		c = {}
		c.name = name
		c.colour = colour
		c.leadersteamid = leadersteamid
		c.leadername = leadername
		c.Ranks = {}
		DefaultRanks(id)
	end
end

function CreateRank(id,rank,name,permissions)
	if Stranded.Tribes[id] && id != "Tribes Leader" && name && permissions
	if Stranded.Tribes[id].Ranks[rank] then
		Stranded.Tribes[id].Ranks[rank].name = name
		Stranded.Tribes[id].Ranks[rank].permissions = name
	else
		Stranded.Tribes[id].Ranks[rank] = {}
		Stranded.Tribes[id].Ranks[rank].name = name
		Stranded.Tribes[id].Ranks[rank].permissions = name
	end
end

function DefaultRanks(id)
	if Stranded.Tribes[id] then
		local c = Stranded.Tribes[id]
		c.Ranks = {}
		local x = 1
		c.Ranks[x] = {}
		c.Ranks[x].name = "Tribe Leader"
		c.Ranks[x].permissions = {"owner"}
		x = 2
		c.Ranks[x] = {}
		c.Ranks[x].name = "Elder"
		c.Ranks[x].permissions = {"bank","pvp","color","name","promote","demote","ranks","kick","private"}
		x = 3
		c.Ranks[x] = {}
		c.Ranks[x].name = "Warrior"
		c.Ranks[x].permissions = {"pvp","promote","demote","bank","kick"}
		x = 4
		c.Ranks[x] = {}
		c.Ranks[x].name = "Gatherer"
		c.Ranks[x].permissions = {"promote","demote","bank","kick"}
		x = 5
		c.Ranks[x] = {}
		c.Ranks[x].name = "Member"
		c.Ranks[x].permissions = {}
		x = 6
		c.Ranks[x] = {}
		c.Ranks[x].name = "Savage"
		c.Ranks[x].permissions = {"pvp"}
		x = 7
		c.Ranks[x] = {}
		c.Ranks[x].name = "Initiate"
		c.Ranks[x].permissions = {}
	end
end
