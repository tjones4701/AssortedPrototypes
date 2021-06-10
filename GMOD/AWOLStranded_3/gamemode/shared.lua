/*---------------------------------------------------------
  Gmod Stranded
---------------------------------------------------------*/
GMS = {}

GM.Name 	= "AWOL Stranded"
GM.Author 	= "jA_cOp, prop_dynamic, Chewgum, Wokkel, Bithmar"
GM.Email 	= ""
GM.Website 	= "http://gmsbugs.tk/"

team.SetUp(20, "Survivalists", Color(255, 255, 255, 255))
team.SetUp(21, "Anonymous", Color(0, 121, 145, 255))
team.SetUp(22, "The Gummies", Color(255, 23, 0, 255))
team.SetUp(23, "The Dynamics", Color(0, 72, 255, 255))
team.SetUp(24, "Scavengers", Color(8, 255, 0, 255))
team.SetUp(1, "The Stranded", Color(200, 200, 0, 255))

--Tables

GMS_SpawnLists = {}
GMS_SpawnLists["Wood - Tables/Desks"] =
	{
		"models/props_c17/FurnitureDrawer003a.mdl",
		"models/props_c17/FurnitureDrawer002a.mdl",
		"models/props_c17/FurnitureTable003a.mdl",
		"models/props_c17/FurnitureDrawer001a.mdl",
		"models/props_c17/FurnitureTable001a.mdl",
		"models/props_c17/FurnitureTable002a.mdl",
		"models/props_interiors/Furniture_Desk01a.mdl",
		"models/props_interiors/Furniture_Vanity01a.mdl",
		"models/props_wasteland/cafeteria_table001a.mdl"
	}
GMS_SpawnLists["Wood - Shelving/Storage"] =
	{
		"models/props_c17/FurnitureShelf001b.mdl",
		"models/props_wasteland/prison_shelf002a.mdl",
		"models/props_junk/wood_crate001a.mdl",
		"models/props_junk/wood_crate001a_damaged.mdl",
		"models/props_junk/wood_crate002a.mdl",
		"models/props_wasteland/laundry_cart002.mdl",
		"models/props_c17/FurnitureShelf001a.mdl",
		"models/props_interiors/Furniture_shelf01a.mdl",
		"models/props_c17/shelfunit01a.mdl",
		"models/props_c17/FurnitureDresser001a.mdl",
		"models/props/cs_militia/shelves_wood.mdl"
	}
GMS_SpawnLists["Wood - Seating"] =
	{
		"models/props_c17/FurnitureChair001a.mdl",
		"models/props_interiors/Furniture_chair01a.mdl",
		"models/props_c17/playground_swingset_seat01a.mdl",
		"models/props_c17/playground_teetertoter_seat.mdl",
		"models/props_wasteland/cafeteria_bench001a.mdl",
		"models/props_trainstation/BenchOutdoor01a.mdl",
		"models/props_c17/bench01a.mdl",
		"models/props_trainstation/bench_indoor001a.mdl"
		

	}
GMS_SpawnLists["Wood - Doors/Plating/Beams"] =
	{
		"models/props_debris/wood_board02a.mdl",
		"models/props_debris/wood_board04a.mdl",
		"models/props_debris/wood_board06a.mdl",
		"models/props_debris/wood_board01a.mdl",
		"models/props_debris/wood_board03a.mdl",
		"models/props_debris/wood_board05a.mdl",
		"models/props_debris/wood_board07a.mdl",
		"models/props_junk/wood_pallet001a.mdl",
		"models/props_wasteland/wood_fence02a.mdl",
		"models/props_wasteland/wood_fence01a.mdl",
		"models/props_c17/Frame002a.mdl",
		"models/props_wasteland/barricade001a.mdl",
		"models/props_wasteland/barricade002a.mdl",
		"models/props_docks/channelmarker_gib01.mdl",
		"models/props_docks/channelmarker_gib04.mdl",
		"models/props_docks/channelmarker_gib03.mdl",
		"models/props_docks/channelmarker_gib02.mdl",
		"models/props_docks/dock01_pole01a_128.mdl",
		"models/props_docks/dock02_pole02a_256.mdl",
		"models/props_docks/dock01_pole01a_256.mdl",
		"models/props_docks/dock02_pole02a.mdl",
		"models/props_docks/dock03_pole01a_256.mdl",
		"models/props_docks/dock03_pole01a.mdl"
	}
GMS_SpawnLists["Iron - Cargo/Tanks"] =
	{
		"models/props_wasteland/cargo_container01.mdl",
		"models/props_wasteland/cargo_container01b.mdl",
		"models/props_wasteland/cargo_container01c.mdl",
		"models/props_wasteland/horizontalcoolingtank04.mdl",
		"models/props_wasteland/coolingtank02.mdl",
		"models/props_wasteland/coolingtank01.mdl",
		"models/props_junk/TrashDumpster01a.mdl",
		"models/props_junk/TrashDumpster02.mdl"
	}
