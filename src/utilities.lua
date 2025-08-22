
hgram = hgram or {}

-- handy functions
hgram.empty_joker_slots = function()
	if G.jokers then
		return G.jokers.config.card_limit - #G.jokers.cards
	else
		return 0
	end
end

hgram.favoured_suit = function()
	if G.deck and G.deck.cards then
		local suit_amounts = {}
		for _,v in ipairs(G.playing_cards) do
			suit_amounts[v.base.suit] = (suit_amounts[v.base.suit] or 0) + 1
		end
		local highest = 0
		for _,v in pairs(suit_amounts) do
			if v > highest then highest = v end
		end
		for k,v in pairs(suit_amounts) do
			if v == highest then return k end
		end
	else
		return "None"
	end
end

-- food destruction effect taken from https://github.com/nh6574/VanillaRemade
hgram.destroy_food = function(food)
	G.E_MANAGER:add_event(Event({
		func = function()
			play_sound('tarot1')
			food.T.r = -0.2
			food:juice_up(0.3, 0.4)
			food.states.drag.is = true
			food.children.center.pinch.x = true
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.3,
				blockable = false,
				func = function()
					food:remove()
					return true
				end
			}))
			return true
		end
	}))
end

