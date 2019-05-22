## csv2terrain

This is a mod for [Minetest](https://github.com/minetest/). It has been designed to be used in conjunction with the `default` mod of the Minetest game. Details on how to install a Minetest mod are [here](https://dev.minetest.net/Installing_Mods).

This mod reads in data from 'blocks.csv', a user provided csv file which should have lines of the form

`x,y,z,keyword,`

Where `x`, `y` and `z` are numbers. 

If the keyword is *player*, the position (x,y,z) is used as the spawn point of the player whenever a new game is started or a file is openened

The keywords can also be names of blocks. The following are known to work (in conjunction with the default mod).

```
dirt_with_grass, sand, stone, 
water_source, lava_source, 
tree, leaves, torch, 
diamondblock, goldblock, stone_with_coal, stone_with_iron, stone_with_copper, stone_with_tin, stone_with_gold, stone_with_diamond
fern_1, fern_2, fern_3, marram_grass_1, marram_grass_2, marram_grass_3
```

The mod adds these blocks to their specified positions whenenever the command `/ltbv` is invoked. This stands for 'Let there be voxels!', to allow the player their moment of creation.

If there are weird gaps in terrain generated in this way, simply try invoking the command again to patch it up. If there are weird dark patches, it seems best to just try again with a new world.

Note that keywords *min* and *max* also need to be present in the csv. The coordinates for these define the volume in which all the blocks reside.

A csv generator is included within the mod, generates terrain using [Qiskit](https://qiskit.org). It needs to be run separately from the game, and runs using Python 3. Simply run the file 'island_generator.py' using a command such as

```
python3 island_generator.py
```
