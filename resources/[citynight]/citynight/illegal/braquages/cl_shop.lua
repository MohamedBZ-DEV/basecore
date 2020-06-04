currentApuBraquable = nil





-- HOLD UP STUFF (APU)
local SceneEntities = {}
local firstStageCompleted = false
local animData = {}
local lastReward = false
local robberyStartTime = false
local robberyTime = 5000
local alarmID

local function AbortRobbery(apuEntity)
	RemoveAnimDict("mp_am_hold_up")
	SetModelAsNoLongerNeeded("p_till_01_s")
	SetModelAsNoLongerNeeded("p_poly_bag_01_s")
	ReleaseScriptAudioBank("Alarms")

	for k,v in pairs(SceneEntities) do DeleteEntity(v) end
	SceneEntities = {}

	if alarmID then StopSound(alarmID) alarmID = false end

	ClearPedTasks(apuEntity)
	FreezeEntityPosition(apuEntity, false)

	local NPCPos = GetEntityCoords(apuEntity) - vector3(0.0, 0.0, 1.0)
	TaskGoStraightToCoord(apuEntity, NPCPos.x, NPCPos.y, NPCPos.z, 1.0, -1, GetEntityHeading(apuEntity) or 0.0, 0.1)

	while not IsEntityAtCoord(apuEntity, NPCPos.x, NPCPos.y, NPCPos.z, 0.5, 0.5, 0.5, 0, 1, 0) do Citizen.Wait(100) end

	FreezeEntityPosition(apuEntity, true)
	ClearPedTasks(apuEntity)

	firstStageCompleted = false
	lastReward = false
	startRobbery = false
	animData = {}
end
function TaskSynchronizedTasks(ped, animData, clearTasks)
	for _,v in pairs(animData) do
		if not HasAnimDictLoaded(v.anim[1]) then
			RequestAnimDict(v.anim[1])
			while not HasAnimDictLoaded(v.anim[1]) do Citizen.Wait(0) end
		end
	end

	local _, sequence = OpenSequenceTask(0)
	for _,v in pairs(animData) do
		TaskPlayAnim(0, v.anim[1], v.anim[2], 2.0, -2.0, math.floor(v.time or -1), v.flag or 48, 0, 0, 0, 0)
	end

	CloseSequenceTask(sequence)
	if clearTasks then ClearPedTasks(ped) end
	TaskPerformSequence(ped, sequence)
	ClearSequenceTask(sequence)

	for _,v in pairs(animData) do
		RemoveAnimDict(v.anim[1])
	end
