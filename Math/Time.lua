local FormatOrdinal = loadstring(game:HttpGet('https://raw.githubusercontent.com/moon-rblx/Utilities/refs/heads/main/String/FormatOrdinal.lua'))()

local MONTHS = {
	'January', 'February', 'March', 'April', 'May', 'June',
	'July', 'August', 'September', 'October', 'November', 'December'
}

local Time = {}

Time.secondsInDay = 86400
Time.secondsInHour = 3600
Time.secondsInMinute = 60

function Time.now()
	return workspace:GetServerTimeNow()
end

function Time.fromTable(tbl)
	return DateTime.fromUniversalTime(
		tbl.year, tbl.month or 1, tbl.day or 1,
		tbl.hour or 0, tbl.minute or 0, tbl.second or 0
	).UnixTimestamp
end

function Time.toTable(unix)
	local dt = DateTime.fromUnixTimestamp(unix):ToUniversalTime()
	return {
		year = dt.Year,
		month = dt.Month,
		day = dt.Day,
		hour = dt.Hour,
		minute = dt.Minute,
		second = dt.Second,
	}
end

function Time.formatDate(tbl)
	return string.format('%s %s, %d', MONTHS[tbl.month], FormatOrdinal(tbl.day), tbl.year)
end

function Time.format12HourTime(hour, minute)
	local suffix = 'AM'
	if hour >= 12 then suffix = 'PM' end
	if hour == 0 then hour = 12 elseif hour > 12 then hour -= 12 end
	return string.format('%d:%02d %s', hour, minute, suffix)
end

function Time.toLocalTime(unix)
	local dt = DateTime.fromUnixTimestamp(unix):ToLocalTime()
	return Time.format12HourTime(dt.Hour, dt.Minute)
end

function Time.untilMidnight()
	local now = Time.now()
	return (math.floor(now / 86400) + 1) * 86400 - now
end

function Time.formatTime(seconds, short)
	local days = math.floor(seconds / 86400)
	local hours = math.floor(seconds % 86400 / 3600)
	local minutes = math.floor(seconds % 3600 / 60)
	local secs = seconds % 60

	if days > 0 then
		if short then
			return string.format('%d %s', days, days == 1 and 'day' or 'days')
		else
			return string.format('%d %s, %d:%02d:%02d', days, days == 1 and 'day' or 'days', hours, minutes, secs)
		end
	elseif seconds >= 3600 then
		return string.format('%d:%02d:%02d', hours, minutes, secs)
	elseif seconds >= 60 then
		return string.format('%d:%02d', minutes, secs)
	else
		return string.format('%ds', secs)
	end
end

function Time.formatRealTime(seconds)
	local days = math.floor(seconds / 86400)
	local hours = math.floor(seconds % 86400 / 3600)
	local minutes = math.floor(seconds % 3600 / 60)
	local secs = math.floor(seconds) % 60

	if days > 0 then
		return string.format('%d %s', days, days == 1 and 'day' or 'days')
	elseif hours > 0 then
		return string.format('%d %s', hours, hours == 1 and 'hour' or 'hours')
	elseif minutes > 0 then
		return string.format('%d %s', minutes, minutes == 1 and 'minute' or 'minutes')
	else
		return string.format('%d %s', secs, secs == 1 and 'second' or 'seconds')
	end
end

return Time
