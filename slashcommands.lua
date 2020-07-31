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


SLASH_ERLOG1 = "/erlog";
SLASH_ERLOG2 = "/errorlog";
SLASH_ERLOG3 = "/errorlogger";
SlashCmdList["ERLOG"] = function(msg)
	if msg == "" or msg =="help" then
		NS.printUsage();

	-- sent some test messages for easy debugging
	elseif msg == "test" then
		logError("Myaddon", time(), "Some error message.");
		logError("Myaddon", time(), "Other error message.", " With ", 5, " parameters", ".");
		logWarning("Myaddon2", time(), "Some warning message.");
		logInfo("Myaddon3", time(), "Some info message.");
		logDebug("Myaddon4", time(), "Some debug message.");

	elseif msg == "clear" then
		NS.log = {};
		NS.updateBrokers();
	else
		print("Unknown parameter.");
	end
end

NS.mainCmd = SLASH_ERLOG1;

function NS.printUsage()
		print(NS.c.Yellow, addonName, "usage:");
		print(NS.c.Yellow, NS.mainCmd, "help -- this message");
		print(NS.c.Yellow, NS.mainCmd, "clear -- delete all messages in log");
		print(NS.c.Yellow, NS.mainCmd, "test -- create some test log messages");
end