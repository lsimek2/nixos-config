
from libqtile import layout
from libqtile.config import Match

from colorschemes import colors

def init_layout_theme():
    return {"margin":10,
            "border_width":1,
            "border_focus": colors.get('laven'),
            "border_normal": colors.get('lblack')
            }

layout_theme = init_layout_theme()

# layouts = []
layouts = [
     layout.MonadTall(margin=10, border_width=1, border_focus=colors.get('laven'), border_normal=colors.get('lblack')),
     layout.MonadWide(margin=10, border_width=1, border_focus=colors.get('laven'), border_normal=colors.get('lblack')),
     layout.Matrix(**layout_theme),
     layout.Bsp(**layout_theme),
     layout.Floating(**layout_theme),
     layout.RatioTile(**layout_theme),
     layout.Max(**layout_theme),
     layout.Columns(**layout_theme),
     layout.Stack(**layout_theme),
     layout.Tile(**layout_theme),
     layout.TreeTab(
         sections=['FIRST', 'SECOND'],
         bg_color = '#222222',
         active_bg = colors.get('lblack'),
         inactive_bg = ['#333333', '#333333'],
         padding_y =5,
         section_top =10,
         panel_width = 280),
     layout.VerticalTile(**layout_theme),
     layout.Zoomy(**layout_theme)
 ]
 
 
floating_layout = layout.Floating(float_rules=[
     # Run the utility of `xprop` to see the wm class and name of an X client.
     *layout.Floating.default_float_rules,
     Match(wm_class='confirmreset'),  # gitk
     Match(wm_class='makebranch'),  # gitk
     Match(wm_class='maketag'),  # gitk
     Match(wm_class='ssh-askpass'),  # ssh-askpass
     Match(title='branchdialog'),  # gitk
     Match(title='pinentry'),  # GPG key password entry
     Match(wm_class='Arcolinux-welcome-app.py'),
     Match(wm_class='Arcolinux-calamares-tool.py'),
     Match(wm_class='confirm'),
     Match(wm_class='dialog'),
     Match(wm_class='download'),
     Match(wm_class='error'),
     Match(wm_class='file_progress'),
     Match(wm_class='notification'),
     Match(wm_class='splash'),
     Match(wm_class='toolbar'),
     Match(wm_class='confirmreset'),
     Match(wm_class='makebranch'),
     Match(wm_class='maketag'),
     Match(wm_class='Arandr'),
     Match(wm_class='feh'),
     Match(wm_class='Galculator'),
     Match(title='branchdialog'),
     Match(title='Open File'),
     Match(title='pinentry'),
     Match(wm_class='ssh-askpass'),
     Match(wm_class='lxpolkit'),
     Match(wm_class='Lxpolkit'),
     Match(wm_class='yad'),
     Match(wm_class='Yad'),
     Match(wm_class='Cairo-dock'),
     Match(wm_class='cairo-dock'),
 ],  fullscreen_border_width = 0, border_width = 0)


