
hgram = hgram or {}

SMODS.Atlas{
	key = "placeholder_joker",
	path = "placeholder.png",
	px = 71,
	py = 95
}
SMODS.Atlas{
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
}

-- minimal joker
SMODS.Joker{
	key = 'minimal',
	atlas = 'jokers',
	pos = {x=0,y=0},
	rarity = 1,
	cost = 3,
	config = {
		extra = {
			current_mult = 0,
			mult_gain = 1,
		},
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	loc_vars = function(self,info_queue,center)
		return {vars = {center.ability.extra.current_mult, center.ability.extra.mult_gain}}
	end,
	calculate = function(self,card,context)
		if context.before and not context.blueprint then
			local _all_clean = true
			for _,v in ipairs(context.full_hand) do
				if not (not next(SMODS.get_enhancements(v))
				   and not v.seal and not v.edition) then
					_all_clean = false
				end
			end
			if _all_clean then
				card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_gain
				return {message = localize("k_upgrade_ex"), colour = G.C.MULT}
			end
		elseif context.joker_main and card.ability.extra.current_mult > 0 then
			return {
				mult = card.ability.extra.current_mult
			}
		end
	end,
}

-- stonefruit
SMODS.Joker{
	key = 'stonefruit',
	atlas = 'jokers',
	pos = {x=1,y=0},
	rarity = 1,
	cost = 4,
	config = {
		extra = {
			chips = 150,
			chips_loss = 25
		},
	},
	eternal_compat = false,
	blueprint_compat = true,
	perishable_compat = true,
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return {vars = {center.ability.extra.chips, center.ability.extra.chips_loss}}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_stone') then
            return {
				chips = card.ability.extra.chips
			}
        end
		if context.discard and SMODS.has_enhancement(context.other_card, "m_stone") then
			if not context.blueprint then
				card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chips_loss
				if card.ability.extra.chips <= 0 then
					G.E_MANAGER.add_event(Event({func = function() hgram.destroy_food(card) end}))
					return {
						message = localize("hgram_crumbled_ex"),
						message_card = card,
						colour = G.C.CHIPS
					}
				else
					local the_message = " - "..card.ability.extra.chips_loss.." "
					return {
						--message = {type='variable',key='a_chips_minus',vars={card.ability.extra.chips_loss}},
						message = the_message,
						message_card = card,
						colour = G.C.CHIPS
					}
				end
			end
		end
	end,
	in_pool = function(self, args)
		local ever_a_rock = false
		for _,v in ipairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_stone") then ever_a_rock = true end
		end
		return ever_a_rock
	end
}

-- calligraphy
SMODS.Joker{
	key = 'calligraphy',
	atlas = "jokers",
	pos = {x=2,y=0},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	config = {
		extra = {
			aces_for_one = 5,
			aces_this_round = 0,
		},
	},
	loc_vars = function(self,info_queue,center)
		return {vars = {1.0 / center.ability.extra.aces_for_one, (center.ability.extra.aces_for_one + center.ability.extra.aces_this_round) / center.ability.extra.aces_for_one}}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and not context.blueprint then
			card.ability.extra.aces_this_round = 0
		end
		if not context.blueprint and context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then
				card.ability.extra.aces_this_round = card.ability.extra.aces_this_round + 1
			end
		end
		if context.joker_main and card.ability.extra.aces_this_round > 0 then
			return { x_chips = (card.ability.extra.aces_this_round + card.ability.extra.aces_for_one) / card.ability.extra.aces_for_one }
		end
	end,
}


-- puppet joker
SMODS.Joker{
	key = "puppet",
	pos = {x=3,y=0},
	atlas = "jokers",
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = true,
	config = {extra = {cash = 0, gain = 1}},
	loc_vars = function(self, infoqueue, card)
		return {vars = {card.ability.extra.cash, card.ability.extra.gain}}
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and not context.blueprint then
			local sum = 0
			for k, val in ipairs(context.removed) do
				sum = sum + 1 end
			card.ability.extra.cash = (sum * card.ability.extra.gain) + card.ability.extra.cash
		end
	end,
	calc_dollar_bonus = function(self, card)
		local amount = card.ability.extra.cash
		if amount > 0 then return amount end
	end,
}

-- joker expanse
SMODS.Joker{
	key = "expanse",
	pos = {x=4,y=0},
	atlas = "jokers",
	rarity = 1,
	cost = 5,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	config = {
		extra = {payout = 5}
	},
	loc_vars = function(self, infoqueue, card)
		return {vars = {card.ability.extra.payout, card.ability.extra.payout * hgram.empty_joker_slots()}}
	end,
	calc_dollar_bonus = function(self, card)
		local amount = card.ability.extra.payout * hgram.empty_joker_slots()
		if amount > 0 then return amount end
	end,
}

-- paper money
SMODS.Joker{
	key = "papermoney",
	atlas = "jokers",
	pos = {x=0,y=1},
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {extra = {money = 2}},
	enhancement_gate = "m_gold",
	loc_vars = function(self, infoqueue, card)
		infoqueue[#infoqueue + 1] = G.P_CENTERS["m_gold"]
		return {vars = {card.ability.extra.money}}
	end,
	calculate = function(self, card, context)
	
		-- count up how many gold cards there are
		if context.end_of_round and not card.ability.extra.gold_amount and not context.blueprint then
			card.ability.extra.gold_amount = 0
			for _,v in ipairs(G.hand.cards) do
				if SMODS.has_enhancement(v, "m_gold") then
					card.ability.extra.gold_amount = card.ability.extra.gold_amount + 1
				end
			end
		end
		
		-- make the paper cards give money
		if context.individual and context.end_of_round and context.cardarea == G.hand then
			if not SMODS.has_enhancement(context.other_card, "m_gold") and card.ability.extra.gold_amount > 0 then
				return {dollars = card.ability.extra.money * card.ability.extra.gold_amount}
			end
		end
		
		-- remove the old tally if it is an appropriate time
		if context.joker_main and card.ability.extra.gold_amount and not context.blueprint then
			card.ability.extra.gold_amount = nil
		end
		
	end
}

-- salt lamp
SMODS.Joker{
	key = "saltlamp",
	pos = {x=1,y=1},
	atlas = "jokers",
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {extra = {active = false}},
	loc_vars = function(self, infoqueue, card)
		-- maybe replace this with a neat UI element like Luchador?
		return { vars = {(card.ability.extra.active and localize("hgram_active")) or localize("hgram_inactive")} }
	end,
	calculate = function(self, card, context)
		if hgram.selling_other_joker(context) and not card.ability.extra.active then
			card.ability.extra.active = true
			return { message = localize("k_active_ex"), colour = G.C.GREEN }
		end
		if context.repetition and context.cardarea == G.play and card.ability.extra.active then
			return {repetitions = 1}
		end
		if context.end_of_round and card.ability.extra.active and not context.blueprint then
			card.ability.extra.active = false
		end
	end
}

