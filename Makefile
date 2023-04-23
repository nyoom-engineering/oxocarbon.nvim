.PHONY: all lua 

all: lua

lua:
	nvim --headless +"Fnlfile make.fnl" +qa
