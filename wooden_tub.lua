-- Wooden tub
      
selection_box_machine = {
  type = "fixed",
  fixed = {
    {-0.125,-0.5,-0.4375,0.125,0.1875,-0.375},
    {-0.25,-0.5,-0.375,0.25,-0.4375,0.375},
    {-0.25,-0.4375,-0.375,-0.125,0.1875,-0.3125},
    {0.125,-0.4375,-0.375,0.25,0.1875,-0.3125},
    {-0.3125,-0.5,-0.3125,-0.25,0.1875,-0.25},
    {0.25,-0.5,-0.3125,0.3125,0.1875,-0.25},
    {-0.375,-0.5,-0.25,-0.25,-0.4375,0.25},
    {0.25,-0.5,-0.25,0.375,-0.4375,0.25},
    {-0.375,-0.4375,-0.25,-0.3125,0.1875,-0.125},
    {0.3125,-0.4375,-0.25,0.375,0.1875,-0.125},
    {-0.4375,-0.5,-0.125,-0.375,0.1875,0.125},
    {0.375,-0.5,-0.125,0.4375,0.1875,0.125},
    {-0.375,-0.4375,0.125,-0.3125,0.1875,0.25},
    {0.3125,-0.4375,0.125,0.375,0.1875,0.25},
    {-0.3125,-0.5,0.25,-0.25,0.1875,0.3125},
    {0.25,-0.5,0.25,0.3125,0.1875,0.3125},
    {-0.25,-0.4375,0.3125,-0.125,0.1875,0.375},
    {0.125,-0.4375,0.3125,0.25,0.1875,0.375},
    {-0.125,-0.5,0.375,0.125,0.1875,0.4375},
  },
}
selection_box_fill = {
  type = "fixed",
  fixed = {
    {-0.125,-0.5,-0.4375,0.125,0.1875,-0.375},
    {-0.25,-0.5,-0.375,0.25,-0.4375,0.375},
    {-0.25,-0.4375,-0.375,-0.125,0.1875,-0.3125},
    {0.125,-0.4375,-0.375,0.25,0.1875,-0.3125},
    {-0.3125,-0.5,-0.3125,-0.25,0.1875,-0.25},
    {0.25,-0.5,-0.3125,0.3125,0.1875,-0.25},
    {-0.375,-0.5,-0.25,-0.25,-0.4375,0.25},
    {0.25,-0.5,-0.25,0.375,-0.4375,0.25},
    {-0.375,-0.4375,-0.25,-0.3125,0.1875,-0.125},
    {0.3125,-0.4375,-0.25,0.375,0.1875,-0.125},
    {-0.4375,-0.5,-0.125,-0.375,0.1875,0.125},
    {0.375,-0.5,-0.125,0.4375,0.1875,0.125},
    {-0.375,-0.4375,0.125,-0.3125,0.1875,0.25},
    {0.3125,-0.4375,0.125,0.375,0.1875,0.25},
    {-0.3125,-0.5,0.25,-0.25,0.1875,0.3125},
    {0.25,-0.5,0.25,0.3125,0.1875,0.3125},
    {-0.25,-0.4375,0.3125,-0.125,0.1875,0.375},
    {0.125,-0.4375,0.3125,0.25,0.1875,0.375},
    {-0.125,-0.5,0.375,0.125,0.1875,0.4375},
    -- fill
    {-0.125,-0.4375,-0.375,0.125,0.0625,0.375},
    {-0.25,-0.4375,-0.3125,-0.125,0.0625,0.3125},
    {0.125,-0.4375,-0.3125,0.25,0.0625,0.3125},
    {-0.3125,-0.4375,-0.25,-0.25,0.0625,0.25},
    {0.25,-0.4375,-0.25,0.3125,0.0625,0.25},
    {-0.375,-0.4375,-0.125,-0.3125,0.0625,0.125},
    {0.3125,-0.4375,-0.125,0.375,0.0625,0.125},
  },
}

local S = clothing_machines.translator;

local adaptation = clothing_machines.adaptation

if (not adaptation_lib.check_keys_aviable("[clothing_machines] Wooden_tub: ", adaptation, {"wood", "water_river", "bucket_empty", "buckets_water"})) then
  return
end

local function process_punch_item(pos, node, puncher, punch_item)
  if punch_item.call_on_punch then
    if punch_item.call_on_punch(punch_item, pos, node, puncher) then
      return
    end
  end
  if punch_item.new_node_name then
    node.name = punch_item.new_node_name;
    minetest.set_node(pos, node);
  end
  if punch_item.take_items then
    local wielded_item = puncher:get_wielded_item()
    wielded_item:take_item(punch_item.take_items);
    puncher:set_wielded_item(wielded_item);
  end
  if punch_item.replace_item then
    puncher:set_wielded_item(punch_item.replace_item);
  end
end
    
