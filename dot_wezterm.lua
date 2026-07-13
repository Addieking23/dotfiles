-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.term = "xterm-256color"

-- For example, changing the color scheme:
config.color_scheme = "Modus-Vivendi"
config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13.5

config.window_decorations = "RESIZE"

-- auto-rename tabs to show the running command instead of just the shell
wezterm.on("format-tab-title", function(tab)
	local process = tab.active_pane.foreground_process_name
	local title = process and process:match("([^/\\]+)$") or tab.active_pane.title

	-- Prettify a few common ones
	local nice_names = {
		["nvim"] = "  nvim",
		["vim"] = "  vim",
		["node"] = "  node",
		["python3"] = "  python",
	}
	title = nice_names[title] or title

	return {
		{ Text = " " .. title .. " " },
	}
end)

-- right-status bar with a clock and battery info
wezterm.on("update-status", function(window, _pane)
	local date = wezterm.strftime("%a, %b %-d | %H:%M")

	local battery = ""
	for _, b in ipairs(wezterm.battery_info()) do
		battery = string.format("%.0f%%", b.state_of_charge * 100)
	end

	window:set_right_status(wezterm.format({
		{ Text = "| " .. battery .. " | " .. date .. " |" },
	}))
end)

-- "smart split": horizontal or vertical based on current pane dimensions
wezterm.on("smart-split", function(window, pane)
	local dims = pane:get_dimensions()
	if dims.pixel_width > dims.pixel_height then
		window:perform_action(wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
	else
		window:perform_action(wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
	end
end)

-- one keybinding spins up a whole dev environment:
-- editor pane, server pane, git pane
-- local function launch_dev_workspace(_window, pane)
-- 	local build_pane = pane:split({
-- 		direction = "Right",
-- 		size = 0.3,
-- 	})
-- 	build_pane:send_text("npm run dev\n")
--
-- 	local git_pane = build_pane:split({
-- 		direction = "Bottom",
-- 		size = 0.4,
-- 	})
-- 	git_pane:send_text("git status\n")
--
-- 	pane:send_text("nvim .\n")
-- end

-- tmux
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		mods = "LEADER",
		key = "[",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		mods = "LEADER",
		key = "o",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER|SHIFT",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 3 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 3 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 3 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 3 }),
	},
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "w",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		mods = "LEADER",
		key = "P",
		action = wezterm.action.ShowLauncher,
	},
	{
		mods = "LEADER",
		key = ",",
		action = wezterm.action.PromptInputLine({
			description = "Enter a new name for the tab: ",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:activate_tab():set_title(line)
				end
			end),
		}),
	},
	-- {
	-- 	mods = "CTRL|SHIFT",
	-- 	key = "\\",
	-- 	action = wezterm.action.EmitEvent("smart-split"),
	-- },
	-- {
	-- 	mods = "CTRL|SHIFT",
	-- 	key = "d",
	-- 	action = wezterm.action_callback(launch_dev_workspace),
	-- },
	-- workspaces: like tmux sessions. Fuzzy-search/create/switch.
	{
		mods = "CTRL|SHIFT",
		key = "s",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	{
		mods = "CTRL|SHIFT",
		key = "n",
		action = wezterm.action.PromptInputLine({
			description = "Name for new workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line and #line > 0 then
					window:perform_action(wezterm.action.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},
	{
		mods = "CTRL|SHIFT",
		key = "[",
		action = wezterm.action.SwitchWorkspaceRelative(-1),
	},
	{
		mods = "CTRL|SHIFT",
		key = "]",
		action = wezterm.action.SwitchWorkspaceRelative(1),
	},
}

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- tab bar
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.tab_and_split_indices_are_zero_based = false

-- tmux-like sessions: a unix domain gives you a persistent multiplexer
-- server. Panes/tabs survive closing the window, SSH drops, etc.
-- Reattach with `wezterm connect unix`.
config.unix_domains = {
	{ name = "unix" },
}

-- Uncomment to auto-connect to the persistent domain on launch
-- (this changes startup behavior, so it's opt-in):
-- config.default_gui_startup_args = { "connect", "unix" }

-- and finally, return the configuration to wezterm
return config
