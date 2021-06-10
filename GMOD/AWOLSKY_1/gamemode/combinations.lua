/*---------------------------------------------------------
  Combinations system
---------------------------------------------------------*/
GMS.Combinations = {}
function GMS.RegisterCombi(name,tbl,group)
	if !GMS.Combinations[group] then GMS.Combinations[group] = {} end
	GMS.Combinations[group][name] = tbl
end
/*---------------------------------------------------------

  Buildings / big stuff

---------------------------------------------------------*/
/*---------------------------------------------------------
  Stone Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Workbench"
COMBI.Description = [[This stone table has various fine specialized equipment
 used in crafting basic items.
You need:
40 Stone
30 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 30
COMBI.Req["Stone"] = 40

COMBI.Results = {}
COMBI.Results = "gms_stoneworkbench"
COMBI.BuildSiteModel = "models/props/cs_italy/it_mkt_table3.mdl"

GMS.RegisterCombi("StoneWorkbench",COMBI,"Buildings")

/*---------------------------------------------------------
Tool Rack
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Tool Rack"
COMBI.Description = [[Stores varius tools
You need:
100 Stone
100 Wood
100 Unobtainium
100 Platinum
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 100
COMBI.Req["Stone"] = 100
COMBI.Req["Platinum"] = 100
COMBI.Req["Unobtainium"] = 100

COMBI.Results = {}
COMBI.Results = "sent_toolrack"
COMBI.BuildSiteModel = "models/props/de_chateau/ch_wnd_b1_24.mdl"

GMS.RegisterCombi("ToolRack",COMBI,"Buildings")
/*---------------------------------------------------------
  Platinum Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum Workbench"
COMBI.Description = [[This Platinum table has various fine specialized equipment
 used in crafting quality items.
You need:
60 Platinum
20 Stone
40 Wood
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 60
COMBI.Req["Stone"] = 20
COMBI.Req["Wood"] = 40

COMBI.Results = {}
COMBI.Results = "gms_platinumworkbench"
COMBI.BuildSiteModel = "models/props_combine/breendesk.mdl"

GMS.RegisterCombi("PlatinumWorkbench",COMBI,"Buildings")
/*---------------------------------------------------------
  Unobtainium Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium Workbench"
COMBI.Description = [[This Unobtainium table has various fine specialized equipment
 used in crafting advanced items.
You need:
120 Unobtainium
40 Stone
50 Wood
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 120
COMBI.Req["Stone"] = 40
COMBI.Req["Wood"] = 50

COMBI.Results = {}
COMBI.Results = "gms_unobtainiumworkbench"
COMBI.BuildSiteModel = "models/props_wasteland/controlroom_desk001b.mdl"

GMS.RegisterCombi("UnobtainiumWorkbench",COMBI,"Buildings")

/*---------------------------------------------------------
	Advanced Workbench
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adv Workbench"
COMBI.Description = [[This Advanced table is used to make advanced tools.
You need:
200 Adamantium
300 Unobtainium
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 200
COMBI.Req["Unobtainium"] = 300

COMBI.Results = {}
COMBI.Results = "gms_advancedworkbench"
COMBI.BuildSiteModel = "models/props_wasteland/kitchen_counter001b.mdl"

GMS.RegisterCombi("AdvancedWorkbench",COMBI,"Buildings")

/*---------------------------------------------------------
	ChickenCoop
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Chicken Coop"
COMBI.Description = [[This makes chickens.
You need:
200 Adamantium
600 Wood
100 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 200
COMBI.Req["Wood"] = 600
COMBI.Req["Water_Bottles"] = 100

COMBI.Results = {}
COMBI.Results = "gms_chickspawner"
COMBI.BuildSiteModel = "models/props_lab/jar01a.mdl"

GMS.RegisterCombi("ChickenCoop",COMBI,"Buildings")

/*---------------------------------------------------------
	Teleporter
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Teleporter"
COMBI.Description = [[Somehow you use the resources below to make a teleporter.
You need:
50 Unobtainium
50 Wood
10 Acidic Water
20 Herbs
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 50
COMBI.Req["Wood"] = 50
COMBI.Req["Acidic_Water"] = 10
COMBI.Req["Herbs"] = 20

COMBI.Results = {}
COMBI.Results = "gms_teleporter"
COMBI.BuildSiteModel = "models/props_lab/teleplatform.mdl"

GMS.RegisterCombi("Teleporter",COMBI,"Buildings")

/*---------------------------------------------------------
  Drinking Fountain
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Drinking Fountain"
COMBI.Description = [[PORTABLE WATER?!
You need:
50 Platinum
50 Unobtainium
50 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 50
COMBI.Req["Unobtainium"] = 50
COMBI.Req["Water_Bottles"] = 50

COMBI.Results = {}
COMBI.Results = "gms_waterfountain"
COMBI.BuildSiteModel = "models/props_c17/furnituresink001a.mdl"

GMS.RegisterCombi("DrinkingFountain",COMBI,"Buildings")
/*---------------------------------------------------------
  Stove
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stove"
COMBI.Description = [[Using a stove, you can cook without having to light a fire.
You need:
50 Platinum
40 Unobtainium
30 Wood
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 50
COMBI.Req["Unobtainium"] = 40
COMBI.Req["Wood"] = 30

COMBI.Results = {}
COMBI.Results = "gms_stove"
COMBI.BuildSiteModel = "models/props_c17/furniturestove001a.mdl"

GMS.RegisterCombi("Stove",COMBI,"Buildings")

/*---------------------------------------------------------
Cache
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Storage Cache"
COMBI.Description = [[A cache to store reasources in. 
'any errors? Tell an admin right away. Thank you.

You need:
80 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 80

COMBI.Results = {}
COMBI.Results = "gms_storagecache"
COMBI.BuildSiteModel = "models/props/cs_militia/footlocker01_closed.mdl"



GMS.RegisterCombi("Cache",COMBI,"Buildings")

/*---------------------------------------------------------
  Stone Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Furnace"
COMBI.Description = [[You can use the furnace to smelt resources into 
another, such as Platinum Ore into Platinum.
You need:
40 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 40

COMBI.Results = {}
COMBI.Results = "gms_stonefurnace"
COMBI.BuildSiteModel = "models/props/cs_militia/refrigerator01.mdl"

GMS.RegisterCombi("StoneFurnace",COMBI,"Buildings")
/*---------------------------------------------------------
  Platinum Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum Furnace"
COMBI.Description = [[You can use the furnace to smelt resources into 
another, such as Unobtainium Ore into Unobtainium.
You need:
60 Platinum
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 60

COMBI.Results = {}
COMBI.Results = "gms_platinumfurnace"
COMBI.BuildSiteModel = "models/props/cs_militia/furnace01.mdl"

GMS.RegisterCombi("PlatinumFurnace",COMBI,"Buildings")
/*---------------------------------------------------------
  Unobtainium Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium Furnace"
COMBI.Description = [[You can use the furnace to smelt resources into 
another, such as Sand into Glass.
You need:
80 Unobtainium
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 80

COMBI.Results = {}
COMBI.Results = "gms_unobtainiumfurnace"
COMBI.BuildSiteModel = "models/props_c17/furniturefireplace001a.mdl"

GMS.RegisterCombi("UnobtainiumFurnace",COMBI,"Buildings")

/*---------------------------------------------------------
Advanced Furnace
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Advanced Furnace"
COMBI.Description = [[You can use the furnace to smelt advanced resources like Crystal.
You need:
250 Adamantium
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 250

COMBI.Results = {}
COMBI.Results = "gms_advancedfurnace"
COMBI.BuildSiteModel = "models/props_combine/combine_interface001.mdl"

GMS.RegisterCombi("AdvancedFurnace",COMBI,"Buildings")

/*---------------------------------------------------------
Trading Cart
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Trading Cart"
COMBI.Description = [[Trade gold for other resources.
You need:
150 Adamantium
50 Wood
250 Unobtainium
15 Weapon Crafting
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 150
COMBI.Req["Wood"] = 50
COMBI.Req["Unobtainium"] = 250

COMBI.Results = {}
COMBI.Results = "gms_tradingcart"

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 15

COMBI.BuildSiteModel = "models/props/de_tides/Vending_Cart.mdl"

GMS.RegisterCombi("TradingCart",COMBI,"Buildings")

/*---------------------------------------------------------
  Grinding Stone
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Grinding Stone"
COMBI.Description = [[You can use the grinding stone to smash resources 
into smaller things, such as stone into sand.
You need:
40 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 40

COMBI.Results = {}
COMBI.Results = "gms_grindingstone"
COMBI.BuildSiteModel = "models/props_combine/combine_mine01.mdl"

GMS.RegisterCombi("GrindingStone",COMBI,"Buildings")
/*---------------------------------------------------------
  Factory
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Factory"
COMBI.Description = [[You can use the factory to smelt resources into 
another and extract resources out of other resources.
You need:
200 Unobtainium
100 Platinum
50 Stone
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 200
COMBI.Req["Platinum"] = 100
COMBI.Req["Stone"] = 50

COMBI.Results = {}
COMBI.Results = "gms_factory"
COMBI.BuildSiteModel = "models/props/cs_assault/ConsolePanelLoadingBay.mdl"

GMS.RegisterCombi("Factory",COMBI,"Buildings")
/*---------------------------------------------------------
  Gunlab
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunlab"
COMBI.Description = [[For making the components of guns with relative ease.
You need:
100 Unobtainium
150 Wood
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 100
COMBI.Req["Wood"] = 150

COMBI.Results = {}
COMBI.Results = "gms_gunlab"
COMBI.BuildSiteModel = "models/props/cs_militia/gun_cabinet.mdl"

GMS.RegisterCombi("Gunlab",COMBI,"Buildings")
/*---------------------------------------------------------
  GunChunks
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gun Chunks"
COMBI.Description = [[For making the components of guns with relative ease.
You need:
50 Unobtainium
25 Platinum
25 Wood
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 50
COMBI.Req["Platinum"] = 25
COMBI.Req["Wood"] = 25

COMBI.Results = {}
COMBI.Results = "gms_gunchunks"
COMBI.BuildSiteModel = "models/Gibs/airboat_broken_engine.mdl"

GMS.RegisterCombi("Gunchunks",COMBI,"Buildings")
/*---------------------------------------------------------

  Furnace

---------------------------------------------------------*/
/*---------------------------------------------------------
  Glass
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Glass"
COMBI.Description = [[Glass can be used for making bottles and lighting.
You need:
2 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 2

COMBI.Results = {}
COMBI.Results["Glass"] = 1

GMS.RegisterCombi("Glass",COMBI,"UnobtainiumFurnace")
/*---------------------------------------------------------
  Platinum Ore to Platinum x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum1"
COMBI.Description = [[Platinum can be used to create more advanced buildings and tools.
You need:
1 Platinum Ore
]]

COMBI.Req = {}
COMBI.Req["Platinum_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Platinum"] = 1

GMS.RegisterCombi("Platinum1",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Platinum Ore to Platinum x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum5"
COMBI.Description = [[Platinum can be used to create more advanced buildings and tools.
You need:
5 Platinum Ore
]]

COMBI.Req = {}
COMBI.Req["Platinum_Ore"] = 5

COMBI.Results = {}
COMBI.Results["Platinum"] = 5

GMS.RegisterCombi("Platinum5",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Platinum Ore to Platinum x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum10"
COMBI.Description = [[Platinum can be used to create more advanced buildings and tools.
You need:
10 Platinum Ore
]]

COMBI.Req = {}
COMBI.Req["Platinum_Ore"] = 10

COMBI.Results = {}
COMBI.Results["Platinum"] = 10

GMS.RegisterCombi("Platinum10",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Platinum Ore to Platinum x25
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum25"
COMBI.Description = [[Platinum can be used to create more advanced buildings and tools.
You need:
25 Platinum Ore
]]

COMBI.Req = {}
COMBI.Req["Platinum_Ore"] = 25

COMBI.Results = {}
COMBI.Results["Platinum"] = 25

GMS.RegisterCombi("Platinum25",COMBI,"StoneFurnace")

/*---------------------------------------------------------
  Allsmelt Platinum
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Platinum"
COMBI.Description = [[Platinum can be used to create more advanced buildings and tools.
You need:
Platinum Ore (200 MAX)
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Platinum_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Platinum"] = 1

COMBI.AllSmelt = true
COMBI.Max = 200

GMS.RegisterCombi("AllSmeltPlatinum",COMBI,"StoneFurnace")
/*---------------------------------------------------------
  Unobtainium Ore to Unobtainium x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium1"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
1 Unobtainium Ore
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 1

GMS.RegisterCombi("Unobtainium1",COMBI,"PlatinumFurnace")
/*---------------------------------------------------------
 Unobtainium Ore to Unobtainium x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium5"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
5 Unobtainium Ore
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 5

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 5

GMS.RegisterCombi("Unobtainium5",COMBI,"PlatinumFurnace")
/*---------------------------------------------------------
  Unobtainium Ore to Unobtainium x50
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium50"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
50 Unobtainium Ore
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 50

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 50

GMS.RegisterCombi("Unobtainium50",COMBI,"PlatinumFurnace")
/*---------------------------------------------------------
  Unobtainium Ore to Unobtainium x100
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium100"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
100 Unobtainium Ore
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 100

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 100

GMS.RegisterCombi("Unobtainium100",COMBI,"PlatinumFurnace")
/*---------------------------------------------------------
  Unobtainium Ore to Unobtainium x25
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium25"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
25 Unobtainium Ore
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 25

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 25

GMS.RegisterCombi("Unobtainium25",COMBI,"PlatinumFurnace")

/*---------------------------------------------------------
  Allsmelt Unobtainium 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Unobtainium"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
Unobtainium Ore (500 MAX)
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 1

COMBI.AllSmelt = true
COMBI.Max = 500

GMS.RegisterCombi("AllSmeltUnobtainium",COMBI,"PlatinumFurnace")

/*---------------------------------------------------------
  Allsmelt Adamantium 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Adamantium"
COMBI.Description = [[Adamantium can be used to create more advanced buildings and tools.
You need:
Compound11 (200 MAX)
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Compound11"] = 2

COMBI.Results = {}
COMBI.Results["Adamantium"] = 1

COMBI.AllSmelt = true
COMBI.Max = 200

GMS.RegisterCombi("AllSmeltAdamantium",COMBI,"UnobtainiumFurnace")
/*---------------------------------------------------------
  100 smelt Adamantium 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adamantium100"
COMBI.Description = [[Adamantium can be used to create more advanced buildings and tools.
You need:
50 Compound11 
]]

COMBI.Req = {}
COMBI.Req["Compound11"] = 100

COMBI.Results = {}
COMBI.Results["Adamantium"] = 100

GMS.RegisterCombi("Adamantium100",COMBI,"UnobtainiumFurnace")
/*---------------------------------------------------------
  50 smelt Adamantium 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "50x Adamantium"
COMBI.Description = [[Adamantium can be used to create more advanced buildings and tools.
You need:
50 Compound11 
]]

COMBI.Req = {}
COMBI.Req["Compound11"] = 50

COMBI.Results = {}
COMBI.Results["Adamantium"] = 50

GMS.RegisterCombi("50Adamantium",COMBI,"UnobtainiumFurnace")
/*---------------------------------------------------------
  20 smelt Adamantium 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "20x Adamantium"
COMBI.Description = [[Adamantium can be used to create more advanced buildings and tools.
You need:
20 Compound11 
]]

COMBI.Req = {}
COMBI.Req["Compound11"] = 2

COMBI.Results = {}
COMBI.Results["Adamantium"] = 1

COMBI.AllSmelt = true
COMBI.Max = 20

GMS.RegisterCombi("20Adamantium",COMBI,"UnobtainiumFurnace")
/*---------------------------------------------------------
  Charcoal
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Charcoal"
COMBI.Description = [[Used in the production of gunpowder.
You need:
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 5

COMBI.Results = {}
COMBI.Results["Charcoal"] = 1

GMS.RegisterCombi("Charcoal",COMBI,"UnobtainiumFurnace")
/*---------------------------------------------------------
  Charcoal10x
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Charcoal 10x"
COMBI.Description = [[Used in the production of gunpowder.
You need:
15 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 15

COMBI.Results = {}
COMBI.Results["Charcoal"] = 10

GMS.RegisterCombi("Charcoal10",COMBI,"UnobtainiumFurnace")

/*---------------------------------------------------------
 1 Diamond
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 1x Diamond"
COMBI.Description = [[Smelts 100 Crystal into 1 Diamond
You need:
Crystal 100
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 100

COMBI.Results = {}
COMBI.Results["Diamond"] = 1


GMS.RegisterCombi("Crystal1",COMBI,"AdvancedFurnace")

/*---------------------------------------------------------
 2 Diamond
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 2x Diamond"
COMBI.Description = [[Smelts 200 Crystal into 2 Diamond
You need:
Crystal 200
Weapon Crafting 5
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 200

COMBI.Results = {}
COMBI.Results["Diamond"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 5

GMS.RegisterCombi("Crystal2",COMBI,"AdvancedFurnace")

/*---------------------------------------------------------
  5 Diamond
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 5x Diamond"
COMBI.Description = [[Smelts 500 Crystal into 5 Diamond
You need:
Crystal 500
Weapon Crafting 10
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 500

COMBI.Results = {}
COMBI.Results["Diamond"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 10

GMS.RegisterCombi("Crystal5",COMBI,"AdvancedFurnace")

/*---------------------------------------------------------
 10 Diamonds
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "10x Diamond"
COMBI.Description = [[Smelts 1000 Crystal into 10 Diamond
You need:
Crystal 1000
Weapon Crafting 120
CAREFULL WHEN SMELTING TO MUCH
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 1000

COMBI.Results = {}
COMBI.Results["Diamond"] = 10

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 120

GMS.RegisterCombi("Crystal10",COMBI,"AdvancedFurnace")

/*---------------------------------------------------------
 1 Gold
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 1x Gold"
COMBI.Description = [[Smelts 300 Gold Nuggets and 2 Diamonds into 1 Gold.
You need:
2 Diamond's
300 Gold Nugget's
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 300
COMBI.Req["Diamond"] = 2

COMBI.Results = {}
COMBI.Results["Gold"] = 1


GMS.RegisterCombi("Gold1",COMBI,"AdvancedFurnace")

/*---------------------------------------------------------
  Sulphur
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sulphur x5"
COMBI.Description = [[Used in the production of gunpowder, refine from rocks.
You need:
20 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10

COMBI.Results = {}
COMBI.Results["Sulphur"] = 5

GMS.RegisterCombi("Sulphur5",COMBI,"PlatinumFurnace")

/*---------------------------------------------------------
  Sulphur 10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sulphur x10"
COMBI.Description = [[Used in the production of gunpowder, refine from rocks.
You need:
20 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 20

COMBI.Results = {}
COMBI.Results["Sulphur"] = 10

GMS.RegisterCombi("Sulphur10",COMBI,"PlatinumFurnace")
/*---------------------------------------------------------
  200 Stone
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "500 Stone"
COMBI.Description = [[Trade 100 Gold Nuggets for 500 stone
You need:
100 Gold Nuggets
Weapon Crafting 30
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 100

COMBI.Results = {}
COMBI.Results["Stone"] = 500

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 30

GMS.RegisterCombi("500 Stone",COMBI,"TradingCart")

/*---------------------------------------------------------
  100 Crystal
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 200 Nuggets"
COMBI.Description = [[Trade 6 Diamonds for 200 Gold Nuggets
You need:
6 Diamonds
Weapon Crafting 25
]]

COMBI.Req = {}
COMBI.Req["Diamond"] = 6

COMBI.Results = {}
COMBI.Results["Gold_Nugget"] = 200

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 25

GMS.RegisterCombi("Nuggets200",COMBI,"TradingCart")

/*---------------------------------------------------------
  500 Water Bottles
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 500 Water Bottles"
COMBI.Description = [[Trade 200 Gold Nuggets for 500 Water Bottles
You need:
200 Gold Nuggets
Weapon Crafting 35
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 200

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 35

COMBI.Results = {}
COMBI.Results["Water_Bottles"] = 500

GMS.RegisterCombi("Water500",COMBI,"TradingCart")

/*---------------------------------------------------------
  200 Acidic Water
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 200 Acidic Water"
COMBI.Description = [[Trade 50 Gold Nuggets for 200 Acidic Water
You need:
50 Gold Nuggets
Weapon Crafting 40
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 50

COMBI.Results = {}
COMBI.Results["Acidic_Water"] = 200

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 40

GMS.RegisterCombi("200Acid_Water",COMBI,"TradingCart")

/*---------------------------------------------------------
  150 Concrete
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 150 Concrete"
COMBI.Description = [[Trade 50 Gold Nuggets for 150 Concrete
You need:
50 Gold Nuggets
Weapon Crafting 45
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 50

COMBI.Results = {}
COMBI.Results["Concrete"] = 150

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 45

GMS.RegisterCombi("150Concrete",COMBI,"TradingCart")

/*---------------------------------------------------------
  500 Wood
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = " 1000 Wood"
COMBI.Description = [[Trade 300 Gold Nuggets for 1000 wood
You need:
300 Gold Nuggets
Weapon Crafting 50
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 300

COMBI.Results = {}
COMBI.Results["Wood"] = 1000

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 50

GMS.RegisterCombi("1000Wood",COMBI,"TradingCart")

/*---------------------------------------------------------
  500 Unobtainium
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "500 Unobtainium"
COMBI.Description = [[Trade 100 Gold Nuggets for 500 Unobtainium
You need:
100 Gold Nuggets
Weapon Crafting 55
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 100

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 500

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 55

GMS.RegisterCombi("500Unobtainium",COMBI,"TradingCart")

/*---------------------------------------------------------
  300 Unobtainium
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "1 Diamond and 300 Nuggets"
COMBI.Description = [[Trade 1 gold for 1 diamond and 300 nuggets
You need:
1 gold
Weapon Crafting 10
]]

COMBI.Req = {}
COMBI.Req["Gold"] = 1

COMBI.Results = {}
COMBI.Results["Gold_Nugget"] = 300
COMBI.Results["Diamond"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 10

GMS.RegisterCombi("GoldBack",COMBI,"TradingCart")

/*---------------------------------------------------------
  200 Compound11
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "500 Compound11"
COMBI.Description = [[Trade 200 Gold Nuggets for 500 Compound11
You need:
200 Gold Nuggets
Weapon Crafting 60
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 200

COMBI.Results = {}
COMBI.Results["Compound11"] = 500

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 60

GMS.RegisterCombi("Compound11500",COMBI,"TradingCart")

/*---------------------------------------------------------
  600 Platinum
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "600 Platinum"
COMBI.Description = [[Trade 100 Gold Nuggets for 600 Platinum
You need:
100 Gold Nuggets
Weapon Crafting 50
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 100

COMBI.Results = {}
COMBI.Results["Platinum"] = 600

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 50

GMS.RegisterCombi("Platinum600",COMBI,"TradingCart")

/*---------------------------------------------------------
  600 Platinum
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "2000 Platinum"
COMBI.Description = [[Trade 500 Gold Nuggets for 2000 Platinum
You need:
500 Gold Nuggets
Weapon Crafting 110
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 500

COMBI.Results = {}
COMBI.Results["Platinum"] = 2000

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 110

GMS.RegisterCombi("Platinum2000",COMBI,"TradingCart")

/*---------------------------------------------------------
  100 Crystal
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "150 Crystal"
COMBI.Description = [[Trade 200 Gold Nuggets for 150 Crystal
You need:
200 Gold Nuggets
Weapon Crafting 65
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 200

COMBI.Results = {}
COMBI.Results["Crystal"] = 150

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 65

GMS.RegisterCombi("Crystal100",COMBI,"TradingCart")

/*---------------------------------------------------------
  10 Shark
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "10 Shark"
COMBI.Description = [[Trade 400 Gold Nuggets for 10 Shark
You need:
400 Gold Nuggets
Weapon Crafting 65
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 400

COMBI.Results = {}
COMBI.Results["Shark"] = 10

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 65

GMS.RegisterCombi("Shark10",COMBI,"TradingCart")

/*---------------------------------------------------------
  30 Bass
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "30 Bass"
COMBI.Description = [[Trade 300 Gold Nuggets for 30 Bass
You need:
300 Gold Nuggets
Weapon Crafting 50
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 300

COMBI.Results = {}
COMBI.Results["Bass"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 50

GMS.RegisterCombi("Bass30",COMBI,"TradingCart")

/*---------------------------------------------------------
  100 Herbs
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "100 Herbs"
COMBI.Description = [[Trade 200 Gold Nuggets for 300 Herbs
You need:
200 Gold Nuggets
Weapon Crafting 70
]]

COMBI.Req = {}
COMBI.Req["Gold_Nugget"] = 200

COMBI.Results = {}
COMBI.Results["Herbs"] = 300

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 70

GMS.RegisterCombi("Herbs300",COMBI,"TradingCart")

/*---------------------------------------------------------
  200 Diamonds
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "200 Diamonds"
COMBI.Description = [[Trade 1 Fun Games Token for 200 Diamonds
You need:
1 Fun Games Token
]]

COMBI.Req = {}
COMBI.Req["Fun_Games_Token"] = 1

COMBI.Results = {}
COMBI.Results["Diamond"] = 200

GMS.RegisterCombi("Diamond200",COMBI,"TradingCart")

/*---------------------------------------------------------

  Factory

---------------------------------------------------------*/
/*---------------------------------------------------------
  Glass (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Glass10"
COMBI.Description = [[Heats 25 sand together to form 10 glass.
You need:
25 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 25

COMBI.Results = {}
COMBI.Results["Glass"] = 10

GMS.RegisterCombi("Glass10",COMBI,"Factory")
/*---------------------------------------------------------
  Glass (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Glass25"
COMBI.Description = [[Heats 50 sand together to form 25 glass.
You need:
50 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 50

COMBI.Results = {}
COMBI.Results["Glass"] = 25

GMS.RegisterCombi("Glass25",COMBI,"Factory")

/*---------------------------------------------------------
  Glass (50)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Glass50"
COMBI.Description = [[Heats 75 sand together to form 50 glass.
You need:
75 Sand
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 75

COMBI.Results = {}
COMBI.Results["Glass"] = 50

GMS.RegisterCombi("Glass50",COMBI,"Factory")

/*---------------------------------------------------------
  Unobtainium from Stone (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium25"
COMBI.Description = [[Smelting together 50 stone forms 25 Unobtainium.
You need:
50 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 50

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 25

GMS.RegisterCombi("Unobtainium25",COMBI,"Factory")

/*---------------------------------------------------------
  Unobtainium from Stone (50)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium50"
COMBI.Description = [[Smelting together 75 stone forms 50 Unobtainium.
You need:
100 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 100

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 50

GMS.RegisterCombi("Unobtainium50",COMBI,"Factory")

/*---------------------------------------------------------
  Allsmelt Unobtainium 
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Unobtainium"
COMBI.Description = [[Unobtainium can be used to create more advanced buildings and tools.
You need:
Unobtainium Ore (1000 MAX)
]]

COMBI.Req = {}
COMBI.Req["Unobtainium_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Unobtainium"] = 1

COMBI.AllSmelt = true
COMBI.Max = 1000

GMS.RegisterCombi("AllSmeltUnobtainium",COMBI,"Factory")

/*---------------------------------------------------------
  Allsmelt Platinum
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Platinum"
COMBI.Description = [[Platinum can be used to create more advanced buildings and tools.
You need:
Platinum Ore (1500 MAX)
]]

COMBI.Req = {}
COMBI.Req["Platinum_Ore"] = 1

COMBI.Results = {}
COMBI.Results["Platinum"] = 1

COMBI.AllSmelt = true
COMBI.Max = 1500

GMS.RegisterCombi("AllSmeltPlatinum",COMBI,"Factory")
/*---------------------------------------------------------
  Stone to Sand (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FSand25"
COMBI.Description = [[Crushes 20 stone to 25 sand.
You need:
20 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 20

COMBI.Results = {}
COMBI.Results["Sand"] = 25

GMS.RegisterCombi("FSand25",COMBI,"Factory")

/*---------------------------------------------------------
  Stone to Sand (50)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FSand50"
COMBI.Description = [[Crushes 30 stone to 50 sand.
You need:
30 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 30

COMBI.Results = {}
COMBI.Results["Sand"] = 50

GMS.RegisterCombi("FSand50",COMBI,"Factory")

/*---------------------------------------------------------
  Resin (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FResin10"
COMBI.Description = [[Extracts the resin from the wood.
You need:
25 wood
2 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 25
COMBI.Req["Water_Bottles"] = 2

COMBI.Results = {}
COMBI.Results["Resin"] = 10

GMS.RegisterCombi("FResin10",COMBI,"Factory")

/*---------------------------------------------------------
  Resin (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FResin25"
COMBI.Description = [[Extracts the resin from the wood.
You need:
50 wood
4 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 50
COMBI.Req["Water_Bottles"] = 4

COMBI.Results = {}
COMBI.Results["Resin"] = 25

GMS.RegisterCombi("FResin25",COMBI,"Factory")

/*---------------------------------------------------------
  Plastic (10)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FPlastic10"
COMBI.Description = [[Solidifies the Resin, creating a natural plastic.
You need:
10 Resin
]]

COMBI.Req = {}
COMBI.Req["Resin"] = 10

COMBI.Results = {}
COMBI.Results["Plastic"] = 10

GMS.RegisterCombi("FPlastic10",COMBI,"Factory")

/*---------------------------------------------------------
  Plastic (25)
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "FPlastic25"
COMBI.Description = [[Solidifies the Resin, creating a natural plastic.
You need:
20 Resin
]]

COMBI.Req = {}
COMBI.Req["Resin"] = 20

COMBI.Results = {}
COMBI.Results["Plastic"] = 25

GMS.RegisterCombi("FPlastic25",COMBI,"Factory")

/*---------------------------------------------------------

  Grinding Stone

---------------------------------------------------------*/

