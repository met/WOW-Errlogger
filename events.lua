--[[
Copyright (c) 2020 Martin Hassman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

local addonName, NS = ...;

local frame = CreateFrame("FRAME");
local events = {};


local function setDefaultSettings(setts)
	setts.debug = false;
end

function events.ADDON_LOADED(...)
	local arg1 = select(1, ...);

	--ADDON_LOADED event is raised for every running addon,
	-- 1st argument contains that addon name
	-- we response only for our addon call and ignore the others
	if arg1 ~= addonName then
		return;
	end

	print(NS.msgPrefix.."version "..GetAddOnMetadata(addonName, "version")..". Use "..NS.mainCmd.." for help");

	--initialize persistent variables if empty
	if ErrlogSharedData == nil then
		ErrlogSharedData = {};
	end

	if ErrlogSettings == nil then
		ErrlogSettings = {};
		setDefaultSettings(ErrlogSettings);
	end

	if ErrlogData == nil then
		ErrlogData = {};
	end

	--make addon persistent data available over all addon files
	NS.sharedData = ErrlogSharedData;
	NS.settings = ErrlogSettings;
	NS.data = ErrlogData;

	NS.updateBrokers();
end


-- Call event handlers or log error for unknow events
function frame:OnEvent(event, ...)
	if events[event] ~= nil then
		events[event](...);
	else
		logError(addonName, time(), "Received unhandled event:", event, ...);
	end
end


frame:RegisterEvent("ADDON_LOADED");

frame:SetScript("OnEvent", frame.OnEvent);
