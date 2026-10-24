--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- آدرس وب‌هوک Svix (برای تست)
local webhookUrl = "https://play.svix.com/in/eRfGpewisQfE2kPhbmi2wS2FkdN/"

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local username = player.Name
local placeId = game.PlaceId
local gameInfo = MarketplaceService:GetProductInfo(placeId, Enum.InfoType.Asset)
local gameName = gameInfo.Name or "Unknown Game"

local screenGui = script.Parent
local scriptName = "Unknown Script"
if screenGui:IsA("ScreenGui") then
	scriptName = screenGui.Name
end

local message = "@" .. username .. " 				is using the script:	" .. scriptName .. " 				in 	" .. gameName

local function sendWebhook()
	local http = http_request or request or syn.request or http.request or function(data)
		return HttpService:PostAsync(data.Url, data.Body, Enum.HttpContentType.ApplicationJson)
	end

	local success, err = pcall(function()
		http({
			Url = webhookUrl,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode({
				content = message
			})
		})
	end)

	if success then
		print("Webhook sent automatically for " .. username .. " (" .. scriptName .. ") in " .. gameName)
	else
		warn("Failed to send webhook: " .. tostring(err))
	end
end

sendWebhook()

print("Script fully executed by " .. username .. " (" .. scriptName .. ") in " .. gameName)
