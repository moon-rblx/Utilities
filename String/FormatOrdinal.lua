local OrdinalSuffixes = {
    [0] = 'th',
    [1] = 'st',
    [2] = 'nd',
    [3] = 'rd'
}

local function FormatOrdinal(number)
    local lastDigit = number % 10
    local lastTwoDigits = number % 100

    if lastTwoDigits > 10 and lastTwoDigits < 14 then
        return number .. 'th'
    else
        return number .. (OrdinalSuffixes[lastDigit] or OrdinalSuffixes[0])
    end
end

return FormatOrdinal
