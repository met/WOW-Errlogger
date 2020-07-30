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
	end
end

NS.mainCmd = SLASH_ERLOG1;

function NS.printUsage()
		print(NS.c.Yellow, addonName, "usage:");
		print(NS.c.Yellow, NS.mainCmd, "help -- this message");
		--print(cYellow, NS.mainCmd, "debug -- set debug on");
		--print(cYellow, NS.mainCmd, "/diy nodebug -- set debug off");
		--print(cYellow, NS.mainCmd, "debug? -- show current debug state");
end