/*---------------------------------------------------------
 Rocks
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Rocks"
COMBI.Description = [[Rocks can be used for various things.
You need:
Stone (200 MAX)
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1

COMBI.Results = {}
COMBI.Results["Rocks X10"] = 1

COMBI.AllSmelt = true
COMBI.Max = 200

GMS.RegisterCombi("AllRocks",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Stone to Sand x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sand1"
COMBI.Description = [[Converts 1 stone to 1 sand.
You need:
1 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1

COMBI.Results = {}
COMBI.Results["Sand"] = 1

GMS.RegisterCombi("Sand1",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Stone to Sand x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sand5"
COMBI.Description = [[Converts 5 stone to 5 sand.
You need:
5 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 5

COMBI.Results = {}
COMBI.Results["Sand"] = 5

GMS.RegisterCombi("Sand5",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Stone to Sand x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sand10"
COMBI.Description = [[Converts 10 stone to 10 sand.
You need:
10 Stone
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10

COMBI.Results = {}
COMBI.Results["Sand"] = 10

GMS.RegisterCombi("Sand10",COMBI,"GrindingStone")


/*---------------------------------------------------------
  Grain to Flour x1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour1"
COMBI.Description = [[Converts 2 Grain Seeds to 1 Flour.
You need:
2 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 2

COMBI.Results = {}
COMBI.Results["Flour"] = 1

GMS.RegisterCombi("Flour1",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Grain to Flour x5
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour5"
COMBI.Description = [[Converts 5 Grain Seeds to 3 Flour.
You need:
5 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 5

COMBI.Results = {}
COMBI.Results["Flour"] = 3

GMS.RegisterCombi("Flour5",COMBI,"GrindingStone")

/*---------------------------------------------------------
  Grain to Flour x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour10"
COMBI.Description = [[Converts 10 Grain Seeds to 7 Flour.
You need:
10 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 10

COMBI.Results = {}
COMBI.Results["Flour"] = 7

GMS.RegisterCombi("Flour10",COMBI,"GrindingStone")

/*---------------------------------------------------------
  All Grain to Flour
  ---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "All Flour"
COMBI.Description = [[Converts Grain Seeds to Flour.
You need:
Grain Seeds (25 max)
]]

COMBI.Req = {}
COMBI.Req["Grain_Seeds"] = 10

COMBI.Results = {}
COMBI.Results["Flour"] = 7

COMBI.AllSmelt = true
COMBI.Max = 100

GMS.RegisterCombi("AllFlour",COMBI,"GrindingStone")

/*---------------------------------------------------------

  Generic

---------------------------------------------------------*/
/*---------------------------------------------------------
  Flour
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Flour"
COMBI.Description = [[Flour can be used for making dough.
You need:
1 Stone
2 Grain Seeds
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1
COMBI.Req["Grain_Seeds"] = 2

COMBI.Results = {}
COMBI.Results["Flour"] = 1
COMBI.Results["Stone"] = 1

GMS.RegisterCombi("Flour",COMBI,"Generic")

/*---------------------------------------------------------
Arrows
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "10 Arrows"
COMBI.Description = [[Arrows that can be used to hunt.
You need:
50 Feathers
25 Unobtainium
25 Wood
]]

COMBI.Req = {}
COMBI.Req["Feathers"] = 50
COMBI.Req["Unobtainium"] = 25
COMBI.Req["Wood"] = 25


COMBI.Results = {}
COMBI.Results["Arrows"] = 10
COMBI.Results["Stone"] = 1

GMS.RegisterCombi("Arrowsx10",COMBI,"Generic")

/*---------------------------------------------------------
  Spice
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Spices"
COMBI.Description = [[Spice can be used for various meals.
You need:
1 Stone
2 Herbs
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1
COMBI.Req["Herbs"] = 2

COMBI.Results = {}
COMBI.Results["Spices"] = 1
COMBI.Results["Stone"] = 1

GMS.RegisterCombi("Spices",COMBI,"Generic")
/*---------------------------------------------------------
  Dough
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Dough"
COMBI.Description = [[Dough is used for baking.
You need:
1 Bottle of water
2 Flour
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 1
COMBI.Req["Flour"] = 2

COMBI.Results = {}
COMBI.Results["Dough"] = 1

GMS.RegisterCombi("Dough",COMBI,"Generic")

/*---------------------------------------------------------
  Dough x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Dough x10"
COMBI.Description = [[Dough is used for baking.
You need:
7 Bottles of water
15 Flour
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 7
COMBI.Req["Flour"] = 15

COMBI.Results = {}
COMBI.Results["Dough"] = 10

GMS.RegisterCombi("Doughx10",COMBI,"Generic")

/*---------------------------------------------------------
Squish Roots
  ---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Squish Roots"
COMBI.Description = [[Squish Roots to get water out of them.
You need:
5 Roots per 1 waterbottle (500 Roots max)
]]

COMBI.Req = {}
COMBI.Req["Roots"] = 5

COMBI.Results = {}
COMBI.Results["Water_Bottles"] = 1

COMBI.AllSmelt = true
COMBI.Max = 500

GMS.RegisterCombi("Water_Roots",COMBI,"GrindingStone")

/*---------------------------------------------------------
Make Salt
  ---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Salt"
COMBI.Description = [[Crush strone to get salt.
You need:
1 Stone makes 10 salt  (100 stone max)
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 1

COMBI.Results = {}
COMBI.Results["Salt"] = 10

COMBI.AllSmelt = true
COMBI.Max = 100

GMS.RegisterCombi("Salt",COMBI,"GrindingStone")
/*---------------------------------------------------------
  Rope
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Rope"
COMBI.Description = [[Rope to use rope tool.
You need:
5 Herbs
1 Bottle of water
2 Wood
]]

COMBI.Req = {}
COMBI.Req["Herbs"] = 5
COMBI.Req["Wood"] = 2
COMBI.Req["Water_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Rope"] = 1

GMS.RegisterCombi("Rope",COMBI,"Generic")
/*---------------------------------------------------------
  Welder
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Welder"
COMBI.Description = [[Welder to use weld tool.
You need:
10 Wood
10 stone
1 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 10
COMBI.Req["Stone"] = 10
COMBI.Req["Water_Bottles"] = 1

COMBI.Results = {}
COMBI.Results["Welder"] = 1

GMS.RegisterCombi("Welder",COMBI,"Generic")
/*---------------------------------------------------------
  ConcreteX 1
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Concrete"
COMBI.Description = [[Concrete can be used for spawning concrete props.
You need:
5 Sand
2 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 5
COMBI.Req["Water_Bottles"] = 2

COMBI.Results = {}
COMBI.Results["Concrete"] = 1

GMS.RegisterCombi("Concrete",COMBI,"Generic")

/*---------------------------------------------------------
  ConcreteX 10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Concrete x10"
COMBI.Description = [[Concrete can be used for spawning concrete props.
You need:
50 Sand
20 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 50
COMBI.Req["Water_Bottles"] = 20

COMBI.Results = {}
COMBI.Results["Concrete"] = 10

GMS.RegisterCombi("ConcreteX10",COMBI,"Generic")

/*---------------------------------------------------------
  ConcreteX 25
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Concrete x25"
COMBI.Description = [[Concrete can be used for spawning concrete props.
You need:
125 Sand
50 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 125
COMBI.Req["Water_Bottles"] = 50

COMBI.Results = {}
COMBI.Results["Concrete"] = 25

GMS.RegisterCombi("ConcreteX25",COMBI,"Generic")

/*---------------------------------------------------------
  ConcreteX 50
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Concrete x50"
COMBI.Description = [[Concrete can be used for spawning concrete props.
You need:
250 Sand
100 Bottle of water
]]

COMBI.Req = {}
COMBI.Req["Sand"] = 250
COMBI.Req["Water_Bottles"] = 100

COMBI.Results = {}
COMBI.Results["Concrete"] = 50

GMS.RegisterCombi("ConcreteX50",COMBI,"Generic")

/*---------------------------------------------------------
  Acidic_Water
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Acidic_Water"
COMBI.Description = [[With Chemistry you are able to make Acidic  Water, used in gunpowder production.
You need:
2 Bottles of water
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 2

COMBI.Results = {}
COMBI.Results["Acidic_Water"] = 1

GMS.RegisterCombi("Acidic_Water",COMBI,"Generic")
/*---------------------------------------------------------
  Acidic_Water
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Acidic_Water x10"
COMBI.Description = [[With greater knowledge in chemistry you can make even more.
You need:
20 Bottles of water
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 20

COMBI.Results = {}
COMBI.Results["Acidic_Water"] = 10

GMS.RegisterCombi("Acidic_Water10",COMBI,"Generic")
/*---------------------------------------------------------
 Acidic_Water
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Acidic_Water x50"
COMBI.Description = [[Who doesn't need 50 bottles of Acidic_Water.
You need:
100 Bottles of water
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 100

COMBI.Results = {}
COMBI.Results["Acidic_Water"] = 50

GMS.RegisterCombi("Acidic_Water50",COMBI,"Generic")
/*---------------------------------------------------------

  Cooking

---------------------------------------------------------*/
/*---------------------------------------------------------
  Casserole
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Casserole"
COMBI.Description = [[Put a little spiced trout over the fire to make this delicious casserole.
You need:
1 Trout
3 Herbs

Food initial quality: 40%
]]

COMBI.Req = {}
COMBI.Req["Trout"] = 1
COMBI.Req["Herbs"] = 3
COMBI.FoodValue = 400

GMS.RegisterCombi("Casserole",COMBI,"Cooking")
/*---------------------------------------------------------
  Fried Flesh
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fried Flesh"
COMBI.Description = [[Simple fried Flesh.
You need:
1 Flesh

Food initial quality: 25%]]

COMBI.Req = {}
COMBI.Req["Flesh"] = 1

COMBI.FoodValue = 250

GMS.RegisterCombi("FriedFlesh",COMBI,"Cooking")
/*---------------------------------------------------------
  Sushi
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sushi"
COMBI.Description = [[For when you like your fish raw.
You need:
2 Bass

Food initial quality: 30%]]

COMBI.Req = {}
COMBI.Req["Bass"] = 2

COMBI.FoodValue = 300

GMS.RegisterCombi("Sushi",COMBI,"Cooking")
/*---------------------------------------------------------
  Fish soup
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fish Soup"
COMBI.Description = [[Fish soup, pretty good!
You need:
1 Bass
1 Trout
2 Spices
2 Water Bottles
Cooking Level 2

Food initial quality: 40%]]

COMBI.Req = {}
COMBI.Req["Bass"] = 1
COMBI.Req["Trout"] = 1
COMBI.Req["Spices"] = 2
COMBI.Req["Water_Bottles"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 2

COMBI.FoodValue = 400

GMS.RegisterCombi("FishSoup",COMBI,"Cooking")
/*---------------------------------------------------------
  Fleshballs
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fleshballs"
COMBI.Description = [[Processed Flesh.
You need:
1 Flesh
1 Spices
1 Bottle of water
Cooking Level 2

Food initial quality: 40%]]

COMBI.Req = {}
COMBI.Req["Flesh"] = 1
COMBI.Req["Spices"] = 1
COMBI.Req["Water_Bottles"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 2

COMBI.FoodValue = 400

GMS.RegisterCombi("Fleshballs",COMBI,"Cooking")
/*---------------------------------------------------------
  Fried fish
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Fried Fish"
COMBI.Description = [[Simple fried fish.
You need:
1 Bass

Food initial quality: 20%]]

COMBI.Req = {}
COMBI.Req["Bass"] = 1
COMBI.FoodValue = 200

GMS.RegisterCombi("FriedFish",COMBI,"Cooking")
/*---------------------------------------------------------
  Berry Pie
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Berry Pie"
COMBI.Description = [[Yummy, berry pie reminds me of home!
You need:
2 Dough
2 Water bottles
5 Berries
Cooking Level 5

Food initial quality: 70%]]

COMBI.Req = {}
COMBI.Req["Dough"] = 2
COMBI.Req["Water_Bottles"] = 2
COMBI.Req["Berries"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 5

COMBI.FoodValue = 700

GMS.RegisterCombi("BerryPie",COMBI,"Cooking")
/*---------------------------------------------------------
  Rock cake
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Rock Cake"
COMBI.Description = [[Crunchy!
You need:
2 Unobtainium
1 Herbs
 
Food initial quality: 5%
]]
 
COMBI.Req = {}
COMBI.Req["Unobtainium"] = 2
COMBI.Req["Herbs"] = 1
COMBI.FoodValue = 50
 
GMS.RegisterCombi("Rock_Cake", COMBI, "Cooking")

/*---------------------------------------------------------
Fried Berries
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Fried Berries"
COMBI.Description = [[DON'T EAT THEM RAW!!! lol.
You need:
5 Berries
 
Food initial quality: 5%
]]
 
COMBI.Req = {}
COMBI.Req["Berries"] = 5
COMBI.FoodValue = 75
 
GMS.RegisterCombi("Fried_Berries", COMBI, "Cooking")
/*---------------------------------------------------------
  Salad
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Salad"
COMBI.Description = [[Everything for survival, I guess.
You need:
2 Herbs

Food initial quality: 10%
]]
 
COMBI.Req = {}
COMBI.Req["Herbs"] = 2
COMBI.FoodValue = 100
 
GMS.RegisterCombi("Salad", COMBI, "Cooking")
/*---------------------------------------------------------
  Meal
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Meal"
COMBI.Description = [[The ultimate meal. Delicious!
You need:
5 Herbs
1 Salmon
1 Flesh
3 Spices
Cooking Level 20

Food initial quality: 100%
]]
 
COMBI.Req = {}
COMBI.Req["Herbs"] = 5
COMBI.Req["Salmon"] = 1
COMBI.Req["Flesh"] = 2
COMBI.Req["Spices"] = 3

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 20

COMBI.FoodValue = 1000
 
GMS.RegisterCombi("Meal", COMBI, "Cooking")
/*---------------------------------------------------------
  Shark soup
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Shark soup"
COMBI.Description = [[Man this is good.
You need:
2 Shark
3 Herbs
2 Spices
Cooking Level 15

Food initial quality: 85%]]

COMBI.Req = {}
COMBI.Req["Shark"] = 2
COMBI.Req["Herbs"] = 3
COMBI.Req["Spices"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 15

COMBI.FoodValue = 850

GMS.RegisterCombi("Sharksoup",COMBI,"Cooking")
/*---------------------------------------------------------
  Bread
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Bread"
COMBI.Description = [[Good old bread.
You need:
2 Dough
1 Bottle of water
Cooking Level 5

Food initial quality: 80%
]]
 
COMBI.Req = {}
COMBI.Req["Dough"] = 2
COMBI.Req["Water_Bottles"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 5

COMBI.FoodValue = 800

GMS.RegisterCombi("Bread", COMBI, "Cooking")
/*---------------------------------------------------------
  Hamburger
---------------------------------------------------------*/
local COMBI = {}
 
