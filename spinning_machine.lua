-- Spinning machine

local S = clothing_machines.translator;

local adaptation = clothing_machines.adaptation

if (not adaptation.wood) or (not adaptation.wood_jungle) or (not adaptation.wool_white) then
  return
end

clothing_machines.spinning_machine = appliances.appliance:new(
    {
      node_name_inactive = "clothing_machines:spinning_machine",
      node_name_active = "clothing_machines:spinning_machine_active",
      
      node_description = S("Spinning Machine"),
      node_help = S("Fill yarn empty spool by yarn.").."\n"..
                  S("Powered by punching."),
      
      sounds = {
        running = {
          sound = "clothing_machines_spinning_machine_running",
          sound_param = {max_hear_distance = 8, gain = 1},
          repeat_timer = 0,
        },
      },
    }
  );

local spinning_machine = clothing_machines.spinning_machine;

spinning_machine:power_data_register(
  {
    ["punch_power"] = {
        run_speed = 1,
      },
  })

--------------
-- Formspec --
--------------

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
    sounds = adaptation.wood.sounds,
    drawtype = "mesh",
    -- selection box {x=0, y=0, z=0}
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.1875,-0.5,-0.3125,0.1875,-0.4375,-0.25},
        {-0.0625,-0.5,-0.25,0.0625,-0.4375,0.3125},
        {-0.125,-0.375,-0.1875,0.125,-0.3125,0.25},
        {-0.0625,0.3125,-0.1875,0.0625,0.375,0.25},
        {-0.1875,-0.5,-0.125,-0.125,-0.3125,-0.0625},
        {0.125,-0.5,-0.125,0.1875,-0.3125,-0.0625},
        {-0.0625,-0.3125,-0.125,0.0625,0.3125,-0.0625},
        {-0.125,0.3125,-0.125,-0.0625,0.375,-0.0625},
        {0.0625,0.3125,-0.125,0.375,0.375,-0.0625},
        {-0.1875,-0.375,-0.0625,-0.125,-0.3125,0.1875},
        {0.125,-0.375,-0.0625,0.1875,-0.3125,0.1875},
        {0.1875,0.25,-0.0625,0.25,0.4375,0.0},
        {0.125,0.3125,-0.0625,0.1875,0.375,0.0},
        {0.25,0.3125,-0.0625,0.3125,0.375,0.0},
        {-0.0625,0.4375,-0.0625,0.0625,0.5,0.125},
        {-0.125,-0.3125,0.0,0.125,-0.25,0.0625},
        {-0.1875,-0.25,0.0,-0.125,-0.1875,0.0625},
        {0.125,-0.25,0.0,0.1875,-0.1875,0.0625},
        {-0.25,-0.1875,0.0,-0.1875,-0.125,0.0625},
        {0.1875,-0.1875,0.0,0.25,-0.125,0.0625},
        {-0.3125,-0.125,0.0,-0.25,0.125,0.0625},
        {0.25,-0.125,0.0,0.3125,0.125,0.0625},
        {-0.3125,0.125,0.0,-0.25,0.25,0.0625},
        {-0.25,0.125,0.0,-0.1875,0.1875,0.0625},
        {0.1875,0.125,0.0,0.25,0.1875,0.0625},
        {0.25,0.125,0.0,0.3125,0.25,0.0625},
        {-0.1875,0.1875,0.0,-0.125,0.25,0.0625},
        {0.125,0.1875,0.0,0.1875,0.25,0.0625},
        {-0.25,0.25,0.0,-0.1875,0.375,0.0625},
        {-0.125,0.25,0.0,0.125,0.3125,0.0625},
        {0.1875,0.25,0.0,0.25,0.3125,0.0625},
        {0.1875,0.3125,0.0,0.25,0.375,0.1875},
        {-0.1875,0.375,0.0,-0.125,0.4375,0.0625},
        {-0.0625,0.375,0.0,0.0625,0.4375,0.0625},
        {0.125,0.375,0.0,0.1875,0.4375,0.0625},
        {-0.125,0.4375,0.0,-0.0625,0.5,0.0625},
        {0.0625,0.4375,0.0,0.125,0.5,0.0625},
        {-0.1875,-0.5,0.125,-0.125,-0.375,0.1875},
        {0.125,-0.5,0.125,0.1875,-0.375,0.1875},
        {-0.0625,-0.3125,0.125,0.0625,0.3125,0.1875},
        {-0.125,0.3125,0.125,-0.0625,0.375,0.1875},
        {0.0625,0.3125,0.125,0.1875,0.375,0.1875},
        {0.25,0.3125,0.125,0.375,0.375,0.1875},
        -- wheel
        {-0.1875,-0.1875,0.0,-0.125,-0.125,0.0625},
        {0.125,-0.1875,0.0,0.1875,-0.125,0.0625},
        {-0.125,-0.125,0.0,-0.0625,-0.0625,0.0625},
        {0.0625,-0.125,0.0,0.125,-0.0625,0.0625},
        {-0.0625,-0.0625,0.0,0.0625,0.0625,0.0625},
        {-0.125,0.0625,0.0,-0.0625,0.125,0.0625},
        {0.0625,0.0625,0.0,0.125,0.125,0.0625},
        {-0.1875,0.125,0.0,-0.125,0.1875,0.0625},
        {0.125,0.125,0.0,0.1875,0.1875,0.0625},
      },
    },
    sunlight_propagates = true,
  }
local inactive_node = {
    tiles = {
      adaptation.wood.tile,
      adaptation.wood_jungle.tile,
      adaptation.wool_white.tile,
      adaptation.wood_jungle.tile,
    },
    mesh = "clothing_machines_spinning_machine.obj",
  }
local active_node = {
    tiles = {
      adaptation.wood.tile,
      adaptation.wood_jungle.tile,
      adaptation.wool_white.tile,
      {
        image = "clothing_machines_spinning_machine_wheel_active.png",
        backface_culling = true,
        animation = {
          type = "vertical_frames",
          aspect_w = 16,
          aspect_h = 16,
          length = 0.3,
        }
      },
    },
    use_texture_alpha = "clip",
    mesh = "clothing_machines_spinning_machine_active.obj",
  }

spinning_machine:register_nodes(node_def, inactive_node, active_node)

-------------------------
-- Recipe Registration --
-------------------------

appliances.register_craft_type("clothing_machines_spinning", {
    description = S("Spinning"),
    icon = "clothing_machines_recipe_spinning.png",
    width = 1,
    height = 1,
  })
appliances.register_craft_type("clothing_machines_spinning_use", {
    description = S("Use for spinning"),
    icon = "clothing_machines_recipe_spinning.png",
    width = 1,
    height = 1,
  })
  
spinning_machine:register_recipes("clothing_machines_spinning", "clothing_machines_spinning_use")

