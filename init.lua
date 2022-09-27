
clothing_machines = {
  translator = minetest.get_translator("clothing_machines"),
}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/adaptation.lua")

dofile(modpath.."/dirty_water.lua")
dofile(modpath.."/wooden_tub.lua")
dofile(modpath.."/dye_machine.lua")

dofile(modpath.."/spinning_machine.lua")
dofile(modpath.."/loom.lua")
dofile(modpath.."/sewing_table.lua")

dofile(modpath.."/craftitems.lua")
dofile(modpath.."/crafting.lua")