function clothing_machines.wooden_tub_empty_on_punch(pos, node, puncher, pointed_thing, bucket_empty, bucket_fill, wooden_tub_empty)
  if (puncher) then
    local wielded_item = puncher:get_wielded_item();
    local wielded_name = wielded_item:get_name();
    
    if (wielded_name==bucket_empty) then
      local inv = puncher:get_inventory();
      local list = puncher:get_wield_list();
      local bucket = ItemStack(bucket_fill);
      wielded_item:take_item(1);
      puncher:set_wielded_item(wielded_item);
      if (inv:room_for_item(list, bucket)) then
        inv:add_item(list, bucket);
      else
        minetest.item_drop(bucket, puncher, puncher:get_pos())
      end
      
      local meta = minetest.get_meta(pos)
      inv = meta:get_inventory()
      local lists = inv:get_lists()
      
      for _, list_items in pairs(lists) do
        for _, item in pairs(list_items) do
          minetest.add_item(pos, item)
        end
      end
      
      node.name = wooden_tub_empty or "clothing_machines:wooden_tub_empty";
      minetest.set_node(pos, node);
    end
  end
end

clothing_machines.tub_empty_punch_items = {}

for _,water_bucket in pairs(adaptation.buckets_water or {}) do
  clothing_machines.tub_empty_punch_items[water_bucket] = {
      new_node_name = "clothing_machines:wooden_tub_water",
      replace_item = adaptation.bucket_empty,
    }
end

local node_desc = S("Empty Wooden Tub");
local node_help = S("Fill with water and dye.").."\n"..
                  S("Need time to colorize wool, fabric or yarn.")
minetest.register_node("clothing_machines:wooden_tub_empty", appliances.item_def_with_help({
    description = node_desc,
    short_description = node_desc,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2,},
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = adaptation.wood.sounds,
    drawtype = "mesh",
    -- selection box {x=0, y=0, z=0}
    selection_box = selection_box_machine,
    sunlight_propagates = true,
    tiles = {
      adaptation.wood.tile,
    },
    mesh = "clothing_machines_dye_machine.obj",
    
    on_punch = function(pos, node, puncher, pointed_thing)
        if (puncher) then
          local wielded_item = puncher:get_wielded_item();
          local wielded_name = wielded_item:get_name();
          
          local punch_item = clothing_machines.tub_empty_punch_items[wielded_name];
          if punch_item then
            process_punch_item(pos, node, puncher, punch_item);
          end
        end
      end,
  }, node_help))

clothing_machines.tub_water_punch_items = {}

minetest.register_node("clothing_machines:wooden_tub_water", {
    description = S("Wooden Tub Filled With Water"),
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2,},
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = adaptation.wood.sounds,
    drop = "clothing_machines:wooden_tub_empty",
    drawtype = "mesh",
    -- selection box {x=0, y=0, z=0}
    selection_box = selection_box_fill,
    sunlight_propagates = true,
    use_texture_alpha = "blend",
    tiles = {
      adaptation.wood.tile,
      adaptation.water_river.tile_noanim or adaptation.water_river.tile,
    },
    mesh = "clothing_machines_dye_machine_fill.obj",
    
    on_punch = function(pos, node, puncher, pointed_thing)
        if (puncher) then
          local wielded_item = puncher:get_wielded_item();
          local wielded_name = wielded_item:get_name();
          
          local punch_item = clothing_machines.tub_water_punch_items[wielded_name];
          if punch_item then
            process_punch_item(pos, node, puncher, punch_item);
          end
        end
      end,
  })
local node_desc = S("Wooden Tub Filled With Dirty Water");
minetest.register_node("clothing_machines:wooden_tub_water_dirty", appliances.item_def_with_help({
    description = node_desc,
    short_description = node_desc,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2,},
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = adaptation.wood.sounds,
    drawtype = "mesh",
    -- selection box {x=0, y=0, z=0}
    selection_box = selection_box_fill,
    sunlight_propagates = true,
    use_texture_alpha = "clip",
    tiles = {
      adaptation.wood.tile,
      "clothing_machines_dirty_water.png"
    },
    mesh = "clothing_machines_dye_machine_fill.obj",
    
    can_dig = function() return false; end,
    
    on_punch = function(pos, node, puncher, pointed_thing)
        clothing_machines.wooden_tub_empty_on_punch(pos, node, puncher, pointed_thing, adaptation.bucket_empty, "clothing_machines:bucket_dirty_water")
      end,
    allow_metadata_inventory_move = function() return 0; end,
    allow_metadata_inventory_put = function() return 0; end,
    on_metadata_inventory_take = function(pos)
        local meta = minetest.get_meta(pos);
        meta:set_string("formspec", "");
      end,
  }, S("Empty it by empty bucket.")))

function clothing_machines.base_node_def_wooden_tub_fill()
  return {
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, not_in_creative_inventory = 1},
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = adaptation.wood.sounds,
    drop = "clothing_machines:wooden_tub_empty",
    drawtype = "mesh",
    -- selection box {x=0, y=0, z=0}
    selection_box = selection_box_fill,
    collision_box = selection_box_fill,
    
    mesh = "clothing_machines_dye_machine_fill.obj",
    use_texture_alpha = "blend",
    tiles = {
      adaptation.wood.tile,
      adaptation.water_river.tile_noanim or adaptation.water_river.tile,
    },
  }
end
