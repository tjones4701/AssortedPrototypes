AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/furniturestove001a.mdl")
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor(255,255,255,255)
	self.Entity.Resources = {}
	self.Entity.Resources["Coal"] = 0
	self.Entity.Timer = 0
	self.Entity.Act = 600
	self.Entity.TTimer = 0
end

function DropRes(resource,int,entity)
		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(entity:GetPos() + Vector(0,0,50))
		ent:SetAngles(entity:GetAngles())
		
		if ResourceMat[resource] && ResourceModel[resource] then
			ent:SetModel(ResourceModel[resource])
			ent:SetMaterial(ResourceMat[resource])
		elseif ResourceMat[resource] then
			ent:SetModel("models/items/item_item_crate.mdl")
			ent:SetMaterial(ResourceMat[resource])
		elseif ResourceModel[resource] then
			ent:SetModel(ResourceModel[resource])
		else
			ent:SetModel("models/items/item_item_crate.mdl")
		end

		ent:Spawn()

		ent:GetPhysicsObject():Wake()

		ent.Type = resource
		ent.Amount = int

		ent:SetResourceDropInfo(ent.Type,ent.Amount)
		local owner = entity:GetNetworkedString("Owner")
		local ply = player.GetByID(entity:GetNetworkedString("Ownerid"))
		SPropProtection.PlayerMakePropOwner(ply , ent)
end

function ENT:Use(ply)
	self.Entity.Act = 600
	for k,v in pairs(self.Entity.Resources) do 
		if v > 0 then
			DropRes(k,v,self.Entity)
			self.Entity.Resources[k] = 0
		end
	end
	
end

function ENT:AcceptInput(input, ply)
end

--Called when the entity key values are setup (either through calls to ent:SetKeyValue, or when the map is loaded).
--Return: Nothing
function ENT:KeyValue(k,v)
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when something hurts the entity.
--Return: Nothing
function ENT:OnTakeDamage(dmiDamage)
end

--Controls/simulates the physics on the entity.
--Return: (SimulateConst) sim, (Vector) linear_force and (Vector) angular_force
function ENT:PhysicsSimulate(pobPhysics,numDeltaTime)
end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	if self.Entity.Timer < CurTime() then
		if self.Entity.Act > 0 then
		local RRes = {}
		RRes[1] = "Stone"
		RRes[2] = "Stone"
		RRes[3] = "Stone"
		RRes[4] = "Stone"
		RRes[5] = "Copper_Ore"
		RRes[6] = "Copper_Ore"
		RRes[7] = "Copper_Ore"
		RRes[8] = "Copper_Ore"
		RRes[9] = "Iron_Ore"
		RRes[10] = "Iron_Ore"
		RRes[11] = "Iron_Ore"
		RRes[12] = "Steel"
		RRes[13] = "Steel"
		RRes[14] = "Coal"
		RRes[15] = "Coal"
		RRes[16] = "Diamond"
		
		local random = math.random(1,table.Count(RRes))
		local amount = math.random(1,50)
		local amounttogive = amount - random
		if amounttogive < 1 then
			amounttogive = 1
		end
		local Resource = RRes[random]
		if	self.Entity.Resources[Resource] then
			self.Entity.Resources[Resource] = self.Entity.Resources[Resource] + amounttogive
		else
			self.Entity.Resources[Resource] = amounttogive
		end
		self.Entity.Act = self.Entity.Act - 10
		end
		self.Entity.Timer = CurTime() + 1
	end
	
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entity)
	if self.Entity.TTimer < CurTime() then
		if entity:GetClass() == "gms_storagecache" then
			local otherent = entity:GetNetworkedString("Owner")
			local selfent = self.Entity:GetNetworkedString("Owner")
				if selfent == otherent then
					for k,v in pairs(self.Entity.Resources) do 
					if v > 0 then
						local Res = k
						local Amount = v
						self.Entity.Resources[k] = 0
						if entity.Resource[Res] then
							entity.Resource[Res] = entity.Resource[Res] + Amount
						else
							entity.Resource[Res] = Amount
						end
					end
				end
			end
		end
		self.Entity.TTimer = self.Entity.TTimer + 2
	end
end


--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end