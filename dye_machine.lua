
-- dye machine

local S = clothing_machines.translator;

local adaptation = clothing_machines.adaptation

if (not adaptation_lib.check_keys_aviable("[clothing_machines] Wooden_tub: ", adaptation, {"wood", "wool_mod", "wool_white", "buckets_water"}))
    or (not clothing_machines.tub_water_punch_items) then
  return
end

local S = clothing_machines.translator;

local adaptation = clothing_machines.adaptation

appliances.register_craft_type("clothing_machines_dying", {
    description = S("Dying"),
    icon = "clothing_machines_recipe_dying.png",
    width = 1,
    height = 1,
  })

clothing_machines.dye_machines = {}


for color, data in pairs(adaptation_lib.basic_colors) do
  dye_machine_key = "dye_machine_"..color;
  
  for _, dye in pairs(data.dyes or {}) do
    clothing_machines.tub_water_punch_items[dye] = {
        new_node_name = "clothing_machines:"..dye_machine_key,
        take_items = 1,
      }
  end
  
  clothing_machines.dye_machines[color] = appliances.appliance:new(
      {
        node_name_inactive = "clothing_machines:"..dye_machine_key,
        node_name_active = "clothing_machines:"..dye_machine_key.."_active",
        
        node_description = S("Dye Machine"),
        node_help = S("Colorize white wool, yarn, fabric.").."\n"..
                    S("Need time to colorize."),
        
        use_stack_size = 0,
        output_stack_size = 1,
        have_usage = false,
        
        sounds = {
          running = {
            sound = "clothing_machines_dye_machine_running",
            sound_param = {max_hear_distance = 8, gain = 1},
            repeat_timer = 0,
          },
        },
      }
    );

  local dye_machine = clothing_machines.dye_machines[color];

  dye_machine:power_data_register(
    {
      ["time_power"] = {
          run_speed = 1,
        },
    })
  
  --------------
  -- Formspec --
  --------------

  function dye_machine:get_formspec(meta, production_percent, consumption_percent)
    local progress = "image[3.6,0.9;5.5,0.95;appliances_production_progress_bar.png^[transformR270]]";
    if production_percent then
      progress = "image[3.6,0.9;5.5,0.95;appliances_production_progress_bar.png^[lowpart:" ..
              (production_percent) ..
              ":appliances_production_progress_bar_full.png^[transformR270]]";
    end
    
    local formspec =  "formspec_version[3]" .. "size[12.75,8.5]" ..
                      "background[-1.25,-1.25;15,10;appliances_appliance_formspec.png]" ..
                      progress..
                      self:get_player_inv() ..
                      self:get_formspec_list("context", self.input_stack, 2, 0.8, 1, 1)..
                      self:get_formspec_list("context", self.output_stack, 9.75, 0.8, 1, 1)..
                      "listring[current_player;main]" ..
                      "listring[context;"..self.input_stack.."]" ..
                      "listring[current_player;main]" ..
                      "listring[context;"..self.output_stack.."]" ..
                      "listring[current_player;main]";
    return formspec;
  end

  --------------------
  -- Node callbacks --
  --------------------
  
  function dye_machine:cb_can_dig(pos)  
    return false;
  end
  function dye_machine:cb_allow_metadata_inventory_put(pos, listname, index, stack, player)
    local player_name = nil
    if player then
      player_name = player:get_player_name()
    end
    local can_put = self:recipe_inventory_can_put(pos, listname, index, stack, player_name);
    if (can_put>0) then
      local meta = minetest.get_meta(pos);
      local inv = meta:get_inventory();
      
      if (inv:get_stack(listname, index):get_count()~=0) then
        return 0;
      end
      
      return 1;
    end
    return can_put;
  end

  function dye_machine:after_timer_step(timer_step)
    local use_input, use_usage = self:recipe_aviable_input(timer_step.inv)
    if use_input then
      self:running(timer_step.pos, timer_step.meta);
      return true
    else
      self:deactivate(timer_step.pos, timer_step.meta);
      local node = minetest.get_node(timer_step.pos);
    
      local formspec =  "formspec_version[3]" .. "size[12.75,8.5]" ..
                        "background[-1.25,-1.25;15,10;appliances_appliance_formspec.png]" ..
                        adaptation_lib.player.formspec_inv ..
                        "list[context;"..self.output_stack..";6.0,0.8;1,1;]" ..
                        "listring[current_player;main]" ..
                        "listring[context;"..self.output_stack.."]";
      
      timer_step.meta:set_string("infotext", S("Dye machine with dirty water"));
      timer_step.meta:set_string("formspec", formspec);
      node.name = "clothing_machines:wooden_tub_water_dirty"
      minetest.swap_node(timer_step.pos, node);
      return false
    end
  end

  ----------
  -- Node --
  ----------
  
  local node_def = clothing_machines.base_node_def_wooden_tub_fill()
  local inactive_node = {
      tiles = {
        adaptation.wood.tile,
        "clothing_machines_dye_machine_fill.png^[multiply:#"..data.hex,
      },
      mesh = "clothing_machines_dye_machine_fill.obj",
    }
  local active_node = {
      tiles = {
        adaptation.wood.tile,
        "clothing_machines_dye_machine_fill.png^[multiply:#"..data.hex,
      },
      mesh = "clothing_machines_dye_machine_fill.obj",
    }
  
  dye_machine:register_nodes(node_def, inactive_node, active_node)

  -------------------------
  -- Recipe Registration --
  -------------------------
  
  local wool = adaptation_lib.get_item({"wool_"..color})
  if wool then
    dye_machine:recipe_register_input(
      adaptation.wool_white.name,
      {
        inputs = 1,
        outputs = {wool.name},
        production_time = 45,
        consumption_step_size = 1,
      });
    if adaptation.wool_mod and adaptation.wool_mod.clear_colored_wool_recipe then
      adaptation.wool_mod.clear_colored_wool_recipe(wool.color)
    end
  end
  dye_machine:register_recipes("clothing_machines_dying", "")
end

