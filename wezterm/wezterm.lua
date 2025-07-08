local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- Generate private & publick keys using age
-- $ age-keygen -o key.txt
resurrect.state_manager.set_encryption({
  enable = true,
  method = "age",
  private_key = os.getenv("HOME") .. "/.config/wezterm/key.txt",
  public_key = "age1mkvr6kqszxmx2ja6k8harh4l69hgk3crkpdumg8va9elxzpvdc7spaw4fa",
})

resurrect.state_manager.periodic_save()

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():toggle_fullscreen()
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
  local workspace_state = resurrect.workspace_state

  workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
    window = window,
    relative = true,
    restore_text = true,
    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  })
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
  local workspace_state = resurrect.workspace_state
  resurrect.state_manager.save_state(workspace_state.get_workspace_state())
end)

wezterm.on("update-status", function(window, pane)
  local our_tab = pane:tab()
  local is_zoomed = false
  if our_tab ~= nil then
    for _, pane_attributes in pairs(our_tab:panes_with_info()) do
      is_zoomed = pane_attributes['is_zoomed'] or is_zoomed
    end
  end

  if is_zoomed then
    window:set_right_status(wezterm.format {
      { Foreground = { Color = 'white' } },
      { Text = ' Zoomed         ' },
    })
    wezterm.emit("force-tabs-shown", window, pane)
  else
    window:set_right_status("")
  end
end)

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_padding = { bottom = 0 }
config.hide_mouse_cursor_when_typing = false
config.window_decorations = "RESIZE"
config.color_scheme = "Modus Vivendi"
config.font_size = 14.0
config.font = wezterm.font_with_fallback({
  "JetBrains Mono NL",
  "MesloLGS NF",
  "Noto Color Emoji",
})

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "n",          mods = "CTRL",   action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = ";",          mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "'",          mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "z",          mods = "CTRL",   action = "TogglePaneZoomState" },
  { key = "v",          mods = "LEADER", action = wezterm.action.ActivateCopyMode },
  { key = ":",          mods = "LEADER", action = wezterm.action.ActivateCommandPalette },
  { key = "1",          mods = "LEADER", action = wezterm.action { ActivateTab = 0 } },
  { key = "2",          mods = "LEADER", action = wezterm.action { ActivateTab = 1 } },
  { key = "3",          mods = "LEADER", action = wezterm.action { ActivateTab = 2 } },
  { key = "4",          mods = "LEADER", action = wezterm.action { ActivateTab = 3 } },
  { key = "5",          mods = "LEADER", action = wezterm.action { ActivateTab = 4 } },
  { key = "6",          mods = "LEADER", action = wezterm.action { ActivateTab = 5 } },
  { key = "7",          mods = "LEADER", action = wezterm.action { ActivateTab = 6 } },
  { key = "8",          mods = "LEADER", action = wezterm.action { ActivateTab = 7 } },
  { key = "9",          mods = "LEADER", action = wezterm.action { ActivateTab = 8 } },
  { key = "LeftArrow",  mods = "CMD",    action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "DownArrow",  mods = "CMD",    action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "UpArrow",    mods = "CMD",    action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "RightArrow", mods = "CMD",    action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "1",          mods = "CMD",    action = wezterm.action.SendKey { key = "1", mods = "ALT" } },
  { key = "2",          mods = "CMD",    action = wezterm.action.SendKey { key = "2", mods = "ALT" } },
  { key = "3",          mods = "CMD",    action = wezterm.action.SendKey { key = "3", mods = "ALT" } },
  { key = "4",          mods = "CMD",    action = wezterm.action.SendKey { key = "4", mods = "ALT" } },
  { key = "5",          mods = "CMD",    action = wezterm.action.SendKey { key = "5", mods = "ALT" } },
  { key = "6",          mods = "CMD",    action = wezterm.action.SendKey { key = "6", mods = "ALT" } },
  { key = "7",          mods = "CMD",    action = wezterm.action.SendKey { key = "7", mods = "ALT" } },
  { key = "8",          mods = "CMD",    action = wezterm.action.SendKey { key = "8", mods = "ALT" } },
  { key = "9",          mods = "CMD",    action = wezterm.action.SendKey { key = "9", mods = "ALT" } },

  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
    end),
  },

  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)")
        id = string.match(id, "([^/]+)$")
        id = string.match(id, "(.+)%..+$")
        local opts = {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }
        if type == "workspace" then
          local state = resurrect.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local state = resurrect.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end
      end)
    end),
  },

  {
    key = "s",
    mods = "LEADER",
    action = workspace_switcher.switch_workspace(),
  },

  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.QuitApplication,
  },

  {
    key = "m",
    mods = "LEADER",
    action = wezterm.action.ToggleFullScreen,
  }
}

return config
