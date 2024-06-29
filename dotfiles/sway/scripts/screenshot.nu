#!/usr/bin/env nu

#let entries = ["Active" "Screen" "Output" "Area" "Window"]
let entries = ["Area Save" "Area Copy" "Screen Save" "Screen Copy"]

let selected = $entries | str join "\n" | ^wofi $"--style=($env.HOME)/.config/wofi/style.widgets.css" $"--conf=($env.HOME)/.config/wofi/config.screenshot" | str trim | str downcase

match $selected {
  #  "active" => {
  #      grimshot --notify save active
  #  }
    "screen save" => {
        grimshot --notify save screen
    }
    "screen copy" => {
        grimshot --notify copy screen
    }
  #  "output" => {
  #      grimshot --notify save output
  #  }
    "area save" => {
        grimshot --notify save area
    }
    "area copy" => {
        grimshot --notify copy area
    }
  #  "window" => {
  #      grimshot --notify save window
  #  }
    _ => {
        echo "Invalid selection"
    }
}


