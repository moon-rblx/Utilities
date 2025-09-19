local DeepCopy = loadstring(game:HttpGet('https://raw.githubusercontent.com/moon-rblx/Utilities/refs/heads/main/Table/DeepCopy.lua'))()

local function DeepSearch(tbl, item, path)
    local copy = DeepCopy(tbl)
    path = path or {}

    for key, value in copy do
        local newPath = DeepCopy(path)
        table.insert(newPath, key)

        if value == item then
            return true, newPath
        end

        if typeof(value) == 'table' then
            local found, foundPath = DeepSearch(value, item, newPath)
            if found then
                return true, foundPath
            end
        end
    end

    return false, nil
end

return DeepSearch
