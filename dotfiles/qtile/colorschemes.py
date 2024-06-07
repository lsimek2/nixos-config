from defaults import colorscheme

colorschemes = {
    "default": [["#ff5555", "#ff5555"],  # 0
                ["#ffffff", "#ffffff"],  # 1
                ["#ffd47e", "#ffd47e"],  # 2
                ["#62FF00", "#62FF00"],  # 3
                ["#c40234", "#c40234"],  # 4
                ["#6790eb", "#6790eb"],  # 5
                ["#282c34", "#282c34"],  # 6
                ["#212121", "#212121"],  # 7
                ["#e75480", "#e75480"],  # 8
                ["#2aa899", "#2aa899"],  # 9
                ["#abb2bf", "#abb2bf"],  # 10
                ["#56b6c2", "#56b6c2"],  # 11
                ["#b48ead", "#b48ead"],  # 12
                ["#ff79c6", "#ff79c6"],  # 13
                ["#e06c75", "#e06c75"],  # 14
                ["#ffb86c", "#ffb86c"]],  # 15

    'dcols': {
            'lblack': ['#222222', '#222222'],
            'laven': ['#e0c6ff', '#e0c6ff'],
            'lyg': ['#c2ff79', '#c2ff79'],
            'lye': ['ffe96c', 'ffe96c'],
            'lblue': ['#abeaff', '#abeaff'],
            'cyan': ['#6cffe8', '#6cffe8'],
            'plum': ['#dda0dd', '#dda0dd'],
            'lora': ['#ffdfc6', 'ffdfc6'],
            'pist': ['#c6ffe8', '#c6ffe8'],
            'lpnk': ['#ff79c1', '#ff79c1'],
            'white': ['#ffffff', '#ffffff'],
            'fblack': ['#000000', '#000000'],
        }
}

def init_colors(colorscheme='dcols'):
    return colorschemes[colorscheme]


colors = init_colors(colorscheme)
