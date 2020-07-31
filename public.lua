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

-- ARGS: addonname, timestamp, ...
function logError(msgAddonName, msgTimestamp, ...)
		local msgReadableTime = date(nil, msgTimestamp);

		-- concat all message arguments "..." into one string
		-- this is the best way that I have found, transform "..." into table and concat that table
		-- possible problem: if there is any nil argument inside "..." then all arguments after nil are omitted
		local msgContent = table.concat({...});
		local level = "error";

		print(NS.c[level], "[ERROR]", msgAddonName, "#", msgContent);
		table.insert(NS.log, { addon = msgAddonName, level = level, timestamp = msgTimestamp, date = msgReadableTime, content = msgContent});

		NS.updateBrokerAllCount();
		NS.updateBrokerErrorCount();
end

function logWarning(msgAddonName, msgTimestamp, ...)
		local msgReadableTime = date(nil, msgTimestamp);
		local msgContent = table.concat({...});
		local level = "warning";

		print(NS.c[level], "[WARNING]", msgAddonName, "#", msgContent);
		table.insert(NS.log, { addon = msgAddonName, level = level, timestamp = msgTimestamp, date = msgReadableTime, content = msgContent});

		NS.updateBrokerAllCount();
		NS.updateBrokerWarningCount();
end

function logInfo(msgAddonName, msgTimestamp, ...)
		local msgReadableTime = date(nil, msgTimestamp);
		local msgContent = table.concat({...});
		local level = "info";

		print(NS.c[level], "[INFO]", msgAddonName, "#", msgContent);
		table.insert(NS.log, { addon = msgAddonName, level = level, timestamp = msgTimestamp, date = msgReadableTime, content = msgContent});

		NS.updateBrokerAllCount();
		NS.updateBrokerInfoCount();
end

function logDebug(msgAddonName, msgTimestamp, ...)
		local msgReadableTime = date(nil, msgTimestamp);
		local msgContent = table.concat({...});
		local level = "debug";

		print(NS.c[level], "[DEBUG]", msgAddonName, "#", msgContent);
		table.insert(NS.log, { addon = msgAddonName, level = level, timestamp = msgTimestamp, date = msgReadableTime, content = msgContent});

		NS.updateBrokerAllCount();
		NS.updateBrokerDebugCount();
end
