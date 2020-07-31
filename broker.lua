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

local dataobj;


--[[
	brokers = {all, debug, info, warning, error}
--]]
local brokers = {};

-- updateBroker* functions must not crash even when there is no broker library loaded, do nothing but never crash
-- we must declare them before detection of libraries (that might failed when there are no libraries found)
function NS.updateBrokerAllCount()
	if brokers == nil or brokers.all == nil then
		return;
	end

	brokers.all.text = #NS.log;
end

function NS.updateBrokerErrorCount()
	if brokers == nil or brokers.error == nil then
		return;
	end

	local count = 0;

	for _,v in ipairs(NS.log) do
		if v.level == "error" then
			count = count + 1;
		end
	end

	brokers.error.text = count;
end

function NS.updateBrokerWarningCount()
	if brokers == nil or brokers.warning == nil then
		return;
	end

	local count = 0;

	for _,v in ipairs(NS.log) do
		if v.level == "warning" then
			count = count + 1;
		end
	end

	brokers.warning.text = count;
end

function NS.updateBrokerInfoCount()
	if brokers == nil or brokers.info == nil then
		return;
	end

	local count = 0;

	for _,v in ipairs(NS.log) do
		if v.level == "info" then
			count = count + 1;
		end
	end

	brokers.info.text = count;
end

function NS.updateBrokerDebugCount()
	if brokers == nil or brokers.debug == nil then
		return;
	end

	local count = 0;

	for _,v in ipairs(NS.log) do
		if v.level == "debug" then
			count = count + 1;
		end
	end

	brokers.debug.text = count;
end

-- update text for all brokers
function NS.updateBrokers()
	NS.updateBrokerAllCount();
	NS.updateBrokerErrorCount();
	NS.updateBrokerWarningCount();
	NS.updateBrokerInfoCount();
	NS.updateBrokerDebugCount();
end


-- Detection of libraries
if LibStub == nil then
	print(addonName, "ERROR: LibStub not found.");
	return;
end

local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true);
if ldb == nil then
	print(addonName, "ERROR: LibDataBroker not found.");
	return;
end


-- Declaring data brokers
-- LibDataBroker documentation: https://github.com/tekkub/libdatabroker-1-1/wiki/How-to-provide-a-dataobject
-- List of WOW UI icons: https://github.com/Gethe/wow-ui-textures/tree/live/ICONS

brokers.all = ldb:NewDataObject(addonName.."-all", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Feather_06",
});


function brokers.all:OnTooltipShow()
	self:AddLine(addonName.." v"..GetAddOnMetadata(addonName, "version"));
	self:AddLine(" ");

	for _, msg in ipairs(NS.log) do
		self:AddLine(NS.c[msg.level]..msg.addon .. " # " .. msg.content);
	end
end


brokers.error = ldb:NewDataObject(addonName.."-error", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Feather_07",
});

function brokers.error:OnTooltipShow()
	self:AddLine(addonName.." v"..GetAddOnMetadata(addonName, "version").." errors");
	self:AddLine(" ");

	for _, msg in ipairs(NS.log) do
		if msg.level == "error" then
			self:AddLine(NS.c[msg.level]..msg.addon .. " # " .. msg.content);
		end
	end
end


brokers.warning = ldb:NewDataObject(addonName.."-warning", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Feather_10",
});

function brokers.warning:OnTooltipShow()
	self:AddLine(addonName.." v"..GetAddOnMetadata(addonName, "version").." warnings");
	self:AddLine(" ");

	for _, msg in ipairs(NS.log) do
		if msg.level == "warning" then
			self:AddLine(NS.c[msg.level]..msg.addon .. " # " .. msg.content);
		end
	end
end

brokers.info = ldb:NewDataObject(addonName.."-info", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Feather_11",
});

function brokers.info:OnTooltipShow()
	self:AddLine(addonName.." v"..GetAddOnMetadata(addonName, "version").." infos");
	self:AddLine(" ");

	for _, msg in ipairs(NS.log) do
		if msg.level == "info" then
			self:AddLine(NS.c[msg.level]..msg.addon .. " # " .. msg.content);
		end
	end
end

brokers.debug = ldb:NewDataObject(addonName.."-debug", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Feather_05",
});

function brokers.debug:OnTooltipShow()
	self:AddLine(addonName.." v"..GetAddOnMetadata(addonName, "version").." debugs");
	self:AddLine(" ");

	for _, msg in ipairs(NS.log) do
		if msg.level == "debug" then
			self:AddLine(NS.c[msg.level]..msg.addon .. " # " .. msg.content);
		end
	end
end
