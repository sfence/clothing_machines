
local adaptation = clothing_machines.adaptation

if adaptation.group_bone then
  minetest.register_craft({
    output = 'clothing_machines:bone_needle',
    recipe = {
      {adaptation.group_bone},
      {adaptation.group_bone},
    },
  })
end

if adaptation.string and adaptation.group_wood then
  minetest.register_craft({
    output = 'clothing_machines:spinning_machine',
    recipe = {
      {adaptation.group_wood, adaptation.group_wood, adaptation.group_wood},
      {adaptation.group_wood, adaptation.string.name, adaptation.group_wood},
      {adaptation.group_wood, adaptation.group_wood, adaptation.group_wood},
    },
  })
end

if adaptation.wood_pine and adaptation.group_stick then
  minetest.register_craft({
    output = 'clothing_machines:loom',
    recipe = {
      {adaptation.group_stick, adaptation.wood_pine.name, adaptation.group_stick},
      {adaptation.group_stick, adaptation.wood_pine.name, adaptation.group_stick},
      {adaptation.wood_pine.name, adaptation.wood_pine.name, adaptation.wood_pine.name},
    },
  })
end

if adaptation.group_wood and adaptation.group_stick then
  minetest.register_craft({
    output = 'clothing_machines:wooden_tub_empty',
    recipe = {
      {adaptation.group_wood, adaptation.group_stick, adaptation.group_wood},
      {adaptation.group_wood, adaptation.group_stick, adaptation.group_wood},
      {adaptation.group_wood, adaptation.group_wood, adaptation.group_wood},
    },
  })
end


if adaptation.group_wood and adaptation.group_stick then
  minetest.register_craft({
    output = 'clothing_machines:sewing_table',
    recipe = {
      {adaptation.group_wood, adaptation.group_wood, adaptation.group_wood},
      {adaptation.group_stick, 'clothing_machines:bone_needle', adaptation.group_stick},
      {adaptation.group_stick, 'clothing_machines:bone_needle', adaptation.group_stick},
    },
  })
end

