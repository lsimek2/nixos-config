from libqtile.config import Screen
from bars import main_bar, main_bar2

import os
import random

wallpaper_dir = './Nextcloud/wallpapers'

def get_random_wallpaper():
    wallpapers = os.listdir(wallpaper_dir)
    random_wallpaper = random.choice(wallpapers)
    return os.path.join(wallpaper_dir, random_wallpaper)

main_screen = Screen(top=main_bar,
  wallpaper=get_random_wallpaper(),
  wallpaper_mode="fill")  # Options: 'fill', 'stretch', 'center'
main_screen2 = Screen(top=main_bar2)

screens = [main_screen, main_screen2]
