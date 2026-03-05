Name = "backgrounds"
NamePretty = "Backgrounds"
Icon = "preferences-desktop-wallpaper"
Cache = false
SearchName = true
Description = "Pick a background from ~/.config/backgrounds"

-- We'll set hyprpaper via a helper script (next step)
Action = "sh -lc '$HOME/.config/hypr/scripts/set-wallpaper.sh %VALUE%'"

function GetEntries()
	local entries = {
		{ Name = "DEBUG: menu loaded", Value = "OK", Icon = "dialog-information" },
	}

	local dir = os.getenv("HOME") .. "/.config/backgrounds"
	local cmd = "find '"
		.. dir
		.. "' -maxdepth 1 -xtype f \\( "
		.. "-iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' "
		.. "\\) -printf '%f\\n' 2>/dev/null"

	local handle = io.popen(cmd)
	if handle then
		for file in handle:lines() do
			table.insert(entries, {
				Name = file,
				Value = dir .. "/" .. file,
				Icon = "image-x-generic",
			})
		end
		handle:close()
	end

	return entries
end