GMS_SpawnLists["Iron - Kitchen/Appliances"] =
	{
		"models/props_interiors/SinkKitchen01a.mdl",
		"models/props_interiors/Radiator01a.mdl",
		"models/props_c17/FurnitureWashingmachine001a.mdl",
		"models/props_c17/FurnitureFridge001a.mdl",
		"models/props_interiors/refrigerator01a.mdl",
		"models/props_c17/FurnitureBoiler001a.mdl",
		"models/props_c17/FurnitureFireplace001a.mdl",
		"models/props_wasteland/kitchen_counter001d.mdl",
		"models/props_wasteland/kitchen_stove001a.mdl",
		"models/props_wasteland/kitchen_stove002a.mdl",
		"models/props_wasteland/kitchen_fridge001a.mdl",
		"models/props_wasteland/laundry_dryer001.mdl",
		"models/props_wasteland/laundry_dryer002.mdl",
		"models/props_wasteland/laundry_washer003.mdl",
		"models/props_wasteland/laundry_washer001a.mdl",
		"models/props_wasteland/laundry_basket001.mdl",
		"models/props_wasteland/laundry_basket002.mdl"
	}
GMS_SpawnLists["Iron - Shelving/Storage"] =
	{
		"models/props_c17/FurnitureShelf002a.mdl",
		"models/props_lab/filecabinet02.mdl",
		"models/props_wasteland/controlroom_filecabinet002a.mdl",
		"models/props_wasteland/controlroom_storagecloset001a.mdl",
		"models/props_wasteland/kitchen_shelf002a.mdl",
		"models/props_wasteland/kitchen_shelf001a.mdl",
		"models/props_c17/display_cooler01a.mdl"
	}
GMS_SpawnLists["Iron - Lighting"] =
	{
		"models/props_c17/light_cagelight02_on.mdl",
		"models/props_c17/light_cagelight01_on.mdl",
		"models/props_wasteland/prison_lamp001c.mdl",
		"models/props_wasteland/prison_lamp001a.mdl",
		"models/props_wasteland/prison_lamp001b.mdl",
		"models/props_c17/lamp_standard_off01.mdl",
		"models/props_c17/lamp_bell_on.mdl",
		"models/props_c17/light_decklight01_on.mdl",
		"models/props_c17/light_floodlight02_off.mdl",
		"models/props_wasteland/light_spotlight02_base.mdl",
		"models/props_wasteland/light_spotlight02_lamp.mdl",
		"models/props_wasteland/light_spotlight01_base.mdl",
		"models/props_wasteland/light_spotlight01_lamp.mdl",
		"models/props_trainstation/Column_Light001b.mdl",
		"models/props_trainstation/Column_Light001a.mdl",
		"models/props_trainstation/light_128wallMounted001a.mdl",
		"models/props_c17/LampFixture01a.mdl",
		"models/props_c17/lamppost03a_on.mdl",
		"models/props_c17/Traffic_Light001a.mdl",
		"models/props_trainstation/TrackLight01.mdl",
		"models/props_trainstation/light_Signal002a.mdl",
		"models/props_trainstation/light_Signal001a.mdl",
		"models/props_trainstation/light_Signal001b.mdl"
	}
GMS_SpawnLists["Iron - Containers"] =
	{
		"models/props_junk/garbage_metalcan001a.mdl",
		"models/props_junk/garbage_metalcan002a.mdl",
		"models/props_junk/PopCan01a.mdl",
		"models/props_interiors/pot01a.mdl",
		"models/props_c17/metalPot002a.mdl",
		"models/props_interiors/pot02a.mdl",
		"models/props_c17/metalPot001a.mdl",
		"models/props_junk/metal_paintcan001a.mdl",
		"models/props_junk/metalgascan.mdl",
		"models/props_junk/MetalBucket01a.mdl",
		"models/props_junk/MetalBucket02a.mdl",
		"models/props_trainstation/trashcan_indoor001b.mdl",
		"models/props_trainstation/trashcan_indoor001a.mdl",
		"models/props_c17/oildrum001.mdl",
		"models/props_c17/canister01a.mdl",
		"models/props_c17/canister02a.mdl",
		"models/props_c17/canister_propane01a.mdl"
	}
GMS_SpawnLists["Iron - Signs"] =
	{
		"models/props_c17/streetsign005d.mdl",
		"models/props_c17/streetsign005c.mdl",
		"models/props_c17/streetsign005b.mdl",
		"models/props_c17/streetsign004f.mdl",
		"models/props_c17/streetsign004e.mdl",
		"models/props_c17/streetsign003b.mdl",
		"models/props_c17/streetsign002b.mdl",
		"models/props_c17/streetsign001c.mdl",
		"models/props_trainstation/TrackSign01.mdl",
		"models/props_trainstation/clock01.mdl",
		"models/props_trainstation/trainstation_clock001.mdl"
	}
GMS_SpawnLists["Copper - Signs"] =
	{
		"models/props_trainstation/TrackSign02.mdl",
		"models/props_trainstation/TrackSign03.mdl",
		"models/props_trainstation/TrackSign10.mdl",
		"models/props_trainstation/TrackSign09.mdl",
		"models/props_trainstation/TrackSign08.mdl",
		"models/props_trainstation/TrackSign07.mdl"
	}
GMS_SpawnLists["Iron - Rails"] =
	{
		"models/props_trainstation/handrail_64decoration001a.mdl",
		"models/props_c17/Handrail04_short.mdl",
		"models/props_c17/Handrail04_Medium.mdl",
		"models/props_c17/Handrail04_corner.mdl",
		"models/props_c17/Handrail04_long.mdl",
		"models/props_c17/Handrail04_SingleRise.mdl",
		"models/props_c17/Handrail04_DoubleRise.mdl"
	}
