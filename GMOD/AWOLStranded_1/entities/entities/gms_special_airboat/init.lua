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
	self.Entity:SetModel("models/buggy.mdl")
	self.Entity:SetColor(255,255,0,255)
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	
	local function MakeVehicle( Player, Pos, Ang, Model, Class, VName, VTable )
		if (!gamemode.Call( "PlayerSpawnVehicle", Player, Model, VName, VTable )) then return end
		local Ent = ents.Create( Class )
		if (!Ent) then return NULL end
		Ent:SetModel( Model )
		
		// Fill in the keyvalues if we have them
		if ( VTable && VTable.KeyValues ) then
			for k, v in pairs( VTable.KeyValues ) do
				Ent:SetKeyValue( k, v )
			end		
		end
			
		Ent:SetAngles( Ang )
		Ent:SetPos( Pos )
			
		Ent:Spawn()
		Ent:Activate()
		
		Ent.VehicleName 	= VName
		Ent.VehicleTable 	= VTable
		
		// We need to override the class in the case of the Jeep, because it 
		// actually uses a different class than is reported by GetClass
		Ent.ClassOverride 	= Class

		gamemode.Call( "PlayerSpawnedVehicle", Player, Ent )
		return Ent	
	end
	
	duplicator.RegisterEntityClass( "prop_vehicle_jeep_old",   		MakeVehicle, "Pos", "Ang", "Model", "Class", "VehicleName", "VehicleTable" )
	duplicator.RegisterEntityClass( "prop_vehicle_jeep",    		MakeVehicle, "Pos", "Ang", "Model", "Class", "VehicleName", "VehicleTable" )
	duplicator.RegisterEntityClass( "prop_vehicle_airboat", 		MakeVehicle, "Pos", "Ang", "Model", "Class", "VehicleName", "VehicleTable" )
	duplicator.RegisterEntityClass( "prop_vehicle_prisoner_pod", 	MakeVehicle, "Pos", "Ang", "Model", "Class", "VehicleName", "VehicleTable" )

	local vname = "Airboat"
	local VehicleList = list.Get( "Vehicles" )
	local vehicle = VehicleList[ vname ]

	if ( !vehicle ) then return end
	
	local ent = MakeVehicle( self.Entity:GetNetworkedEntity("OwnerObj"), self.Entity:GetPos(), self.Entity:GetAngles(), vehicle.Model, vehicle.Class, vname, vehicle ) 
	
	if ( vehicle.Members ) then
		table.Merge( Ent, vehicle.Members )
		duplicator.StoreEntityModifier( Ent, "VehicleMemDupe", vehicle.Members );
	end
	
	self.Entity:Remove()
end

function ENT:Use(ply)
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
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end