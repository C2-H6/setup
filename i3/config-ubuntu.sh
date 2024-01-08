# i3 config file (v4)

# Set mod key (Mod1=<Alt>, Mod4=<Super>)
set $mod Mod4

# Configure border style :
default_border pixel 1
default_floating_border normal
hide_edge_borders none

# Font for window titles.
font xft:URWGothic-Book 11

# Use Mouse+$mod to drag floating windows
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec xfce4-terminal

# kill focused window
bindsym $mod+Shift+q kill

######################   My own shortcut  ######################

# start program launcher
bindsym $mod+d exec --no-startup-id dmenu_run
bindsym $mod+o exec opera
bindsym $mod+Shift+o exec obsidian
bindsym $mod+c exec code
bindsym $mod+p exec discord

######################   Ubuntu parameter  ######################

bindsym $mod+Ctrl+b exec nautilus
exec --no-startup-id update-manager

############################################

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# workspace back and forth (with/without active container)
workspace_auto_back_and_forth yes
bindsym $mod+b workspace back_and_forth
bindsym $mod+Shift+b move container to workspace back_and_forth; workspace back_and_forth

# split orientation
bindsym $mod+h split h;
bindsym $mod+v split v;
bindsym $mod+q split toggle

# toggle fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# toggle sticky
bindsym $mod+Shift+s sticky toggle

# focus the parent container
bindsym $mod+a focus parent

# move the currently focused window to the scratchpad
bindsym $mod+Shift+minus move scratchpad

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command cycles through them.
bindsym $mod+minus scratchpad show

#navigate workspaces next / previous
bindsym $mod+Ctrl+Right workspace next
bindsym $mod+Ctrl+Left workspace prev

# Workspace names
set $ws1 1
set $ws2 2
set $ws3 3
set $ws4 4
set $ws5 5
set $ws6 6
set $ws7 7
set $ws8 8

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8

# Move focused container to workspace
bindsym $mod+Ctrl+1 move container to workspace $ws1
bindsym $mod+Ctrl+2 move container to workspace $ws2
bindsym $mod+Ctrl+3 move container to workspace $ws3
bindsym $mod+Ctrl+4 move container to workspace $ws4
bindsym $mod+Ctrl+5 move container to workspace $ws5
bindsym $mod+Ctrl+6 move container to workspace $ws6
bindsym $mod+Ctrl+7 move container to workspace $ws7
bindsym $mod+Ctrl+8 move container to workspace $ws8

# Move to workspace with focused container
bindsym $mod+Shift+1 move container to workspace $ws1; workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2; workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3; workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4; workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5; workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6; workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7; workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8; workspace $ws8

# switch to workspace with urgent window automatically
for_window [urgent=latest] focus

# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

################## I3 lock, option and shortcut #########################

# Define the lock command
set $lock_command "i3lock --no-unlock-indicator --image ~/.i3/hello.png"

# Define the logind command based on the init system
exec --no-startup-id logind=$(if [ "$(cat /proc/1/comm)" = "systemd" ]; then echo "systemctl"; else echo "loginctl"; fi)

# Set shut down, restart, and locking features
bindsym $mod+0 mode "$mode_system"
set $mode_system (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown
mode "$mode_system" {
    bindsym s exec --no-startup-id $lock_command && $logind suspend, mode "default"
    bindsym u exec --no-startup-id dm-tool switch-to-greeter, mode "default"
    bindsym e exec --no-startup-id $lock_command && $logind logout, mode "default"
    bindsym h exec --no-startup-id $lock_command && $logind hibernate, mode "default"
    bindsym r exec --no-startup-id $logind reboot, mode "default"
    bindsym Shift+s exec --no-startup-id $logind poweroff, mode "default"

    # Exit system mode: "Enter" or "Escape"
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# Lock screen
exec --no-startup-id xautolock -time 10 -locker $lock_command
bindsym $mod+9 exec --no-startup-id $lock_command

##################################################

# Resize window (you can also use the mouse for that)
bindsym $mod+r mode "resize"
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode
        bindsym j resize shrink width 5 px or 5 ppt
        bindsym k resize grow height 5 px or 5 ppt
        bindsym l resize shrink height 5 px or 5 ppt
        bindsym semicolon resize grow width 5 px or 5 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # exit resize mode: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}


#Setup wallpaper
exec --no-startup-id feh --bg-scale ~/.i3/wallpaper.png; picom -b

#Connect to wifi
exec --no-startup-id nm-applet

#Change screen brightness
exec --no-startup-id xfce4-power-manager

#autorisation admin
exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 


# Start i3bar to display a workspace bar (plus the system information i3status if available)
bar {
        mode hide

	i3bar_command i3bar
	status_command i3status
	position bottom

	bindsym button4 nop
	bindsym button5 nop
	strip_workspace_numbers yes

colors {
#                      border  backgr. text
        binding_mode       #002b36 #000000 #F9FAF9
        urgent_workspace   #002b36 #000000 #E5201D
    }
}


bindsym $mod+m bar mode toggle

# Set inner/outer gaps
#aps inner 14
#gaps outer -2

# Smart gaps (Only more than one container on the workspace)
#smart_gaps on

# Smart borders (Only more than one container on the workspace)
#smart_borders on