GMS_SpawnLists["Copper - Fencing"] =
	{
		"models/props_wasteland/interior_fence002a.mdl",
		"models/props_wasteland/interior_fence002e.mdl",
		"models/props_wasteland/interior_fence001g.mdl",
		"models/props_wasteland/interior_fence002f.mdl",
		"models/props_wasteland/interior_fence002c.mdl",
		"models/props_wasteland/interior_fence002d.mdl",
		"models/props_wasteland/interior_fence004b.mdl",
		"models/props_wasteland/interior_fence004a.mdl",
		"models/props_wasteland/exterior_fence002a.mdl",
		"models/props_wasteland/exterior_fence003a.mdl",
		"models/props_wasteland/exterior_fence003b.mdl",
		"models/props_wasteland/exterior_fence002c.mdl",
		"models/props_wasteland/exterior_fence002d.mdl",
		"models/props_wasteland/exterior_fence001a.mdl",
		"models/props_wasteland/exterior_fence002e.mdl"
	}
GMS_SpawnLists["Iron - Doors/Plating/Beams"] =
	{
		"models/props_c17/door02_double.mdl",
		"models/props_c17/door01_left.mdl",
		"models/props_borealis/borealis_door001a.mdl",
		"models/props_interiors/refrigeratorDoor02a.mdl",
		"models/props_interiors/refrigeratorDoor01a.mdl",
		"models/props_building_details/Storefront_Template001a_Bars.mdl",
		"models/props_c17/gate_door01a.mdl",
		"models/props_c17/gate_door02a.mdl",
		"models/props_junk/ravenholmsign.mdl",
		"models/props_debris/metal_panel02a.mdl",
		"models/props_debris/metal_panel01a.mdl",
		"models/props_junk/TrashDumpster02b.mdl",
		"models/props_lab/blastdoor001a.mdl",
		"models/props_lab/blastdoor001b.mdl",
		"models/props_lab/blastdoor001c.mdl",
		"models/props_trainstation/trainstation_post001.mdl",
		"models/props_c17/signpole001.mdl",
		"models/props_junk/harpoon002a.mdl",
		"models/props_c17/metalladder002b.mdl",
		"models/props_c17/metalladder002.mdl",
		"models/props_c17/metalladder003.mdl",
		"models/props_c17/metalladder001.mdl",
		"models/props_junk/iBeam01a.mdl",
		"models/props_junk/iBeam01a_cluster01.mdl"
	}
GMS_SpawnLists["Iron - Vehicles"] =
	{
		"models/props_junk/Wheebarrow01a.mdl",
		"models/props_junk/PushCart01a.mdl",
		"models/props_wasteland/gaspump001a.mdl",
		"models/props_wasteland/wheel01.mdl",
		"models/props_wasteland/wheel01a.mdl",
		"models/props_wasteland/wheel03b.mdl",
		"models/props_wasteland/wheel02b.mdl",
		"models/props_wasteland/wheel02a.mdl",
		"models/props_wasteland/wheel03a.mdl",
		"models/props_citizen_tech/windmill_blade002a.mdl",
		"models/airboat.mdl",
		"models/buggy.mdl",
		"models/props_vehicles/car002a_physics.mdl",
		"models/props_vehicles/car001b_hatchback.mdl",
		"models/props_vehicles/car001a_hatchback.mdl",
		"models/props_vehicles/car003a_physics.mdl",
		"models/props_vehicles/car003b_physics.mdl",
		"models/props_vehicles/car004a_physics.mdl",
		"models/props_vehicles/car004b_physics.mdl",
		"models/props_vehicles/car005a_physics.mdl",
		"models/props_vehicles/car005b_physics.mdl",
		"models/props_vehicles/van001a_physics.mdl",
		"models/props_vehicles/truck003a.mdl",
		"models/props_vehicles/truck002a_cab.mdl",
		"models/props_vehicles/trailer002a.mdl",
		"models/props_vehicles/truck001a.mdl",
		"models/props_vehicles/generatortrailer01.mdl",
		"models/props_vehicles/apc001.mdl",
		"models/combine_apc_wheelcollision.mdl",
		"models/props_vehicles/trailer001a.mdl",
		"models/props_trainstation/train003.mdl",
		"models/props_trainstation/train002.mdl",
		"models/props_combine/combine_train02a.mdl",
		"models/props_combine/CombineTrain01a.mdl",
		"models/props_combine/combine_train02b.mdl",
		"models/props_trainstation/train005.mdl"
	}
GMS_SpawnLists["Other-Props"] =
	{
		"models/props_c17/chair_stool01a.mdl"
	}
	
GMS_SpawnLists["Iron - Seating"] =
	{
		"models/props_c17/chair_stool01a.mdl",
		"models/props_c17/chair02a.mdl",
		"models/props_c17/chair_office01a.mdl",
		"models/props_wasteland/controlroom_chair001a.mdl",
		"models/props_c17/chair_kleiner03a.mdl",
		"models/props_trainstation/traincar_seats001.mdl",
		"models/props_c17/FurnitureBed001a.mdl",
		"models/props_wasteland/prison_bedframe001b.mdl",
		"models/props_c17/FurnitureBathtub001a.mdl",
		"models/props_interiors/BathTub01a.mdl"
	}
GMS_SpawnLists["Iron - Misc/Buttons"] =
	{
		"models/props_c17/TrapPropeller_Lever.mdl",
		"models/props_c17/TrapPropeller_Engine.mdl",
		"models/props_c17/TrapPropeller_Blade.mdl",
		"models/props_junk/sawblade001a.mdl",
		"models/props_trainstation/payphone001a.mdl",
		"models/props_wasteland/prison_throwswitchlever001.mdl",
		"models/props_wasteland/prison_throwswitchbase001.mdl",
		"models/props_wasteland/tram_lever01.mdl",
		"models/props_wasteland/tram_leverbase01.mdl",
		"models/props_wasteland/panel_leverHandle001a.mdl",
		"models/props_wasteland/panel_leverBase001a.mdl",
		"models/props_lab/tpplug.mdl",
		"models/props_lab/tpplugholder_single.mdl",
		"models/props_lab/tpplugholder.mdl",
		"models/props_c17/cashregister01a.mdl"
	}
