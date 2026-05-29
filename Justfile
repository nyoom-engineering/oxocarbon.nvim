default := "lua"

lua:
    nvim --headless +"Fnlfile make.fnl" +qa

b name: lua
    jj file show --revision {{name}} lua/oxocarbon/init.lua > ~/.config/nvim/colors/oxocarbon_{{name}}.lua
    lua carbonizer.lua {{name}}

bookmark name: lua
    jj file show --revision {{name}} lua/oxocarbon/init.lua > ~/.config/nvim/colors/oxocarbon_{{name}}.lua
    lua carbonizer.lua {{name}}

carbonizer:
    lua carbonizer.lua
