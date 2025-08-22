return {
	descriptions = {
		Joker = {
			j_hgram_expanse = {
				name = "Joker Expanse",
				text = {
					"After each round,",
					"earn {C:money}$#1#{} for each",
					"empty joker slot",
					"{C:inactive}(Currently {C:money}$#2#{C:inactive}){}"
				},
			},
			j_hgram_puppet = {
				name = "Puppet Joker",
				text = {
					"Earn {C:money}$#1#{} at end of",
					"round, increases by {C:money}$#2#{}",
					"when a card is destroyed"
				}
			},
			j_hgram_stonefruit = {
				name = "Stonefruit",
				text = {
					"Scored {C:attention}Stone{} cards",
					"additionally give {C:chips}+#1#{}",
					"Chips, decreases by {C:chips}+#2#{}",
					"when one is {C:attention}discarded{}"
				}
			},
			j_hgram_minimal = {
				name = "Minimal Joker",
				text = {
					"Gains {C:mult}+#1#{} Mult if played",
					"hand contains no {C:attention}Enhancements{},",
					"{attention}Seals{}, or {C:attention}Editions{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}"
				}
			},
			j_hgram_calligraphy = {
				name = 'Calligraphy',
				text = {
					'{X:chips,C:white}X#1#{} Chips for each',
					'{C:attention}Ace{} scored this round',
					'{C:inactive}(Currently {X:chips,C:white}X#2#{}{C:inactive}){}',
				},
			},
			j_hgram_papermoney = {
				name = "Paper Money",
				text = {
					"Non-{C:attention}Gold{} cards give {C:money}$#1#{}",
					"at the end of the round for",
					"each {C:attention}Gold{} card in hand"
				}
			},
			j_hgram_saltlamp = {
				name = "Salt Lamp",
				text = {
					"{C:attention}Retrigger{} all played",
					"cards if a joker has",
					"been {C:attention}sold{} this round",
					"{C:inactive}(#1#){}"
				}
			},
			j_hgram_freighttrain = {
				name = "Freight Train",
				text = {
					"When {C:attention}blind{} is selected",
					"add an {C:attention}Ace{} and numbered",
					"card of your most numerous",
					"{C:attention}suit{} to your deck",
					"{C:inactive}(Currently {V:1}#1#{C:inactive}){}"
				}
			},
			j_hgram_zone = {
				name = "Joker Zone",
				text = {
					"For every {C:attention}#1# {C:inactive}[#2#]{}",
					"{C:blue}Common{} jokers {C:attention}sold{}",
					"create a {C:dark_edition}Negative{}",
					"{C:blue}Common{} joker"
				}
			},
		},
	},
	misc = {
		dictionary = {
			hgram_crumbled_ex = "Crumbled!",
			hgram_active = "Active",
			hgram_inactive = "Inactive",
			hgram_freight_ex = "Freight!",
			hgram_no_suit_found = "None",
		}
	}
}