GMS_SpawnLists["Wood - PHX"] =
	{
		"models/props_phx/construct/wood/wood_boardx1.mdl",
		"models/props_phx/construct/wood/wood_boardx2.mdl",
		"models/props_phx/construct/wood/wood_boardx4.mdl",
		"models/props_phx/construct/wood/wood_panel1x1.mdl",
		"models/props_phx/construct/wood/wood_panel1x2.mdl",
		"models/props_phx/construct/wood/wood_panel2x2.mdl",
		"models/props_phx/construct/wood/wood_panel2x4.mdl",
		"models/props_phx/construct/wood/wood_panel4x4.mdl",
		"models/props_phx/construct/wood/wood_wire1x1.mdl",
		"models/props_phx/construct/wood/wood_wire1x1x1.mdl",
		"models/props_phx/construct/wood/wood_wire1x1x2.mdl",
		"models/props_phx/construct/wood/wood_wire1x1x2b.mdl",
		"models/props_phx/construct/wood/wood_wire1x2.mdl",
		"models/props_phx/construct/wood/wood_wire1x2b.mdl",
		"models/props_phx/construct/wood/wood_wire1x2x2b.mdl",
		"models/props_phx/construct/wood/wood_wire2x2.mdl",
		"models/props_phx/construct/wood/wood_wire2x2b.mdl",
		"models/props_phx/construct/wood/wood_wire2x2x2b.mdl"
	}
GMS_SpawnLists["Iron - PHX"] =
	{
		"models/props_phx/construct/metal_plate1.mdl",
		"models/props_phx/construct/metal_plate1x2.mdl",
		"models/props_phx/construct/metal_plate2x2.mdl",
		"models/props_phx/construct/metal_plate2x4.mdl",
		"models/props_phx/construct/metal_plate4x4.mdl",
		"models/props_phx/construct/metal_wire1x1.mdl",
		"models/props_phx/construct/metal_wire1x1x1.mdl",
		"models/props_phx/construct/metal_wire1x1x2.mdl",
		"models/props_phx/construct/metal_wire1x1x2b.mdl",
		"models/props_phx/construct/metal_wire1x2.mdl",
		"models/props_phx/construct/metal_wire1x2b.mdl",
		"models/props_phx/construct/metal_wire1x2x2b.mdl",
		"models/props_phx/construct/metal_wire2x2.mdl",
		"models/props_phx/construct/metal_wire2x2b.mdl",
		"models/props_phx/construct/metal_wire2x2x2b.mdl"
	}
	
GMS_SpawnLists["SMP - SoftWood"] =
	{
		"models/NightReaper/Softwood/5x5x5_block_small.mdl",
		"models/NightReaper/Softwood/5x5x25_beam_tiny.mdl",
		"models/NightReaper/Softwood/5x5x50_beam_short.mdl",
		"models/NightReaper/Softwood/5x5x75_beam_medium.mdl",
		"models/NightReaper/Softwood/5x5x100_beam_long.mdl",
		"models/NightReaper/Softwood/10x10x10_block_large.mdl",
		"models/NightReaper/Softwood/10x10x25_beam_tiny.mdl",
		"models/NightReaper/Softwood/10x10x50_beam_short.mdl",
		"models/NightReaper/Softwood/10x10x75_beam_medium.mdl",
		"models/NightReaper/Softwood/10x10x100_beam_long.mdl",
		"models/NightReaper/Softwood/5x25x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x50x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x50x50_panel_flat.mdl",
		"models/NightReaper/Softwood/5x75x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x75x50_panel_flat.mdl",
		"models/NightReaper/Softwood/5x75x75_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x25_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x75_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x50_panel_flat.mdl",
		"models/NightReaper/Softwood/5x100x100_panel_flat.mdl",
		"models/NightReaper/Softwood/5x40x85_door.mdl",
		"models/NightReaper/Softwood/5x50x100_doorway.mdl",
		"models/NightReaper/Softwood/5x100x100_doorway.mdl",
		"models/NightReaper/Softwood/5x100x100_double_doorway.mdl",
		"models/NightReaper/Softwood/5x50x100_window.mdl",
		"models/NightReaper/Softwood/5x50x100_high_window.mdl",
		"models/NightReaper/Softwood/5x50x100_full_window.mdl",
		"models/NightReaper/Softwood/5x100x100_window.mdl",
		"models/NightReaper/Softwood/5x100x100_high_window.mdl",
		"models/NightReaper/Softwood/5x100x100_full_window.mdl"
	}

