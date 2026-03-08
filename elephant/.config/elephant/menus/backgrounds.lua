Name = "backgrounds"
NamePretty = "Backgrounds"
Icon = "preferences-desktop-wallpaper"
Cache = true
SearchName = true
Description = "Pick a background from ~/.config/backgrounds"

Action = "sh -lc '$HOME/.config/hypr/scripts/set-wallpaper.sh %VALUE%'"

function GetEntries()
	local entries = {}
	local dir = os.getenv("HOME") .. "/.config/backgrounds"

	-- Improved find command to handle spaces in filenames more safely
	local cmd = "find '"
		.. dir
		.. "' -maxdepth 1 -xtype f \\( "
		.. "-iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' "
		.. "\\) -printf '%f\\n' 2>/dev/null"

	local handle = io.popen(cmd)
	if handle then
		for file in handle:lines() do
			-- Check if file is not default.*
			if file:match("^default%..+$") then
				do
					break
				end
			end
			local fullPath = dir .. "/" .. file
			table.insert(entries, {
				Text = file, -- what Walker shows
				Subtext = "background", -- optional
				Value = fullPath, -- passed to your script as %VALUE%
				Preview = fullPath, -- file to preview
				PreviewType = "file",
				Icon = fullPath,
			})
		end
		handle:close()
	end

	-- If list is empty, add a hint
	if #entries == 0 then
		table.insert(entries, { Name = "No backgrounds found", Value = "" })
	end

	return entries
end