end
local anyThread = false
local function DoGiveMoneyAnim(apuEntity)
	RequestAndWaitModel("bkr_prop_money_wrapped_01")

	local localEntity, netScene = NetworkGetEntityIsLocal(apuEntity)
	local b = CreateObjectNoOffset(GetHashKey("bkr_prop_money_wrapped_01"), GetEntityCoords(apuEntity), not localEntity, not localEntity, 0)

	if localEntity then
		netScene = CreateSynchronizedScene(animData.pos, .0, .0, animData.a, 2, 1, 0, 1065353216, 0, 1065353216)
		TaskSynchronizedScene(apuEntity, netScene, "mp_am_hold_up", "purchase_chocbar_shopkeeper", 1.5, -1.5, 0, 0, 1148846080, 0)
		PlaySynchronizedEntityAnim(apuEntity, netScene, "mp_am_hold_up", "purchase_chocbar_shopkeeper", 8.0, -1.5, 157, 16, 1148846080, 0)
		PlaySynchronizedEntityAnim(b, netScene, "purchase_chocbar", "mp_am_hold_up", 1000.0, 8.0, 1, 1148846080)
	else
		netScene = NetworkCreateSynchronisedScene(animData.pos, .0, .0, animData.a, 2, 1, 0, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(apuEntity, netScene, "mp_am_hold_up", "purchase_chocbar_shopkeeper", 8.0, -1.5, 157, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(b, netScene, "mp_am_hold_up", "purchase_chocbar", 4.0, -4.0, 137)
		NetworkStartSynchronisedScene(netScene)
	end

	SetModelAsNoLongerNeeded(GetHashKey("bkr_prop_money_wrapped_01"))

	Citizen.Wait(0)
	PlayAmbientSpeechWithVoice(apuEntity, "APOLOGY_NO_TROUBLE", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)

	local scene = localEntity and netScene or NetworkConvertSynchronisedSceneToSynchronizedScene(netScene)
	while GetSynchronizedScenePhase(scene) <= 0.9 and not IsEntityDead(apuEntity) and anyThread do
		Citizen.Wait(0)
	end

	local pPos, rot = GetEntityCoords(b), GetEntityRotation(b, 2)
	DeleteEntity(b)

	if anyThread and not IsEntityDead(apuEntity) then
	--	TriggerServerEvent("pichot:startRobbery", 2, shop.id, { 2, { x = pPos.x, y = pPos.y, z = pPos.z, rot = { x = rot.x, y = rot.y, z = rot.z } } })
	end

	TaskSynchronizedTasks(apuEntity, {
		{ anim = { "mp_am_hold_up", "handsup_enter" }, flag = 0 },
		{ anim = { "mp_am_hold_up", "handsup_base" }, flag = 1 },
	})
end

local function CreateRobberyThread(apuEntity)
	if anyThread then return end

	anyThread = true
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			local Player = LocalPlayer()
			local ped, plyPos, interiorID = Player.Ped, Player.Pos, Player.InteriorID

			if interiorID == 0 or GetDistanceBetweenCoords(plyPos, GetEntityCoords(apuEntity)) > 20 or robberyStartTime + robberyTime <= GetGameTimer() then
				local endTime = robberyStartTime + robberyTime > GetGameTimer()
				drawCenterText(endTime and "Vous avez complètement vidé le magasin fuyez!" or "Vous avez dégagé du magasin.", 3000)
				break
			end

			if firstStageCompleted then
				-- do some stuff
				if (not lastReward or lastReward + 10000 < GetGameTimer()) and IsPedArmed(ped, 7) then
					TaskSynchronizedTasks(apuEntity, { { anim = { "mp_am_hold_up", "handsup_exit" }, flag = 0 }})
					lastReward = GetGameTimer()
					Citizen.Wait(600)
					DoGiveMoneyAnim(apuEntity)
				end
			end
		end

		anyThread = false
		AbortRobbery(apuEntity)
	end)
end

function RequestAndWaitModel(modelName)
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

function RequestAndWaitDict(dictName)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end
function drawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

-- TODO APU NE SE REMET PAS TOUT LE TEMPS BIEN
local function startRobberyFunc(apuEntity)
	RequestAndWaitDict("mp_am_hold_up")
	RequestAndWaitModel("p_till_01_s")
	RequestScriptAudioBank("Alarms")
	RequestAndWaitModel("p_poly_bag_01_s")
	TaskClearLookAt(apuEntity)

	local localEntity, netScene = NetworkGetEntityIsLocal(apuEntity)

	local apuPosition, closestOBJ = GetEntityCoords(apuEntity)
	alarmID = GetSoundId()
	PlaySoundFromCoord(alarmID, "Burglar_Bell", apuPosition, "Generic_Alarms", 0, 0, 0)

	robberyStartTime = GetGameTimer()

	closestOBJ = GetClosestObjectOfType(apuPosition.x, apuPosition.y, apuPosition.z, 2.0, GetHashKey("prop_till_01"), 0, 0, 0)

	if not closestOBJ or not DoesEntityExist(closestOBJ) or IsEntityDead(closestOBJ) then return AbortRobbery(apuEntity, shop) end

	for k,v in pairs({"prop_till_01", "prop_till_02"}) do
		CreateModelHide(apuPosition, 2.0, GetHashKey(v), 1)
	end

	local tillPos, tillHeading = GetEntityCoords(closestOBJ), GetEntityHeading(closestOBJ)
	tillPos = tillPos - vector3(0.0, 0.0, 0.125)

	animData = { pos = tillPos, a = tillHeading - 180.0 }

	local till = CreateObject(GetHashKey("p_till_01_s"), tillPos, not localEntity, not localEntity, true)
	SetEntityHeading(till, tillHeading)
	FreezeEntityPosition(till, true)

	local pickup = CreateObject(GetHashKey("p_poly_bag_01_s"), tillPos, not localEntity, not localEntity, true)
	SetEntityRotation(pickup, 5.0, .0, tillHeading, 2, 1)
	SetEntityVisible(pickup, false, false)

	if localEntity then
		netScene = CreateSynchronizedScene(animData.pos, .0, .0, animData.a, 2)
		TaskSynchronizedScene(apuEntity, netScene, "mp_am_hold_up", "holdup_victim_20s", 4.0, -1.5, 157, 16, 1148846080, 0)
		SetEntityCollision(pickup, true, 0)
		SetEntityDynamic(pickup, true)
		PlaySynchronizedEntityAnim(pickup, netScene, "holdup_victim_20s_bag", "mp_am_hold_up", 1000.0, 8.0, 137, 1148846080)
		PlaySynchronizedEntityAnim(till, netScene, "holdup_victim_20s_till", "mp_am_hold_up", 1000.0, 8.0, 137, 1148846080)
	else
		netScene = NetworkCreateSynchronisedScene(animData.pos, .0, .0, animData.a, 2, true, 0, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(apuEntity, netScene, "mp_am_hold_up", "holdup_victim_20s", 4.0, -1.5, 157, 16, 1148846080, 0)
		SetEntityCollision(pickup, true, 0)
		SetEntityDynamic(pickup, true)
		NetworkAddEntityToSynchronisedScene(pickup, netScene, "mp_am_hold_up", "holdup_victim_20s_bag", 4.0, -4.0, 137)
		NetworkAddEntityToSynchronisedScene(till, netScene, "mp_am_hold_up", "holdup_victim_20s_till", 4.0, -4.0, 137)
		NetworkStartSynchronisedScene(netScene)
	end

	PlayAmbientSpeechWithVoice(apuEntity, "APOLOGY_NO_TROUBLE", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)

	CreateRobberyThread(apuEntity)

	local scene = not localEntity and NetworkConvertSynchronisedSceneToSynchronizedScene(netScene) or netScene

	while GetSynchronizedScenePhase(scene) <= 0.478 and not IsEntityDead(apuEntity) and anyThread do
		Citizen.Wait(0)
	end

	if IsEntityDead(apuEntity) or LocalPlayer().Dead then AbortRobbery(apuEntity) return end

	StopCurrentPlayingAmbientSpeech(apuEntity)
	PlayAmbientSpeechWithVoice(apuEntity, "SHOP_HURRYING", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)

	SetEntityVisible(pickup, true, 0)
	ActivatePhysics(pickup)

	while GetSynchronizedScenePhase(scene) <= .9 and not IsEntityDead(apuEntity) and anyThread do
		Citizen.Wait(0)
	end

	for k,v in pairs({"prop_till_01", "prop_till_02"}) do
		RemoveModelHide(apuPosition, 4.0, GetHashKey(v), true)
	end

	SetEntityAsNoLongerNeeded(till)
	DeleteEntity(till)

	if IsEntityDead(apuEntity) or LocalPlayer().Dead then AbortRobbery(apuEntity) return end

	if not IsEntityDead(apuEntity) and not LocalPlayer().Dead and IsEntityAtEntity(LocalPlayer().Ped, apuEntity, 8.0, 8.0, 4.0, 0, 1, 0) and anyThread and GetSynchronizedScenePhase(scene) > 0.9 then
		local pPos, rot = GetEntityCoords(pickup), GetEntityRotation(pickup, 2)
	--	TriggerServerEvent("pichot:startRobbery", 2, shop.id, { 1, { x = pPos.x, y = pPos.y, z = pPos.z, rot = { x = rot.x, y = rot.y, z = rot.z } } })
		DeleteEntity(pickup)
		drawCenterText("~g~Vous pouvez récupérer le butin.", 2000)

		if not localEntity then
			NetworkStopSynchronisedScene(netScene)
		end
	end

	TaskSynchronizedTasks(apuEntity, {
		{ anim = { "mp_am_hold_up", "handsup_enter" }, flag = 0 },
		{ anim = { "mp_am_hold_up", "handsup_base" }, flag = 1 },
	})

	drawCenterText("Criez et continuez de menacer Apu pour récupérer plus de cash.", 10000)
	firstStageCompleted = true
    lastReward = GetGameTimer() - 5000
    
	--AbortRobbery(apuEntity)
end


function StartBraquo()
    startRobberyFunc(currentApuBraquable)

end