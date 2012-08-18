#!/usr/bin/ruby
require "Rete.rb"

productions = [
	Condition.new("<x>", "^on", "<y>"),
	Condition.new("<y>", "^left-of", "<z>"),
	Condition.new("<z>", "^color", "red"),
	Condition.new("<a>", "^color", "maize"),
	Condition.new("<b>", "^color", "blue"),
	Condition.new("<c>", "^color", "green"),
	Condition.new("<d>", "^color", "white"),
	Condition.new("<s>", "^on", "table"),
	Condition.new("<y>", "^<a>", "<b>"),
	Condition.new("<a>", "^left-of", "<d>")
]

rete = Rete.new
rete.set_productions(productions)

wme = WME.new("<d>", "^color", "white")
rete.add_wme(wme)