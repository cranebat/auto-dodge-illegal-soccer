-- LOADSTRING TEMPLATE WITH HttpGet
--
-- To use this:
-- 1. Upload auto_dodge_ui.lua to GitHub (or any public URL)
-- 2. Copy the RAW file URL (for GitHub: raw.githubusercontent.com/...)
-- 3. Replace the URL below
-- 4. Copy this entire script into your executor
--
-- EXAMPLE GitHub Raw URL:
-- https://raw.githubusercontent.com/USERNAME/REPO/branch/path/to/auto_dodge_ui.lua

local scriptUrl = "https://raw.githubusercontent.com/YOUR_USERNAME/auto-dodge-illegal-soccer/main/auto_dodge_ui.lua"
local success, result = pcall(function()
    return loadstring(game:HttpGet(scriptUrl))
end)

if success and result then
    local callSuccess, callError = pcall(result)
    if not callSuccess then
        print("[ERROR] Failed to execute script:", callError)
    end
else
    print("[ERROR] Failed to load script from URL:", result)
end