GMS_SpawnLists["SMP - Concrete"] =
	{
		"models/NightReaper/Concrete/5x5x5_block_small.mdl",
		"models/NightReaper/Concrete/5x5x25_beam_tiny.mdl",
		"models/NightReaper/Concrete/5x5x50_beam_short.mdl",
		"models/NightReaper/Concrete/5x5x75_beam_medium.mdl",
		"models/NightReaper/Concrete/5x5x100_beam_long.mdl",
		"models/NightReaper/Concrete/10x10x10_block_large.mdl",
		"models/NightReaper/Concrete/10x10x25_beam_tiny.mdl",
		"models/NightReaper/Concrete/10x10x50_beam_short.mdl",
		"models/NightReaper/Concrete/10x10x75_beam_medium.mdl",
		"models/NightReaper/Concrete/10x10x100_beam_long.mdl",
		"models/NightReaper/Concrete/5x25x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x50x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x50x50_panel_flat.mdl",
		"models/NightReaper/Concrete/5x75x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x75x50_panel_flat.mdl",
		"models/NightReaper/Concrete/5x75x75_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x25_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x75_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x50_panel_flat.mdl",
		"models/NightReaper/Concrete/5x100x100_panel_flat.mdl",
		"models/NightReaper/Concrete/5x40x85_door.mdl",
		"models/NightReaper/Concrete/5x50x100_doorway.mdl",
		"models/NightReaper/Concrete/5x100x100_doorway.mdl",
		"models/NightReaper/Concrete/5x100x100_double_doorway.mdl",
		"models/NightReaper/Concrete/5x50x100_window.mdl",
		"models/NightReaper/Concrete/5x50x100_high_window.mdl",
		"models/NightReaper/Concrete/5x50x100_full_window.mdl",
		"models/NightReaper/Concrete/5x100x100_window.mdl",
		"models/NightReaper/Concrete/5x100x100_high_window.mdl",
		"models/NightReaper/Concrete/5x100x100_full_window.mdl"
	}

	
GMS.TreeModels = {
                 "models/props/de_inferno/tree_large.mdl",
                 "models/props/de_inferno/tree_small.mdl",
                 "models/props_foliage/tree_deciduous_03a.mdl",
                 "models/props_foliage/tree_deciduous_01a.mdl",
                 "models/props_foliage/oak_tree01.mdl",
                 "models/props_foliage/tree_cliff_01a.mdl",
				 "models/props_foliage/tree_deciduous_01a-lod.mdl",
				 "models/props_foliage/tree_deciduous_02a.mdl",
				 "models/props_foliage/tree_pine_large.mdl",
				 "models/props_foliage/tree_pine06.mdl",
				 "models/props_foliage/tree_pine05.mdl",
				 "models/props_foliage/tree_pine04.mdl",
				 "models/props_foliage/fallentree01.mdl",
				 "models/props_foliage/fallentree02.mdl"
}

                 
GMS.EdibleModels = {
                   "models/props/cs_italy/orange.mdl",
                   "models/props_junk/watermelon01.mdl",
                   "models/props/cs_italy/bananna_bunch.mdl"
                   }
                   
GMS.RockModels = {
                   "models/props_wasteland/rockgranite02a.mdl",
                   "models/props_wasteland/rockgranite02b.mdl",
                   "models/props_wasteland/rockgranite02c.mdl",
                   "models/props_wasteland/rockgranite03a.mdl",
                   "models/props_wasteland/rockgranite03b.mdl",
                   "models/props_wasteland/rockcliff01b.mdl",
                   "models/props_wasteland/rockcliff01c.mdl",
                   "models/props_wasteland/rockcliff01e.mdl",
                   "models/props_wasteland/rockcliff01f.mdl",
                   "models/props_wasteland/rockcliff01g.mdl",
                   "models/props_wasteland/rockcliff01J.mdl",
                   "models/props_wasteland/rockcliff01k.mdl",
                   "models/props_wasteland/rockcliff05a.mdl",
                   "models/props_wasteland/rockcliff05b.mdl",
                   "models/props_wasteland/rockcliff05e.mdl",
                   "models/props_wasteland/rockcliff05f.mdl",
                   "models/props_wasteland/rockcliff06d.mdl",
                   "models/props_wasteland/rockcliff06i.mdl",
				   "models/props_canal/rock_riverbed01a.mdl",
					"models/props_canal/rock_riverbed01b.mdl",
					"models/props_canal/rock_riverbed01c.mdl",
					"models/props_canal/rock_riverbed01d.mdl",
					"models/props_canal/rock_riverbed02a.mdl",
					"models/props_canal/rock_riverbed02b.mdl",
					"models/props_canal/rock_riverbed02c.mdl",
					"models/props_wasteland/rockcliff_cluster01b.mdl",
					"models/props_wasteland/rockcliff_cluster02a.mdl",
					"models/props_wasteland/rockcliff_cluster02b.mdl",
					"models/props_wasteland/rockcliff_cluster02c.mdl",
					"models/props_wasteland/rockcliff_cluster03a.mdl",
					"models/props_wasteland/rockcliff_cluster03b.mdl",
					"models/props_wasteland/rockcliff_cluster03c.mdl",
					"models/props_wasteland/rockcliff05a.mdl",
					"models/cliffs/rocks_large01_veg.mdl",
					"models/cliffs/rocks_large02_veg.mdl",
					"models/cliffs/rocks_large03_veg.mdl",
					"models/cliffs/rocks_medium01.mdl",
					"models/cliffs/rocks_medium02.mdl",
					"models/cliffs/rocks_medium03.mdl",
					"models/cliffs/rocks_small01.mdl",
					"models/cliffs/rocks_small02.mdl",
					"models/cliffs/rocks_small03.mdl",
					"models/cliffs/rockcluster01.mdl",
					"models/cliffs/rockcluster02.mdl"
	}
                   
GMS.SmallRockModel = "models/props_junk/rock001a.mdl"

GMS.PickupProhibitedClasses = {"gms_seed"}
                   
