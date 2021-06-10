include("shared.lua")
local texLogo = surface.GetTextureID( "vgui/modicon" )
if not GMS then 
	local GMS = {} 
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
    self.AddAngle = Angle(0,0,90)
    self.FoodIcons = {}
    for k,v in pairs(GMS.Combinations["Cooking"]) do
		if v.Texture then
			self.FoodIcons[k] = surface.GetTextureID(v.Texture)
        end
    end
end

--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
    self.Entity:DrawModel()
end

function GMS.SetFoodInfo(um)
    local index = um:ReadString()
    local type = um:ReadString()
    local ent = ents.GetByIndex(index)
    if ent == NULL or !ent then
		local tbl = {}
        tbl.Type = type
        tbl.Index = index
		table.insert(GMS.PendingFoodDrops,tbl)
    else
        ent.Food = type
    end
end
usermessage.Hook("gms_SetFoodDropInfo",GMS.SetFoodInfo)

GMS.PendingFoodDrops = {}
function GMS.CheckForFoodDrop()
    for k,tbl in pairs(GMS.PendingFoodDrops) do
    local ent = ents.GetByIndex(tbl.Index)
		if ent != NULL then
            ent.Food = tbl.Type
			table.remove(GMS.PendingFoodDrops,k)
        end
    end
end
hook.Add("Think","gms_CheckForPendingFoodDrops",GMS.CheckForFoodDrop)

--Return true if this entity is translucent.
--Return: Boolean
function ENT:IsTranslucent()
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
    self.AddAngle = self.AddAngle + Angle(0,1.5,0)
end