-- See the README for information

function csv2terrain ()

	for line in io.lines(minetest.get_modpath("csv2terrain").."/blocks.csv")  do
		local x, y, z, block = line:match("%s*(.-),%s*(.-),%s*(.-),%s*(.-),")
		if block=="min" then
			x0, y0, z0 = tonumber(x), tonumber(y), tonumber(z)
    	end
    	if block=="max" then
       		 x1, y1, z1 = tonumber(x), tonumber(y), tonumber(z)
   		end
  	end

	local pos1 = {x = x0, y = y0, z = z0}
	local pos2 = {x = x1, y = y1, z = z1}

	local manip = minetest.get_voxel_manip()
	local edge0, edge1 = manip:read_from_map(pos1, pos2)
 	local area = VoxelArea:new{MinEdge=edge0, MaxEdge=edge1}
  	local data = manip:get_data()

  	for line in io.lines(minetest.get_modpath("csv2terrain").."/blocks.csv")  do
    	local x, y, z, block = line:match("%s*(.-),%s*(.-),%s*(.-),%s*(.-),")
	z = z1 - z + z0
        local j = area:index(tonumber(x), tonumber(y), tonumber(z))
   		if block~="min" and block~="max" and block~="player" then
			if block=="air" then
				data[j] = minetest.get_content_id (block)
			elseif block=="stair_wood" or block=="stair_junglewood" or block=="stair_stone" or block=="stair_cobble" or block=="stair_stonebrick" or block=="stair_sandstone" or block=="stair_brick" or block=="slab_wood" or block=="slab_junglewood" or block=="slab_stone" or block=="slab_cobble" or block=="slab_stonebrick" or block=="slab_brick" or block=="slab_sandstone" then
				data[j] = minetest.get_content_id ("stairs:"..block)
			elseif block=="white" or block=="grey" or block=="dark_grey" or block=="black" or block=="blue" or block=="cyan" or block=="green" or block=="dark_green" or block=="yellow" or block=="orange" or block=="brown" or block=="red" or block=="pink" or block=="magenta" or block=="violet" then
				data[j] = minetest.get_content_id ("wool:"..block)
			else
				data[j] = minetest.get_content_id ("default:"..block)
			end
		end
 	 end
  
 	manip:set_data(data)
 	manip:write_to_map()
	manip:update_map()
	
	local player = minetest.get_player_by_name("singleplayer")
	playername = player.get_player_name(player)
	local privs = minetest.get_player_privs(playername)
	privs.fly = true
	minetest.set_player_privs(playername, privs)
	for line in io.lines(minetest.get_modpath("csv2terrain").."/blocks.csv")  do
		local x, y, z, block = line:match("%s*(.-),%s*(.-),%s*(.-),%s*(.-),")
		z = z1 - z + z0
		if block=="player" then
			xp, yp, zp = tonumber(x), tonumber(y), tonumber(z)
			player:set_pos( {x=xp, y=yp, z=zp} )
		end
  	end     
  
end

function csv2air ()

	for line in io.lines(minetest.get_modpath("csv2terrain").."/blocks.csv")  do
		local x, y, z, block = line:match("%s*(.-),%s*(.-),%s*(.-),%s*(.-),")
		if block=="min" then
			x0, y0, z0 = tonumber(x), tonumber(y), tonumber(z)
    	end
    	if block=="max" then
       		 x1, y1, z1 = tonumber(x), tonumber(y), tonumber(z)
   		end
  	end

	local pos1 = {x = x0, y = y0, z = z0}
	local pos2 = {x = x1, y = y1, z = z1}

	local manip = minetest.get_voxel_manip()
	local edge0, edge1 = manip:read_from_map(pos1, pos2)
 	local area = VoxelArea:new{MinEdge=edge0, MaxEdge=edge1}
  	local data = manip:get_data()

    for x = x0, x1 do
        for y = y0, y1+(y1-y0)/2 do
            for z = z0, z1 do
                local j = area:index(tonumber(x), tonumber(y), tonumber(z))
                data[j] = minetest.get_content_id ("air")
            end
        end
    end
  
 	manip:set_data(data)
 	manip:write_to_map()
	manip:update_map()
	
	local player = minetest.get_player_by_name("singleplayer")
	playername = player.get_player_name(player)
	local privs = minetest.get_player_privs(playername)
	privs.fly = true
	minetest.set_player_privs(playername, privs)
	for line in io.lines(minetest.get_modpath("csv2terrain").."/blocks.csv")  do
		local x, y, z, block = line:match("%s*(.-),%s*(.-),%s*(.-),%s*(.-),")
		z = z1 - z + z0
		if block=="player" then
			xp, yp, zp = tonumber(x), tonumber(y), tonumber(z)
			player:set_pos( {x=xp, y=yp, z=zp} )
		end
  	end     
  
end


minetest.register_chatcommand("ltbv", {
    func = csv2air,
    func = csv2terrain,
})

minetest.register_chatcommand("ltba", {
    func = csv2air,
})

minetest.clear_registered_biomes() 
