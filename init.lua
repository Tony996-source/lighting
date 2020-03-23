lighting = {}

function lighting.register_variants(variants, fixedDef)
  for _,variant in ipairs(variants) do
    local name = variant.name
    local def = table.copy(fixedDef)

    for k,v in pairs(variant) do
      if k ~= "name" then
        def[k] = v
      end
    end

    minetest.register_node(name, def)
  end
end

function lighting.on_place_hanging(itemstack, placer, pointed_thing, replaceName)
  local ceiling = minetest.get_node(vector.add(pointed_thing.above,
    {x=0, y=1, z=0}))

  if ceiling and ceiling.name ~= "air"
    and minetest.get_item_group(ceiling.name, "mounted_ceiling") == 0
    and not (placer and placer:get_player_control().sneak) then

    local name = itemstack:get_name()
    local fakestack = itemstack
    fakestack:set_name(replaceName)

    minetest.item_place(fakestack, placer, pointed_thing, 0)
    itemstack:set_name(name)

    return itemstack
  end

  minetest.item_place(itemstack, placer, pointed_thing, 0)
  return itemstack
end

function lighting.rotate_and_place(itemstack, placer, pointed_thing, lookup)
  local dir = minetest.dir_to_wallmounted(vector.subtract(pointed_thing.under, pointed_thing.above))
  local fDirs = lookup or {[0] = 20, 0, 16, 12, 8, 4}
  minetest.item_place(itemstack, placer, pointed_thing, fDirs[dir] or 0)
  return itemstack
end

local path = minetest.get_modpath("lighting")


