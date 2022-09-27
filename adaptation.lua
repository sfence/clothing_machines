
local adaptation = {}
clothing_machines.adaptation = adaptation

-- items
adaptation.bucket_empty = adaptation_lib.get_item({"bucket_empty"})
adaptation.buckets_water = adaptation_lib.get_list("bucket_water")

adaptation.wood = adaptation_lib.get_item({"wood_common"})
adaptation.wood_jungle = adaptation_lib.get_item({"wood_jungle"})
adaptation.wood_pine = adaptation_lib.get_item({"wood_pine", "wood_larch", "wood_violet"})

adaptation.wool_white = adaptation_lib.get_item({"wool_raw", "wool_white"})

adaptation.string = adaptation_lib.get_item({"string"})

adaptation.water_river = adaptation_lib.get_item({"water_river", "water"})

adaptation.water_sources = adaptation_lib.get_list("water_source")

adaptation.gravel = adaptation_lib.get_item({"gravel"})

-- groups
adaptation.group_wood = adaptation_lib.get_group("wood")
adaptation.group_stick = adaptation_lib.get_group("stick")
adaptation.group_string = adaptation_lib.get_group("string")
adaptation.group_bone = adaptation_lib.get_group("bone")

-- mods
adaptation.wool_mod = adaptation_lib.get_mod("wool")