GMS.MaterialResources = {}
GMS.MaterialResources[MAT_CONCRETE] = "Concrete"
GMS.MaterialResources[MAT_METAL] = "Iron"
GMS.MaterialResources[MAT_DIRT] = "Wood"
GMS.MaterialResources[MAT_VENT] = "Copper"
GMS.MaterialResources[MAT_GRATE] = "Copper"
GMS.MaterialResources[MAT_TILE] = "Stone"
GMS.MaterialResources[MAT_SLOSH] = "Wood"
GMS.MaterialResources[MAT_WOOD] = "Wood"
GMS.MaterialResources[MAT_COMPUTER] = "Copper"
GMS.MaterialResources[MAT_GLASS] = "Glass"
GMS.MaterialResources[MAT_FLESH] = "Wood"
GMS.MaterialResources[MAT_BLOODYFLESH] = "Wood"
GMS.MaterialResources[MAT_CLIP] = "Wood"
GMS.MaterialResources[MAT_ANTLION] = "Wood"
GMS.MaterialResources[MAT_ALIENFLESH] = "Wood"
GMS.MaterialResources[MAT_FOLIAGE] = "Wood"
GMS.MaterialResources[MAT_SAND] = "Wood"
GMS.MaterialResources[MAT_PLASTIC] = "Plastic"

GMS.Skills = {}
table.insert(GMS.Skills,"Mining")
--table.insert(GMS.Skills,"Smithing")
table.insert(GMS.Skills,"Harvesting")
table.insert(GMS.Skills,"Cooking")
table.insert(GMS.Skills,"Lumbering")
table.insert(GMS.Skills,"Construction")
--table.insert(GMS.Skills,"Carpentry")
table.insert(GMS.Skills,"Survival")
table.insert(GMS.Skills,"Weapon_Crafting")
table.insert(GMS.Skills,"Smithing")
--table.insert(GMS.Skills,"Technology")

GMS.Resources = {}
table.insert(GMS.Resources,"Copper_Ore")
table.insert(GMS.Resources,"Iron_Ore")
table.insert(GMS.Resources,"Stone")
table.insert(GMS.Resources,"Copper")
table.insert(GMS.Resources,"Iron")
table.insert(GMS.Resources,"Metal")
table.insert(GMS.Resources,"Charcoal")
table.insert(GMS.Resources,"Sulphur")
table.insert(GMS.Resources,"Urine_Bottles")
table.insert(GMS.Resources,"Medicine")
table.insert(GMS.Resources,"Saltpetre")
table.insert(GMS.Resources,"Gunslide")
table.insert(GMS.Resources,"Gungrip")
table.insert(GMS.Resources,"Gunbarrel")
table.insert(GMS.Resources,"Gunmagazine")
table.insert(GMS.Resources,"Gunpowder")
table.insert(GMS.Resources,"Wood")
table.insert(GMS.Resources,"Sprouts")
table.insert(GMS.Resources,"Trout")
table.insert(GMS.Resources,"Bass")
table.insert(GMS.Resources,"Salmon")
table.insert(GMS.Resources,"Shark")
table.insert(GMS.Resources,"Herbs")
table.insert(GMS.Resources,"Raw_Meat")
table.insert(GMS.Resources,"Glass")
table.insert(GMS.Resources,"Plastic")
table.insert(GMS.Resources,"Coal")
table.insert(GMS.Resources,"Steel")
table.insert(GMS.Resources,"Arrows")
table.insert(GMS.Resources,"Feathers")
table.insert(GMS.Resources,"Rocks X10")
table.insert(GMS.Resources,"Leaves")
table.insert(GMS.Resources,"Salt")
table.insert(GMS.Resources,"Diamond")
table.insert(GMS.Resources,"Refined_Diamond")
table.insert(GMS.Resources,"Concrete")


GMS.ConVarList = {
                  "gms_FreeBuild",
                  "gms_AllTools",
                  "gms_AutoSave",
                  "gms_AutoSaveTime",
                  "gms_physgun",
                  "gms_ReproduceTrees",
                  "gms_MaxReproducedTrees",
                  "gms_AllowSWEPSpawn",
                  "gms_AllowSENTSpawn",
				  "gms_Alerts",
				  "gms_SpreadFire",
				  "gms_FadeRocks",
				  "gms_CostsScale",
				  "gms_Campfire",
				  "gms_PlantLimit"
                  }

GMS.SavedClasses = {"prop_physics",
                    "prop_physics_override",
                    "prop_physics_multiplayer",
                    "prop_dynamic",
                    "prop_effect",
                    "gms_stoneworkbench",
					"gms_copperworkbench",
					"gms_ironworkbench",
					"gms_advancedworkbench",
                    "gms_stove",
                    "gms_buildsite",
                    "gms_resourcedrop",
                    "gms_stonefurnace",
					"gms_copperfurnace",
					"gms_ironfurnace",
					"gms_antlionbarrow",
					"gms_loot",
					"gms_factory",
					"gms_gunchunks",
					"gms_gunlab",
					"gms_seed",
					"gms_grindingstone",
					"gms_mail",
					"gms_waterfountain"					
					
                    }

GMS.StructureEntities = {"gms_stoneworkbench",
					"gms_copperworkbench",
					"gms_ironworkbench",
					"gms_advancedworkbench",
                    "gms_stove",
                    "gms_buildsite",
                    "gms_stonefurnace",
					"gms_copperfurnace",
					"gms_ironfurnace",
					"gms_factory",
					"gms_gunchunks",
					"gms_gunlab",
					"gms_grindingstone",
					"gms_waterfountain"
}
					
