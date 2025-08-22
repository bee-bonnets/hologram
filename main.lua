
--- mod icon
SMODS.Atlas{
	key = "modicon",
	path = "hologram_icon.png",
	px = "34",
	py = "34",
}

hgram = hgram or {}
hgram.modules = {}

-- stuff that is needed but doesn't actually do anything yet...
assert(SMODS.load_file("src/utilities.lua"))()

-- load the content of the mod
assert(SMODS.load_file("src/jokers.lua"))()
--assert(SMODS.load_file("src/blinds.lua"))()
--assert(SMODS.load_file("src/merchant.lua"))()