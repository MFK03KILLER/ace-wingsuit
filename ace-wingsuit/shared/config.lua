Config = {}

Config.CoreName = 'qb-core' --Core Name for GetCoreObject() of QBCore Framework
Config.FuelAmount = 400 --The amount of time By pressing "E" for Boosting The suit
Config.ItemName = "wing_suit" --You can add custom item as wingsuit (by defult you can add this to your Core/shared/items.lua : ["wing_suit"] 			  = {["name"] = "wing_suit", 			         ["label"] = "Wing Suit", 		 ["weight"] = 500, 		    ["type"] = "item", 		["image"] = "wingsuit.png", 			        	["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,   ["combinable"] = nil,   ["degrade"] = 25.0,  ["description"] = "Wing suit of bazlighter"},)
Config.OpenTime = 3000 --Time of Open Wingsuit when used in ms
Config.OpenLabel = 'Using Wingsuit..' --Progressbar Label of Opening Wingsuit
Config.CloseTime = 3000 --Time of Close Wingsuit when used in ms
Config.CloseLabel = 'Removing Wingsuit..' --Progressbar Label of Closing Wingsuit
Config.ProgressbarCancel = 'Canceled..'--Notify Error Text when Cancel Progressbar