GMS.SleepingFurniture = {
	"models/props_interiors/Furniture_Couch01a.mdl",
	"models/props_c17/FurnitureCouch002a.mdl",
	"models/props_c17/FurnitureCouch001a.mdl",
	"models/props_c17/FurnitureBed001a.mdl",
	"models/props_wasteland/prison_bedframe001b.mdl",
	"models/props_trainstation/traincar_seats001.mdl"
}

GMS_Upgrades = {
"Half_Price_Props",
"Quarter_Process_Time",
"Half_Process_Time",
"InstantPlant",
"Wild_Man",
"Mr_Survival",
"Flying_Man",
"Tribe_Totem",
"Christmas_09",
"New_Years",
"StoneAge",
"IronAge",
"CopperAge",
"Mans_Best_Friend",
"Mechanic",
"Time_Waster",
"Sprint Man",
"Adapted",
"Scientist"
}
GMS_UpgradeEnt = {}
local c2 = GMS_UpgradeEnt
c2["Half_Price_Props"] = "gms_trophy_halfpriceprops"
c2["Half_Process_Time"] = "gms_trophy_halfspeed"
c2["InstantPlant"] = "gms_trophy_instantplant"
c2["Quarter_Process_Time"] = "gms_trophy_quarterspeed"
c2["Wild_Man"] = "gms_trophy_wildman"
c2["Mr_Survival"] = "gms_trophy_mrsurvival"
c2["Flying_Man"] = "gms_trophy_noclip"
c2["Tribe_Totem"] = "gms_trophy_totem"
c2["StoneAge"] = "gms_trophy_stoneage"
c2["IronAge"] = "gms_trophy_ironage"
c2["CopperAge"] = "gms_trophy_copperage"
c2["Mechanic"] = "gms_trophy_mechanic"
c2["Mans_Best_Friend"] = "gms_trophy_mansbestfriend"
c2["Time_Waster"] = "gms_trophy_timewaster"
c2["Sprint Man"] = "gms_trophy_sprintman"
c2["Adapted"] = "gms_trophy_adapted"
c2["Scientist"] = "gms_trophy_scientist"

--Special
c2["Christmas_09"] = "gms_trophy_christmastree"
c2["New_Years"] = "gms_trophy_newyears"


GMS_LevelReq = {}
local c = GMS_LevelReq
c["Half_Price_Props"] = 0
c["Half_Process_Time"] = 0
c["InstantPlant"] = 75
c["Quarter_Process_Time"] = 200
c["Wild_Man"] = 250
c["Mr_Survival"] = 300
c["Flying_Man"] = 0
c["Tribe_Totem"] = 350
c["Christmas_09"] = 0
c["New_Years"] = 0
c["StoneAge"] = 100
c["IronAge"] = 300
c["CopperAge"] = 200
c["Mechanic"] = 250
c["Mans_Best_Friend"] = 0
c["Time_Waster"] = 0
c["Sprint Man"] = 0
c["Adapted"] = 0
c["Scientist"] = 0


GMS_Uncloneable = {
"Diamond",
"Refined_Diamond",
"Coal",
"Steel",
"Gunslide",
"Gungrip",
"Gunbarrel",
"Gunmagazine",

}

GMS_CloneUpgrades = {}
--MAX CAPACITY
GMS_CloneUpgrades["MaxCapacity"] = {}
local c = GMS_CloneUpgrades["MaxCapacity"]
	local amount = 1
	c[amount] = {}
		c[amount]["Cost"] = 50
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 25
	local amount = 2
	c[amount] = {}
		c[amount]["Cost"] = 100
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 100
	local amount = 3
	c[amount] = {}
		c[amount]["Cost"] = 2
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 250
	local amount = 4
	c[amount] = {}
		c[amount]["Cost"] = 4
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 500
	local amount = 5
	c[amount] = {}
		c[amount]["Cost"] = 10
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 1000
	--TIME LAPSE
GMS_CloneUpgrades["TimeLapse"] = {}
local c = GMS_CloneUpgrades["TimeLapse"]
	local amount = 1
	c[amount] = {}
		c[amount]["Cost"] = 50
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 60
	local amount = 2
	c[amount] = {}
		c[amount]["Cost"] = 100
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 45
	local amount = 3
	c[amount] = {}
		c[amount]["Cost"] = 2
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 30
	local amount = 4
	c[amount] = {}
		c[amount]["Cost"] = 4
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 15
	local amount = 5
	c[amount] = {}
		c[amount]["Cost"] = 4
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 5
	--RATE
GMS_CloneUpgrades["Rate"] = {}
local c = GMS_CloneUpgrades["Rate"]
	local amount = 1
	c[amount] = {}
		c[amount]["Cost"] = 50
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 10
	local amount = 2
	c[amount] = {}
		c[amount]["Cost"] = 100
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 25
	local amount = 3
	c[amount] = {}
		c[amount]["Cost"] = 5
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 50
	local amount = 4
	c[amount] = {}
		c[amount]["Cost"] = 10
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 100
	local amount = 5
	c[amount] = {}
		c[amount]["Cost"] = 10
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 150
	--FuelRate
GMS_CloneUpgrades["FuelRate"] = {}
local c = GMS_CloneUpgrades["FuelRate"]
	local amount = 1
	c[amount] = {}
		c[amount]["Cost"] = 2
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 20
	local amount = 2
	c[amount] = {}
		c[amount]["Cost"] = 5
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 15
	local amount = 3
	c[amount] = {}
		c[amount]["Cost"] = 10
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 10
	local amount = 4
	c[amount] = {}
		c[amount]["Cost"] = 20
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 5
	local amount = 5
	c[amount] = {}
		c[amount]["Cost"] = 20
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 1
	--MaxFuel
