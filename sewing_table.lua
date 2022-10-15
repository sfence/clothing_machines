-- Sewing table

local S = clothing_machines.translator;
local adaptation = clothing_machines.adaptation

if (not adaptation.wood) or (not adaptation.wood_jungle) or (not adaptation.wool_white) then
  return
end

clothing_machines.sewing_table = appliances.appliance:new(
    {
      node_name_inactive = "clothing_machines:sewing_table",
      node_name_active = "clothing_machines:sewing_table_active",
      
      node_description = S("Sewing Table"),
      node_help = S("Sewing clothes from fabric and yarn.").."\n"..
                  S("Powered by punching."),
      
      input_stack = "input",
      input_stack_size = 9,
      input_stack_width = 3,
      use_stack = "input",
      use_stack_size = 0,
      have_usage = false,
    }
  );

local sewing_table = clothing_machines.sewing_table;

sewing_table:power_data_register(
  {
    ["punch_power"] = {
        run_speed = 1,
      },
  })

--------------
-- Formspec --
--------------

function sewing_table:get_formspec(meta, production_percent, consumption_percent)
  local progress = "image[5.1,1;4,1.5;appliances_production_progress_bar.png^[transformR270]]";
  if production_percent then
    progress = "image[5.1,1;4,1.5;appliances_production_progress_bar.png^[lowpart:" ..
            (production_percent) ..
            ":appliances_production_progress_bar_full.png^[transformR270]]";
  end
  
  local formspec =  "size[12.75,9.5]" ..
                    "background[-1.25,-1.25;15,11;appliances_appliance_formspec.png]" ..
                    progress..
                    self:get_player_inv() ..
                    self:get_formspec_list("context", "input", 1, 0, 3, 3)..
                    self:get_formspec_list("context", "output", 9, 0.75, 2, 2)..
                    "listring[current_player;main]" ..
                    "listring[context;input]" ..
                    "listring[current_player;main]" ..
                    "listring[context;output]" ..
                    "listring[current_player;main]";
  return formspec;
end

--------------------
-- Node callbacks --
--------------------

----------
-- Node --
----------

local node_def = {
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2,},
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = adaptation.wood_sounds,
    drawtype = "mesh",
    -- selection box {x=0, y=0, z=0}
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.5,0.25,-0.5,0.5,0.4375,0.5},
        {-0.375,-0.5,-0.375,-0.25,0.25,-0.25},
        {0.25,-0.5,-0.375,0.375,0.25,-0.25},
        {-0.375,0.4375,-0.375,0.0625,0.5,0.375},
        {0.25,0.4375,-0.375,0.3125,0.5,0.0},
        {0.1875,0.4375,-0.0625,0.25,0.5,0.125},
        {0.3125,0.4375,-0.0625,0.375,0.5,0.125},
        {0.25,0.4375,0.125,0.3125,0.5,0.1875},
        {-0.375,-0.5,0.25,-0.25,0.25,0.375},
        {0.25,-0.5,0.25,0.375,0.25,0.375},
      },
    },
    sunlight_propagates = true,
  }
local inactive_node = {
    tiles = {
      adaptation.wood.tile,
      adaptation.wood_jungle.tile,
      adaptation.wool_white.tile,
      "clothing_machines_sewing_table_needle.png"
    },
    mesh = "clothing_machines_sewing_table.obj",
  }
local active_node = {
    tiles = {
      adaptation.wood.tile,
      adaptation.wood_jungle.tile,
      adaptation.wool_white.tile,
      "clothing_machines_sewing_table_needle.png"
    },
    use_texture_alpha = "clip",
    mesh = "clothing_machines_sewing_table.obj",
  }

sewing_table:register_nodes(node_def, inactive_node, active_node)

-------------------------
-- Recipe Registration --
-------------------------

appliances.register_craft_type("clothing_machines_sewing", {
    description = S("Sewing"),
    icon = "clothing_bone_needle.png",
    width = 3,
    height = 3,
  })
  
sewing_table:register_recipes("clothing_machines_sewing", "")

