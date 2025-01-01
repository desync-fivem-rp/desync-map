posX = 0.03
posY = -0.04-- 0.0152

width = 0.13
height = 0.2--0.354

Citizen.CreateThread(function()
	RequestStreamedTextureDict("circlemap", false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

	SetMinimapClipType(1)
	SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY, width, height)
	--SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.0, 0.032, 0.101, 0.259)
	SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX, posY, width, height)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.0005, 0.001, 0.256, 0.337)
	-- SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.012, 0.022, 0.256, 0.337)
	

    local minimap = RequestScaleformMovie("minimap")
	-- SetMinimapOverlayDisplay(minimap, 10, 10, 100, 100, 100)
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

--[[Citizen.CreateThread(function()
	while true do
		Wait(0)

		SetScriptGfxAlign(string.byte('L'), string.byte('B'))
		DrawRect(posX + (width / 2), posY + (height / 2), width, height, 0, 0, 0, 50)
		ResetScriptGfxAlign()
	end
end)]]

local uiHidden = false

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsBigmapActive() then
			if not uiHidden then
				SendNUIMessage({
					action = "hideUI"
				})
				uiHidden = true
			end
		elseif uiHidden then
			SendNUIMessage({
				action = "displayUI"
			})
			uiHidden = false
		end
	end
end)