-- half node
minetest.register_node('lighting:glowlight_half_white', {
	description = ("White Glowlight (thick)"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_white_tb.png',
		'glowlight_white_tb.png',
		'glowlight_thick_white_sides.png',
		'glowlight_thick_white_sides.png',
		'glowlight_thick_white_sides.png',
		'glowlight_thick_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3},
	drop="lighting:glowlight_half_white",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Quarter node

minetest.register_node('lighting:glowlight_quarter_white', {
	description = ("White Glowlight (thin)"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_white_tb.png',
		'glowlight_white_tb.png',
		'glowlight_thin_white_sides.png',
		'glowlight_thin_white_sides.png',
		'glowlight_thin_white_sides.png',
		'glowlight_thin_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3},
	drop="lighting:glowlight_quarter_white",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Glowlight small cube
minetest.register_node('lighting:glowlight_small_cube_white', {
	description = ("White Glowlight (small cube)"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_cube_white_tb.png',
		'glowlight_cube_white_tb.png',
		'glowlight_cube_white_sides.png',
		'glowlight_cube_white_sides.png',
		'glowlight_cube_white_sides.png',
		'glowlight_cube_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3},
	drop="lighting:glowlight_small_cube_white",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Glowlight block
minetest.register_node('lighting:glowlightblock', {
	description = ("Glowlight block"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png'
	},
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX-1,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3},
	drop="lighting:glowlight_block",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Modern cieling light
minetest.register_node("lighting:glowlight_modern", {
  description = "Modern Ceiling Light",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/4, 3/8, -1/4, 1/4, 1/2, 1/4}
  },
  tiles = {"metal_dark.png",
    "metal_dark.png^modern_block.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = LIGHT_MAX,
  groups = {cracky = 3, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing,
      {[0] = 0, 20, 12, 16, 4, 8})
  end,
})

-- Table lamps
lighting.register_variants({
  {name = "lighting:tablelamp_d",
    description = "Modern Table Lamp (dark)",
    tiles = {"metal_light_32.png^modern_tablelamp_o.png",
    "modern_tablelamp_d.png"}},
  {name = "lighting:tablelamp_l",
    description = "Modern Table Lamp (light)",
    tiles = {"metal_dark_32.png^modern_tablelamp_o.png",
    "modern_tablelamp_l.png"}},
},
{
  drawtype = "mesh",
  mesh = "modern_tablelamp.obj",
  collision_box = {
    type = "fixed",
    fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
  },
  paramtype = "light",
  light_source = 10,
  groups = {choppy = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_defaults(),
})

minetest.register_node("lighting:walllamp", {
  description = "Modern Wall Lamp",
  drawtype = "mesh",
  mesh = "modern_walllamp.obj",
  collision_box = {
    type = "fixed",
    fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
  },
  tiles = {"metal_dark_32.png^modern_walllamp.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),

  on_place = function(itemstack, placer, pointed_thing)
    return morelights.rotate_and_place(itemstack, placer, pointed_thing,
      {[0] = 6, 4, 1, 3, 0, 2})
  end,
})

-- Light bars
minetest.register_node("lighting:barlight_c", {
  description = "Ceiling Bar Light (connecting)",
  drawtype = "nodebox",
  node_box = {
    type = "connected",
    fixed = {-1/8,  3/8, -1/8, 1/8,  1/2, 1/8},
    connect_front = {-1/8, 3/8, -1/2, 1/8,  1/2, -1/8},
    connect_left = {-1/2, 3/8, -1/8, -1/8, 1/2, 1/8},
    connect_back = {-1/8, 3/8, 1/8, 1/8, 1/2, 1/2},
    connect_right = {1/8, 3/8, -1/8, 1/2, 1/2, 1/8},
  },
  connects_to = {"lighting:barlight_c", "lighting:barlight_s",
    "modern:streetpost_d", ":streetpost_l"},
  tiles = {"metal_dark.png", "modern_barlight.png",
    "metal_dark.png"},
  paramtype = "light",
  light_source = LIGHT_MAX,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lighting:barlight_s", {
  description = "Ceiling Bar Light (straight)",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/2, 3/8, -1/8, 1/2, 1/2, 1/8},
  },
  tiles = {"metal_dark.png", "modern_barlight.png",
    "metal_dark.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = LIGHT_MAX,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
})

-- Vintage lights

minetest.register_node("lighting:vintage_lantern_f", {
  description = "Vintage Lantern (floor, wall, or ceiling)",
  drawtype = "mesh",
  mesh = "vintage_lantern_f.obj",
  tiles = {"vintage_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  paramtype = "light",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),

  on_place = function(itemstack, placer, pointed_thing)
		local wdir = minetest.dir_to_wallmounted(
      vector.subtract(pointed_thing.under, pointed_thing.above))
		local fakestack = itemstack

		if wdir == 0 then
			fakestack:set_name("lighting:vintage_lantern_c")
		elseif wdir == 1 then
			fakestack:set_name("lighting:vintage_lantern_f")
		else
			fakestack:set_name("lighting:vintage_lantern_w")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("lighting:vintage_lantern_f")

		return itemstack
	end,
})

minetest.register_node("lighting:vintage_lantern_c", {
  drawtype = "mesh",
  mesh = "vintage_lantern_c.obj",
  tiles = {"vintage_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/16, -3/16, 3/16, 1/2, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, 0, -3/16, 3/16, 1/2, 3/16}
  },
  paramtype = "light",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3,
    not_in_creative_inventory = 1},
  sounds = default.node_sound_glass_defaults(),
  drop = "lighting:vintage_lantern_f",
})

minetest.register_node("lighting:vintage_lantern_w", {
  drawtype = "mesh",
  mesh = "vintage_lantern_w.obj",
  tiles = {"vintage_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
  },
  selection_box = {
    type = "wallmounted",
    wall_bottom = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16},
    wall_side = {-1/4, -5/16, -3/16, 1/8, 3/16, 3/16},
    wall_top = {-3/16, -1/8, -5/16, 3/16, 1/4, 3/16}
  },
  paramtype = "light",
  paramtype2 = "wallmounted",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3,
    not_in_creative_inventory = 1},
  sounds = default.node_sound_glass_defaults(),
  drop = "lighting:vintage_lantern_f",
})

-- Lantern
minetest.register_node("lighting:lantern", {
	description = "Lantern",
	drawtype = "nodebox",
	tiles = {"lantern.png","lantern.png","lantern.png","lantern.png","lantern.png","lantern.png"},
	inventory_image = minetest.inventorycube("lantern_inv.png"),
	wield_image = minetest.inventorycube("lantern_inv.png"),
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = LIGHT_MAX - 1,
	walkable = false,
	groups = {cracky = 2, dig_immediate = 3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "wallmounted",
		wall_top = {-1/6, 1/6, -1/6, 1/6, 0.5, 1/6},		
		wall_bottom = {-1/6, -0.5, -1/6, 1/6, -1/6, 1/6}, 	
		wall_side = {-1/6, -1/6, -1/6, -0.5, 1/6, 1/6},
		},
})

minetest.register_node("lighting:lamp", {
	description = "Lamp",
	tiles = {"lamp.png", "lamp.png", "lamp.png", "lamp.png", "lamp.png", "lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX - 1,
	groups = {cracky = 2, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

-- Crafts
minetest.register_craft({
  output = "lighting:glowlight_half_white",
  recipe = {
    {"default:glass", "default:torch", "default:glass"},
    {"default:glass", "default:glass", "default:glass"}
  }
})

minetest.register_craft({
  output = "lighting:glowlight_quarter_white",
  recipe = {
    {"default:glass", "default:torch", "default:glass"},
  }
})

minetest.register_craft({
  output = "lighting:glowlightblock",
  recipe = {
    {"default:glass", "default:glass", "default:glass"},
    {"default:glass", "default:torch", "default:glass"},
    {"default:glass", "default:glass", "default:glass"}
  }
})

minetest.register_craft({
  output = "lighting:glowlight_small_cube_white",
  recipe = {
    {"", "default:glass", ""},
    {"default:glass", "default:torch", "default:glass"},
    {"", "default:glass", ""}
  }
})

minetest.register_craft({
  output = "lighting:barlight_c 4",
  recipe = {
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    {"default:copper_ingot", "default:glass", "default:copper_ingot"}
  }
})

minetest.register_craft({
  output = "lighting:barlight_c",
  type = "shapeless",
  recipe = {"lighting:barlight_s"}
})

minetest.register_craft({
  output = "lighting:barlight_s",
  type = "shapeless",
  recipe = {"lighting:barlight_c"}
})

minetest.register_craft({
  output = "lighting:glowlight_modern",
  recipe = {
    {"default:steel_ingot", "default:torch", "default:steel_ingot"},
    {"", "default:glass", ""}
  }
})

minetest.register_craft({
  output = "lighting:walllamp",
  recipe = {
    {"dye:white", "default:glass", ""},
    {"default:glass", "default:torch", "default:steel_ingot"},
    {"", "dye:grey", "default:steel_ingot"}
  }
})

minetest.register_craft({
  output = "lighting:tablelamp_d",
  recipe = {
    {"wool:grey", "default:torch", "wool:grey"},
    {"", "default:steel_ingot", ""},
    {"", "default:steel_ingot", ""}
  }
})

minetest.register_craft({
  output = "lighting:tablelamp_l",
  recipe = {
    {"wool:white", "default:torch", "wool:white"},
    {"", "default:steel_ingot", ""},
    {"", "default:steel_ingot", ""}
  }
})

minetest.register_craft({
  output = "lighting:vintage_lantern_f",
  recipe = {
    {"", "default:steel_ingot", ""},
    {"default:glass", "default:torch", "default:glass"},
    {"default:stick", "default:steel_ingot", "default:stick"}
  }
})

minetest.register_craft({
	output = 'lighting:lantern 4',
	recipe = {
		{'group:stick','default:glass','group:stick'},
		{'default:glass','default:torch','default:glass'},
		{'group:stick','default:glass','group:stick'},
		}
})

minetest.register_craft({
	output = 'lighting:lamp 4',
	recipe = {
	{'default:glass','default:steel_ingot','default:glass'},
	{'default:steel_ingot','default:torch','default:steel_ingot'},
	{'default:glass','default:steel_ingot','default:glass'},
	}
})