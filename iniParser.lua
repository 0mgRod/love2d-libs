local IniParser = {}

function IniParser.parse(filename)
    local file = love.filesystem.read(filename)
    if not file then
        error("File not found or unable to read: " .. filename)
        return nil
    end

    local config = {}
    local currentSection = nil

    for line in file:gmatch("[^\r\n]+") do
        local section = line:match("^%[([^%[%]]+)%]$")
        if section then
            currentSection = section
            config[currentSection] = {}
        else
            local key, value = line:match("^%s*([^=]+)%s*=%s*(.+)$")
            if key and value and currentSection then
                config[currentSection][key] = value
            end
        end
    end

    return config
end

function IniParser.getValue(config, section, key)
    if config[section] and config[section][key] then
        return config[section][key]
    else
        return nil
    end
end

return IniParser
