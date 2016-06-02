if GetObjectName(myHero) ~= "Lucian" then return end
require "IPrediction"

local Combo = false
local target = nil
local myHitBox = GetHitBox(myHero)
local Passive = 0
local W = {range = 1000, speed = 1600 , width = 055, delay=0.30}

local MainMenu = MenuConfig("Lucian", "Lucian")

MainMenu:DropDown("C",1)




OnTick(function(myHero)
	if target ~= nil then
		if Combo then
			if MainMenu.C:Value() == 1 then
				if Ready(0) and ValidTarget(target,650) then
					CastTargetSpell(target, 0)
				end

				
			end

				
		else
			if Ready(0) and ValidTarget(target,650) then
					CastTargetSpell(target, 0)
				end
			if not Ready(0)and Ready(1) and ValidTarget(target, 1000) then
					local prediction = GetPrediction(target, W); 
				if prediction.hitChance > .65 and not prediction:mCollision(1) then 
						CastSkillShot(1, prediction.castPos) 
					end
				end
		     if not Ready(0) and not Ready(1) then
			 target = nil
		     end
		end
	end


	if target == nil then
		Combo = false
	end
end)

OnProcessSpellComplete(function(unit, spell)
	if unit == myHero and spell.name:lower():find("attack") then
		Combo = true
	end
end)

OnWndMsg(function(msg,wParam)
	if msg == 516 then
		for k, v in ipairs(GetEnemyHeroes()) do
			if GetDistance(GetMousePos(), v) < 100 then
				target = v
				if GetDistance(v) <= GetRange(myHero) then
					AttackUnit(v)
				end
			else
				if target ~= nil then
					target = nil
				end
			end
		end
	end

end)