COMBI.Name = "Hamburger"
COMBI.Description = [[A hamburger! Yummy!
You need:
2 Dough
1 Bottle of water
2 Flesh
Cooking Level 3

Food initial quality: 85%
]]
 
COMBI.Req = {}
COMBI.Req["Dough"] = 2
COMBI.Req["Water_Bottles"] = 1
COMBI.Req["Flesh"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Cooking"] = 3

COMBI.FoodValue = 850
 
GMS.RegisterCombi("Burger", COMBI, "Cooking")
/*---------------------------------------------------------

  Weapons crafting

---------------------------------------------------------*/
/*---------------------------------------------------------
  Stone Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Hatchet"
COMBI.Description = [[This small stone axe is ideal for chopping down trees.
You need:
10 Stone
20 Wood
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10
COMBI.Req["Wood"] = 20

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_stonehatchet"

GMS.RegisterCombi("Stone_Hatchet",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Platinum Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum Hatchet"
COMBI.Description = [[This Platinum axe is ideal for chopping down trees.
You need:
15 Platinum
30 Wood
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 15
COMBI.Req["Wood"] = 30

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_platinumhatchet"

GMS.RegisterCombi("Platinum_Hatchet",COMBI,"PlatinumWeapons")
/*---------------------------------------------------------
  Unobtainium Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium Hatchet"
COMBI.Description = [[This Unobtainium axe is ideal for chopping down trees.
You need:
25 Unobtainium
50 Wood
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 25
COMBI.Req["Wood"] = 50

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_unobtainiumhatchet"

GMS.RegisterCombi("Unobtainium_Hatchet",COMBI,"UnobtainiumWeapons")

/*---------------------------------------------------------
  Adamantium Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adamantium Hatchet"
COMBI.Description = [[This Adamantium axe is perfect for chooping trees.
You need:
30 Adamantium
80 Wood
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 30
COMBI.Req["Wood"] = 80

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_adamantiumhatchet"

GMS.RegisterCombi("Adamantium_Hatchet",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
  Crystal Hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Crystal Hatchet"
COMBI.Description = [[This Crystal axe is perfect for chooping trees.
You need:
150 Crystal
200 Wood
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 150
COMBI.Req["Wood"] = 200

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_crystalhatchet"

GMS.RegisterCombi("Crystal_Hatchet",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
  
 AdamantiumBow
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adamantium Bow"
COMBI.Description = [[A Weapon that can kill animals.
You need:
60 Adamantium
5 Rope
10 Wood
Weapon Crafting 32
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 60
COMBI.Req["Rope"] = 5
COMBI.Req["Wood"] = 10

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 32

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_adamantiumbow"

GMS.RegisterCombi("Adamantium_Bow",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
  
 AdamantiumSword
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adamantium Sword"
COMBI.Description = [[A strong weapon. Perfect for cutting people.
You need:
120 Adamantium
60 Wood
Weapon Crafting 28
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 120
COMBI.Req["Wood"] = 60

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 28

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_adamantiumsword"

GMS.RegisterCombi("Adamantium_Sword",COMBI,"AdvancedWeapons")


/*---------------------------------------------------------
  Wooden Spoon
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Wooden Spoon"
COMBI.Description = [[Allows you to salvage more seeds from consumed fruit.
You need:
5 Wood
Weapon Crafting Level 3
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 3

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_woodenspoon"

GMS.RegisterCombi("Wooden_Spoon",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Stone Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stone Pickaxe"
COMBI.Description = [[This stone pickaxe is used for effectively mining 
stone and Platinum ore.
You need:
10 Stone
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Stone"] = 10
COMBI.Req["Wood"] = 5
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_stonepickaxe"

GMS.RegisterCombi("Stone_Pickaxe",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Platinum Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Platinum Pickaxe"
COMBI.Description = [[This Platinum pickaxe is used for effectively mining 
stone, Platinum ore and Unobtainium ore.
You need:
15 Platinum
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 15
COMBI.Req["Wood"] = 5

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_platinumpickaxe"

GMS.RegisterCombi("Platinum_Pickaxe",COMBI,"PlatinumWeapons")
/*---------------------------------------------------------
  Unobtainium Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Unobtainium Pickaxe"
COMBI.Description = [[This Unobtainium pickaxe is used for effectively mining 
You need:
25 Unobtainium
5 Wood
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 25
COMBI.Req["Wood"] = 5
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_unobtainiumpickaxe"

GMS.RegisterCombi("Unobtainium_Pickaxe",COMBI,"UnobtainiumWeapons")

/*---------------------------------------------------------
	Adamantium Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adamantium Pickaxe"
COMBI.Description = [[This Adamantium pickaxe is used for advanced mining.
You need:
50 Adamantium
10 Wood
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 50
COMBI.Req["Wood"] = 10
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_adamantiumpickaxe"

GMS.RegisterCombi("Adamantium_Pickaxe",COMBI,"AdvancedWeapons")


/*---------------------------------------------------------
	Crystal Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Crystal Pickaxe"
COMBI.Description = [[This Crystal pickaxe is used for advanced mining.
You need:
250 Crystal
30 Wood
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 250
COMBI.Req["Wood"] = 30
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_crystalpickaxe"

GMS.RegisterCombi("Crystal_Pickaxe",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
	Crystal Fishingrod
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Crystal Fishingrod"
COMBI.Description = [[This advanced fishing rod catches only the biggest.
You need:
100 Crystal
100 Wood
50 Rope
]]

COMBI.Req = {}
COMBI.Req["Crystal"] = 100
COMBI.Req["Rope"] = 50
COMBI.Req["Wood"] = 100
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_crystalfishingrod"

GMS.RegisterCombi("Crystal_FishingRod",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
	Diamond Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Diamond Pickaxe"
COMBI.Description = [[This Diamond pickaxe is UBER!
You need:
10 Diamond

]]

COMBI.Req = {}
COMBI.Req["Diamond"] = 10
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_diamondpickaxe"

GMS.RegisterCombi("Diamond_Pickaxe",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
	Diamond hatchet
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Diamond Hatchet"
COMBI.Description = [[This Diamond hatchet is UBER!
You need:
10 Diamond

]]

COMBI.Req = {}
COMBI.Req["Diamond"] = 10
COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_diamondhatchet"

GMS.RegisterCombi("Diamond_Hatchet",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
	Gold Pickaxe
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gold Pickaxe"
COMBI.Description = [[This Gold pickaxe is the best pick known to man.
You need:
30 Gold
100 Weapon Crafting
270 Survival
800 Mining

]]

COMBI.Req = {}
COMBI.Req["Gold"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 100
COMBI.SkillReq["Survival"] = 270
COMBI.SkillReq["Mining"] = 800

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_goldpickaxe"

GMS.RegisterCombi("Gold_Pickaxe",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
  Fishing rod
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Wooden Fishing Rod"
COMBI.Description = [[This rod of wood can be used to fish from a lake.
You need:
1 Rope
20 Wood
Weapon Crafting Level 4
]]

COMBI.Req = {}
COMBI.Req["Rope"] = 1
COMBI.Req["Wood"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 4

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_woodenfishingrod"

GMS.RegisterCombi("Wooden_FishingRod",COMBI,"StoneWeapons")
/*---------------------------------------------------------
  Frying pan
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Frying Pan"
COMBI.Description = [[This kitchen tool is used for more effective cooking.
You need:
20 Platinum
5 Wood
Weapon Crafting Level 5
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 20
COMBI.Req["Wood"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 5

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_fryingpan"

GMS.RegisterCombi("Fryingpan",COMBI,"PlatinumWeapons")

/*---------------------------------------------------------
  Frying pan
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Adamantium Frying Pan"
COMBI.Description = [[This advanced kitchen tool is used for more effective cooking.
You need:
50 Adamantium
20 Unobtainium
Weapon Crafting Level 20
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 50
COMBI.Req["Unobtainium"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 20

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_adamantiumfryingpan"

GMS.RegisterCombi("Fryingpan",COMBI,"AdvancedWeapons")

/*---------------------------------------------------------
  Sickle
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Sickle"
COMBI.Description = [[This tool effectivizes harvesting.
You need:
5 Unobtainium
15 Wood
Weapon Crafting Level 7
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 5
COMBI.Req["Wood"] = 15

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 7

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_sickle"

GMS.RegisterCombi("Sickle",COMBI,"UnobtainiumWeapons")
/*---------------------------------------------------------
  Strainer
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Strainer"
COMBI.Description = [[This tool can filter the earth for resources.
You need:
5 Unobtainium
5 Wood
Weapon Crafting Level 10
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 5
COMBI.Req["Wood"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 10

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_strainer"

GMS.RegisterCombi("Strainer",COMBI,"UnobtainiumWeapons")
/*---------------------------------------------------------
  Shovel
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Shovel"
COMBI.Description = [[This tool can dig up rocks, and decreases forage times.
You need:
30 Adamantium
30 Wood
Weapon Crafting Level 10
]]

COMBI.Req = {}
COMBI.Req["Adamantium"] = 30
COMBI.Req["Wood"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 10

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_shovel"

GMS.RegisterCombi("Shovel",COMBI,"AdvancedWeapons")
/*---------------------------------------------------------
  Crowbar
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Crowbar"
COMBI.Description = [[This weapon is initially a tool, but pretty useless for 
it's original purpose on a stranded Island.
It works well as a weapon, though.
You need:
20 Platinum
20 Unobtainium
Weapon Crafting Level 6
]]

COMBI.Req = {}
COMBI.Req["Platinum"] = 20
COMBI.Req["Unobtainium"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 6

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_crowbar"

GMS.RegisterCombi("Crowbar",COMBI,"PlatinumWeapons")
/*---------------------------------------------------------
  Advanced Fishing rod
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Advanced Fishing rod"
COMBI.Description = [[With this Fishing rod you can catch rare fish even faster. 
You might even catch something big.
You need:
25 Unobtainium
30 Wood
2 Rope
Weapon Crafting Level 15
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 25
COMBI.Req["Wood"] = 30
COMBI.Req["Rope"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 15

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gms_advancedfishingrod"

GMS.RegisterCombi("AdvancedFishingRod",COMBI,"UnobtainiumWeapons")
/*---------------------------------------------------------
  Toolgun
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Toolgun"
COMBI.Description = [[Vital to long term survival, it allows you to easily 
build complex structures.
You need:
30 Unobtainium
20 Wood
Weapon Crafting Level 14
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 30
COMBI.Req["Wood"] = 20

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 14

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "gmod_tool"

GMS.RegisterCombi("Toolgun",COMBI,"UnobtainiumWeapons")
/*---------------------------------------------------------

  Gun crafting

---------------------------------------------------------*/
/*---------------------------------------------------------
  Smg
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Smg"
COMBI.Description = [[Will blow the head off the target
You need:
3 Gunslide
2 Gungrip
3 Gunbarrel
3 Gunmagazine
Weapon Crafting Level 20
]]

COMBI.Req = {}
COMBI.Req["Gunslide"] = 3
COMBI.Req["Gungrip"] = 2
COMBI.Req["Gunbarrel"] = 3
COMBI.Req["Gunmagazine"] = 3

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 20

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_smg1"

GMS.RegisterCombi("smg",COMBI,"Gunmaking")
/*---------------------------------------------------------
  AR2
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "AR2"
COMBI.Description = [[Getting closer to overkill now.
You need:
7 Gunslide
5 Gungrip
6 Gunbarrel
10 Gunmagazine
Gold 5
Weapon Crafting Level 50
]]

COMBI.Req = {}
COMBI.Req["Gunslide"] = 7
COMBI.Req["Gungrip"] = 5
COMBI.Req["Gunbarrel"] = 6
COMBI.Req["Gunmagazine"] = 10
COMBI.Req["Gold"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 50

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_ar2"

GMS.RegisterCombi("ar2",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Pistol
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Pistol"
COMBI.Description = [[It's not great, but it does the job
You need:
1 Gunslide
1 Gungrip
1 Gunbarrel
1 Gunmagazine
Weapon Crafting Level 13
]]

COMBI.Req = {}
COMBI.Req["Gunslide"] = 1
COMBI.Req["Gungrip"] = 1
COMBI.Req["Gunbarrel"] = 1
COMBI.Req["Gunmagazine"] = 1

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 13

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_pistol"

GMS.RegisterCombi("Pistol",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Pistol ammo
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Pistol ammo"
COMBI.Description = [[If you wanna keep using the pistol, you'll need this
You need:
5 Unobtainium
5 Gunpowder
Weapon Crafting Level 13
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 5
COMBI.Req["Gunpowder"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 13

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "item_ammo_pistol"

GMS.RegisterCombi("Pistolammo",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Smg ammo
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Smg ammo"
COMBI.Description = [[If you wanna keep using the smg, you'll need this
You need:
10 Unobtainium
10 Gunpowder
Weapon Crafting Level 20
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 10
COMBI.Req["Gunpowder"] = 10

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 20

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "item_ammo_smg1"

GMS.RegisterCombi("smgammo",COMBI,"Gunmaking")
/*---------------------------------------------------------
  AR2 ammo
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "AR2 ammo"
COMBI.Description = [[If you want to keep, pwning you will need more ammo.
You need:
25 Unobtainium
50 Gunpowder
2 Gold
Weapon Crafting Level 70
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 25
COMBI.Req["Gunpowder"] = 50
COMBI.Req["Gold"] = 2

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 70

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "item_ammo_ar2"

GMS.RegisterCombi("ar2ammo",COMBI,"Gunmaking")
/*---------------------------------------------------------
  AR2 Secondary ammo
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "AR2 Alternate ammo"
COMBI.Description = [[If you want to keep, pwning you will need more ammo.
You need:
50 Unobtainium
100 Gunpowder
4 Gold
Weapon Crafting Level 85
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 50
COMBI.Req["Gunpowder"] = 100
COMBI.Req["Gold"] = 4

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 85

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "item_ammo_ar2_altfire"

GMS.RegisterCombi("ar2altammo",COMBI,"Gunmaking")
/*---------------------------------------------------------
  Stunstick
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stunstick"
COMBI.Description = [[This highly advanced, effective melee weapon is useful 
for hunting down animals and fellow stranded alike.
You need:
40 Unobtainium
Weapon Crafting Level 11
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 40

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 11

COMBI.Texture = "weapons/swep"
COMBI.SwepClass = "weapon_stunstick"

GMS.RegisterCombi("Stunstick",COMBI,"Gunmaking")
/*---------------------------------------------------------

  Motorised Utility

---------------------------------------------------------*/

/*---------------------------------------------------------
  Gunslide
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunslide"
COMBI.Description = [[A piece of a gun
You need:
25 Wood
Weapon Crafting Level 9
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 25

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 9

COMBI.Results = {}
COMBI.Results["Gunslide"] = 1

GMS.RegisterCombi("Gunslide",COMBI,"Utilities")
/*---------------------------------------------------------
  Gunbarrel
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunbarrel"
COMBI.Description = [[A piece of a gun
You need:
30 Unobtainium
Weapon Crafting Level 11
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 11

COMBI.Results = {}
COMBI.Results["Gunbarrel"] = 1

GMS.RegisterCombi("Gunbarrel",COMBI,"Utilities")
/*---------------------------------------------------------
  Gungrip
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gungrip"
COMBI.Description = [[A piece of a gun
You need:
30 Unobtainium
Weapon Crafting Level 7
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 30

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 7

COMBI.Results = {}
COMBI.Results["Gungrip"] = 1

GMS.RegisterCombi("Gungrip",COMBI,"Utilities")
/*---------------------------------------------------------
  Gunmagazine
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunmagazine"
COMBI.Description = [[A piece of a gun
You need:
15 Unobtainium
5 Gunpowder
Weapon Crafting Level 13
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 15
COMBI.Req["Gunpowder"] = 5

COMBI.SkillReq = {}
COMBI.SkillReq["Weapon_Crafting"] = 13

COMBI.Results = {}
COMBI.Results["Gunmagazine"] = 1

GMS.RegisterCombi("Gunmagazine",COMBI,"Utilities")
/*---------------------------------------------------------
  Saltpetre
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Saltpetre"
COMBI.Description = [[Used in making gunpowder
You need:
1 Acidic_Water Bottle
]]

COMBI.Req = {}
COMBI.Req["Acidic_Water"] = 1

COMBI.Results = {}
COMBI.Results["Saltpetre"] = 1

GMS.RegisterCombi("Saltpetre",COMBI,"Utilities")
/*---------------------------------------------------------
  Saltpetre x10
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Saltpetre x10"
COMBI.Description = [[Used in making gunpowder
You need:
10 Acidic_Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Acidic_Water"] = 10

COMBI.Results = {}
COMBI.Results["Saltpetre"] = 10

GMS.RegisterCombi("Saltpetre10",COMBI,"Utilities")
/*---------------------------------------------------------
  Gunpowder
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Gunpowder"
COMBI.Description = [[Explosive!
You need:
10 Charcoal
10 Saltpetre
5 Sulphur
]]

COMBI.Req = {}
COMBI.Req["Sulphur"] = 5
COMBI.Req["Charcoal"] = 10
COMBI.Req["Saltpetre"] = 10

COMBI.Results = {}
COMBI.Results["Gunpowder"] = 10

GMS.RegisterCombi("Gunpowder",COMBI,"Utilities")

/*---------------------------------------------------------
Cloneing Machine
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Cloneing Machine"
COMBI.Description = [[Uses unknown power from a meteor to clone resources.
You need:
800 Wood
500 Unobtainium
500 Water_Bottles
600 Platinum
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 800
COMBI.Req["Unobtainium"] = 1000
COMBI.Req["Platinum"] = 600
COMBI.Req["Water_Bottles"] = 500

COMBI.Results = {}
COMBI.Results = "gms_clonemachine"
COMBI.BuildSiteModel = "models/props/cs_militia/microwave01.mdl"

GMS.RegisterCombi("CloneMachine",COMBI,"Buildings")


/*---------------------------------------------------------
Special-Stargate SG1 DHD
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stargate SG1 DHD"
COMBI.Trophy = "ExcavationLvl1"
COMBI.Description = [[A rare artifact that links to another.
You need:
5 Diamond
500 Unobtaium
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 500
COMBI.Req["Diamond"] = 5

COMBI.Results = {}
COMBI.Results = "dhd_sg1"
COMBI.BuildSiteModel = "models/dhd/dhd.mdl"

GMS.RegisterCombi("StargateSG1DHD",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Special-Stargate SG1 Gate
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "StargateSG1"
COMBI.Trophy = "ExcavationLvl2"
COMBI.Description = [[A rare artifact that instantly teleports a user from A to B
You need:
2000 Wood
30 Diamond
3000 Unobtaium
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 3000
COMBI.Req["Diamond"] = 30
COMBI.Req["Wood"] = 2000

COMBI.Results = {}
COMBI.Results = "stargate_sg1"
COMBI.BuildSiteModel = "models/zup/stargate/sga_test_gate.mdl"

GMS.RegisterCombi("StargateSG1",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Special-Stargate Atlantis DHD
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "StargateAtlantis DHD"
COMBI.Trophy = "ExcavationLvl3"
COMBI.Description = [[A rare artifact that links to another.
You need:
5 Diamond
500 Unobtaium
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 500
COMBI.Req["Diamond"] = 5

COMBI.Results = {}
COMBI.Results = "dhd_atlantis"
COMBI.BuildSiteModel = "models/dhd/dhd.mdl"

GMS.RegisterCombi("StargateAtlantisDHD",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Special-Stargate Atlantis Gate
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Stargate Atlantis"
COMBI.Trophy = "ExcavationLvl4"
COMBI.Description = [[A rare artifact that instantly teleports a user from A to B
You need:
2000 Wood
30 Diamond
3000 Unobtaium
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 3000
COMBI.Req["Diamond"] = 30
COMBI.Req["Wood"] = 2000

COMBI.Results = {}
COMBI.Results = "stargate_atlantis"
COMBI.BuildSiteModel = "models/zup/stargate/sga_test_gate.mdl"

GMS.RegisterCombi("StargateAtlantis",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Special-Christmastree
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Christmas Tree"
COMBI.Trophy = "ChristmasTree"
COMBI.Description = [[A festive tree with wonderful decorations.
You need:
100 Wood
]]

COMBI.Req = {}
COMBI.Req["Wood"] = 100

COMBI.Results = {}
COMBI.Results = "gms_special_christmastree"
COMBI.BuildSiteModel = "models/cloud/kn_xmastree.mdl"

GMS.RegisterCombi("ChristmasTree:D",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Special-New Years
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "New Years Disco Ball"
COMBI.Trophy = "New_Years"
COMBI.Description = [[An awesome disco ball that bounces.
You need:
100 Unobtainium
]]

COMBI.Req = {}
COMBI.Req["Unobtainium"] = 100

COMBI.Results = {}
COMBI.Results = "gms_special_newyears"
COMBI.BuildSiteModel = "models/combine_helicopter/helicopter_bomb01.mdl"

GMS.RegisterCombi("NewYears",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Special-Nuka Cola
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Nuka Cola"
COMBI.Trophy = "Holy_Grail"
COMBI.Description = [[Only with the Holy Grail can you make this.
You need:
50 Watter bottles
5 Acidic_Water Bottles
10 Herbs
10 Berries
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 50
COMBI.Req["Acidic_Water"] = 5
COMBI.Req["Herbs"] = 10
COMBI.Req["Berries"] = 10

COMBI.Results = {}
COMBI.Results = "gms_special_nukacola"
COMBI.BuildSiteModel = "models/nukacola/bottle.mdl"

GMS.RegisterCombi("NukaCola",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Jeep
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Vehicle: Jeep"
COMBI.Trophy = "Grease_Monkey"
COMBI.Description = [[Allows you to easily get around.
You need:
100 Compound11
50 Unobtainium
10 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 10
COMBI.Req["Compound11"] = 100
COMBI.Req["Unobtainium"] = 50

COMBI.Results = {}
COMBI.Results = "gms_special_jeep"
COMBI.BuildSiteModel = "models/buggy.mdl"

GMS.RegisterCombi("Jeep",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
AirBoat
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Vehicle: Air Boat"
COMBI.Trophy = "Grease_Monkey"
COMBI.Description = [[Allows you to easily get around.
You need:
100 Compound11
50 Unobtainium
10 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 10
COMBI.Req["Compound11"] = 100
COMBI.Req["Unobtainium"] = 50

COMBI.Results = {}
COMBI.Results = "gms_special_airboat"
COMBI.BuildSiteModel = "models/airboat.mdl"

GMS.RegisterCombi("Airboat",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
AirBoat Seat
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Vehicle: Air Boat Seat"
COMBI.Trophy = "Grease_Monkey"
COMBI.Description = [[Allows you to easily get around.
You need:
100 Compound11
50 Unobtainium
10 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 10
COMBI.Req["Compound11"] = 100
COMBI.Req["Unobtainium"] = 50

COMBI.Results = {}
COMBI.Results = "gms_special_airboatseat"
COMBI.BuildSiteModel = "models/nova/airboat_seat.mdl"

GMS.RegisterCombi("AirboatSeat",COMBI,"SpecialBuildings")

/*---------------------------------------------------------
Jalopy
---------------------------------------------------------*/
local COMBI = {}

COMBI.Name = "Vehicle: Jalopy"
COMBI.Trophy = "Grease_Monkey"
COMBI.Description = [[Allows you to easily get around.
You need:
100 Compound11
50 Unobtainium
10 Water Bottles
]]

COMBI.Req = {}
COMBI.Req["Water_Bottles"] = 10
COMBI.Req["Compound11"] = 100
COMBI.Req["Unobtainium"] = 50

COMBI.Results = {}
COMBI.Results = "gms_special_jalopy"
COMBI.BuildSiteModel = "models/vehicle.mdl"

GMS.RegisterCombi("Jalopy",COMBI,"SpecialBuildings")