GMS_CloneUpgrades["MaxFuel"] = {}
local c = GMS_CloneUpgrades["MaxFuel"]
	local amount = 1
	c[amount] = {}
		c[amount]["Cost"] = 100
		c[amount]["Res"] = "Diamond"
		c[amount]["Value"] = 75
	local amount = 2
	c[amount] = {}
		c[amount]["Cost"] = 2
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 100
	local amount = 3
	c[amount] = {}
		c[amount]["Cost"] = 5
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 125
	local amount = 4
	c[amount] = {}
		c[amount]["Cost"] = 10
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 150
	local amount = 5
	c[amount] = {}
		c[amount]["Cost"] = 10
		c[amount]["Res"] = "Refined_Diamond"
		c[amount]["Value"] = 200




GMS.ProhibitedStools = {
	"muscle",
	"pulley",
	"slider",
	"balloon",
	"duplicator",
	"dynamite",
	"emitter",
	"hoverball",
	"ignite",
	"magnetise",
	"physprop",
	"spawner",
	"thruster",
	"turret",
	"wheel",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	"statue",
	"resize",
	"resizer"
}

GMS.TrustedAllowedTools = {
	"thruster",
	"wheel",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	"statue",
	"hoverball",
	"balloon"
}
	

GMS_QuestSkills = {
"Fishing",
"Cooking",
"Weapon_Crafting",
"Mining",
"Lumbering",
"Harvesting",
"Construction",
"Smithing",
"Planting"
}

GMS.Skills = {}
table.insert(GMS.Skills,"Mining")
table.insert(GMS.Skills,"Harvesting")
table.insert(GMS.Skills,"Cooking")
table.insert(GMS.Skills,"Lumbering")
table.insert(GMS.Skills,"Construction")
--table.insert(GMS.Skills,"Carpentry")
table.insert(GMS.Skills,"Survival")
table.insert(GMS.Skills,"Weapon_Crafting")
table.insert(GMS.Skills,"Smithing")

GMS_QuestRes = {
"Wood",
"Iron",
"Copper",
"Diamond",
"Steel",
"Coal",
"Water_Bottles",
"Copper_Ore",
"Iron_Ore",
"Stone",
"Sprouts",
"Glass",
"Leaves",
"Trout",
"Bass",
"Shark",
"Herbs",
"Urine_Bottles",
"Feathers"
}

GMS_QuestStarts = {
"dog",
"cat",
"miner",
"cart",
"cousin",
"computer",
"welder",
"pickaxe",
"hatchet",
"box of chocolates",
"furnace",
"workbench",
"chicken",
"building site",
"melon",
"door",
"steam account",
"friend",
"robot",
"fan",
"pie",
"vagina",
"brother",
"mother",
"father",
"sister",
"uncle",
"speaker",
"forum",
"window",
"water bottle",
"cup",
"gloves",
"clone machine",
"parkour map",
"map",
"thingy",
"lol wat",
":-D",
"donkey",
"mouse",
"letter d",
"ventrilo",
"teamspeak",
"gmod",
"crowbar",
"pipboy 3000",
"C3P0",
"light saber",
"microphone",
"variable",
"clock",
"chicken",
"small kids",
"temple",
"santa",
"reindeer",
"cactus",
"christmas tree"
}

GMS_QuestMiddle = {
"broken down",
"fallen in the water",
"dissapeared",
"found a secret room",
"fallen off a cliff",
"been eaten by a minge",
"gone to kfc",
"logged off steam",
"gotten high",
"gotten stabbed",
"got molested by santa",
"just gotten married",
"a pie",
"a donkey",
"lost its crowbar",
"hard nipples",
"gone to church",
"left me alone",
"started building an ark",
"shot its foot",
"come here from neverland",
"bought me acid not weed",
"won the lottery",
"crashed its computer",
"found out i am a program",
"called me stupid",
"insulted this random generator thing",
"done the robot",
"installed win antivirus pro",
"gotten its steam account stolen",
"talked to Bithmar",
"talked to Mech",
"talked to an awol person",
"run the wrong .exe",
"got caught masterbating",
"a vagina",
"a penis",
"a bottom",
"wonderd were god came from",
"bought a shamwow"
}

GMS_QuestEnd = {
"fly back to neverland",
"log back on steam",
"scam some noob",
"kidnap santa",
"join awol",
"split the atom",
"cool itself back down",
"give the world aids",
"earn some cash",
"build a better pickaxe",
"build a better hatchet",
"build a furnace",
"build a workbench",
"buy mcdonalds",
"drive a car",
"compile a program",
"plant a tree",
"get some sprouts",
"fire ma lazor",
"upgrade the graphics",
"code a lua virus",
"download win antivirus pro",
"pay the loan sharks",
"think of a kwl quest",
"drink a duck",
"say wow everytime it uses that towel",
"sleep in the gutter",
"die of hunger",
"not die of hunger",
"die",
"not die",
"come back alive",
"fly a kyte",
"do a barrel roll",
"jizz on your mum",
"get unstuck",
"find the rcon password",
"install media player",
"log onto 4chan",
"ddos a server",
"complete his stupid quest",
"hit the back button",
"do a backflip",
"clean the toilet",
"fuck shit fuck, sorry i have tourretes",
"bring all the boys to the yard"
}

	

