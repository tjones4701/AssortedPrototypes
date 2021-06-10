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
	self.Entity:DropToFloor( )
	self.Entity:SetMoveType( MOVETYPE_NONE )
 	self.Entity:SetMaterial("models/wireframe")
 	self.Entity.StrandedProtected = true
 	self.LastUsed = CurTime()
end

function ENT:AddResource(ply,res,int)
    self.Costs[res] = self.Costs[res] - int
    if self.Costs[res] <= 0 then
        self.Costs[res] = nil
    end
	
	local str = ":"
	for k,v in pairs(self.Costs) do
		str = str.." "..k.." ("..v.."x)"
	end
	self.Entity:SetNetworkedString('Resources', str)
end

function ENT:Setup(model,resclass)
    self.Entity:SetModel(model)
    self.ResultClass = resclass

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WORLD )

	self.Entity:SetColor(255,255,255,255)
	

 	local phys = self.Entity:GetPhysicsObject()
 	if phys then 
		phys:EnableMotion(false) 
	end
	local ply = self.Entity:CPPIGetOwner()
	local ent = self.Entity
	if (ent:IsRockModel() or ent:IsTreeModel() or ent:IsFoodModel()) then
		ent:Remove()
		if ply:IsPlayer() then
			ply:SendMessage("You cannot spawn this prop unless you're admin.",5,Color(255,255,255,255))
		end
	end
end

function ENT:Finish()
    local ent = ents.Create(self.ResultClass)	 
	if self.NormalProp == true then
		ent.NormalProp = true
	end
    ent:SetPos(self.Entity:GetPos())
    ent:SetAngles(self.Entity:GetAngles())
    ent:SetModel(self.Entity:GetModel())
	ent.Player = self.Entity.Player
	ent:SetNetworkedString('Name', self.Entity.Name)
    ent:Spawn()
	local phys = ent:GetPhysicsObject()
	if ValidEntity(phys) then
		hp = phys:GetMass()
		if hp < 100 then
			hp = 100
		end
	else
		hp = 100
	end
	ent.RPHealth = hp
	ent.RPMaxHealth = hp
	ent.Destroyable = 1
    local ply,uid = self.Entity:CPPIGetOwner()
	if uid then
		ent:CPPISetOwnerUID(uid)
	end
    ent:Fadein()
 
    self.Entity.Player.HasBuildingSite = false
	self.Entity:Remove( )
	local ply = self.Entity.Player
	if (ent:IsRockModel() or ent:IsTreeModel() or ent:IsFoodModel()) then
		ent:Remove()
		ply:SendMessage("You cannot spawn this prop unless you're admin.",5,Color(255,255,255,255))
	end
end

function ENT:Use(ply)
    if CurTime() - self.LastUsed < 0.5 then return end
	self.LastUsed = CurTime()
    for k,v in pairs(self.Costs) do
        if ply:GetResource(k) >= 0 then
            if ply:GetResource(k) < v then
                self:AddResource(ply,k,ply:GetResource(k))
                ply:DecResource(k,ply:GetResource(k))
            else
                self:AddResource(ply,k,v)
                ply:DecResource(k,v)
            end
        end
    end
    if table.Count(self.Costs) > 0 then
        local str = "You need: "
        for k,v in pairs(self.Costs) do
            str = str..k.." ("..v.."x)  "
        end
        str = str.." to finish."
        ply:SendMessage(str,5,Color(255,255,255,255))
    else
        ply:SendMessage("Finished!",3,Color(10,200,10,255))
		self:Finish()            
    end
	local ent = self
	if (ent:IsRockModel() or ent:IsTreeModel() or ent:IsFoodModel()) then
		ent:Remove()
		ply:SendMessage("You cannot spawn this prop unless you're admin.",5,Color(255,255,255,255))
	end
end

function ENT:AcceptInput(input, ply)
end

function ENT:KeyValue(k,v)
end

function ENT:OnRestore()
end

function ENT:OnTakeDamage(dmiDamage)
end

function ENT:PhysicsSimulate(pobPhysics,numDeltaTime)
end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end