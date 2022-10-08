
local S = clothing_machines.translator;

local adaptation = clothing_machines.adaptation

if (not adaptation.water_river) then
  return
end

minetest.register_node("clothing_machines:dirty_water_source", {
	description = S("Dirty Water Source"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "clothing_machines_dirty_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "clothing_machines_dirty_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 2,
	liquidtype = "source",
	liquid_alternative_flowing = "clothing_machines:dirty_water_flowing",
	liquid_alternative_source = "clothing_machines:dirty_water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 225, r = 80, g = 65, b = 51},
	groups = {liquid = 3, cools_lava = 1},
	sounds = adaptation.water_river.sounds,
})

minetest.register_node("clothing_machines:dirty_water_flowing", {
	description = S("Flowing Dirty Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"clothing_machines_dirty_water.png"},
	special_tiles = {
		{
			name = "clothing_machines_dirty_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "clothing_machines_dirty_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 2,
	liquidtype = "flowing",
	liquid_alternative_flowing = "clothing_machines:dirty_water_flowing",
	liquid_alternative_source = "clothing_machines:dirty_water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 225, r = 80, g = 65, b = 51},
	groups = {liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = adaptation.water_river.sounds,
})

if adaptation.bucket_mod then
  adaptation.bucket_mod.register_bucket(
    "clothing_machines:dirty_water_source",
    "clothing_machines:dirty_water_flowing",
    "clothing_machines:bucket_dirty_water",
    "clothing_machines_bucket_dirty_water.png",
    S("Dirty Water Bucket"),
    {tool = 1}
  )
  appliances.add_item_help("clothing_machines:bucket_dirty_water", S("Put dirty water on gravel and wait for cleaning it."))
end

if adaptation.gravel and adaptation.water_river then
  minetest.register_abm({
    label = "Cleaning dirty water by gravel",
    nodenames = {"clothing_machines:dirty_water_source"},
    neighbors = {adaptation.gravel.name},
    interval = 30,
    chance = 60, -- etc 1800 sconds to clean 60 dirty water near gravel
    action = function(pos, node) 
        node.name = adaptation.water_river.name;
        local near = minetest.find_node_near(pos, 2, "group:water");
        if near then
          near = minetest.get_node(near);
          node.name = minetest.registered_nodes[near.name].liquid_alternative_source;
        end
        minetest.set_node(pos, node);
      end,
  });
end

if adaptation.water_sources then
  local random_gen = PcgRandom(os.clock())
  local look_for = table.copy(adaptation.water_sources)
  table.insert(look_for, "clothing_machines:dirty_water_source")

  local function mixing_water(pos, node)
    local pos1 = {x=pos.x-1,y=pos.y-1,z=pos.z-1};
    local pos2 = {x=pos.x+1,y=pos.y+1,z=pos.z+1};
    local finds = minetest.find_nodes_in_area(pos1, pos2, look_for, true);
    local sum = 0;
    local nodes = {};
    for key, found in pairs(finds) do
      nodes[key] = table.getn(found);
      sum = sum + nodes[key];
    end
    local num = sum;
    if (sum>1) then
      num = random_gen:next(1,sum);
    end
    --local num = random_gen:next(1,27)-27+sum;
    if (num>1) then
      for key,number in pairs(nodes) do
        if (num<=number) then
          if (node.name ~= key) then
            node.name = key;
            minetest.set_node(pos, node);
          end
          break;
        end
        num = num - number;
      end
    end
  end
  
  minetest.register_abm({
    label = "Mixing dirty water and water",
    nodenames = {"clothing_machines:dirty_water_source"},
    neighbors = adaptation.water_sources,
    interval = 5,
    chance = 5, 
    action = mixing_water,
  });

  minetest.register_abm({
    label = "Mixing water and dirty water",
    nodenames = adaptation.water_sources,
    neighbors = {"clothing_machines:dirty_water_source"},
    interval = 5,
    chance = 5, 
    action = mixing_water,
  });
end
