local function DeepCopy(tbl)
    local copy = table.clone(tbl)

    for key, value in tbl do
        if typeof(value) == 'table' then
            copy[key] = DeepCopy(value)
        end
    end

    return copy
end

return DeepCopy
