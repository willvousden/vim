# -*- coding: utf-8 -*-

from orgmode import echo, echom, echoe, ORGMODE, apply_count, repeat
from orgmode.menu import Submenu, Separator, ActionEntry
from orgmode.keybinding import Keybinding, Plug, Command
from orgmode.heading import Heading, DIRECTION_FORWARD, DIRECTION_BACKWARD

import vim

class Example(object):
	""" Example plugin """

	def __init__(self):
		""" Initialize plugin """
		object.__init__(self)
		# menu entries this plugin should create
		self.menu = ORGMODE.orgmenu + Submenu('Example')

		# key bindings for this plugin
		# key bindings are also registered through the menu so only additional
		# bindings should be put in this variable
		self.keybindings = []

		# commands for this plugin
		self.commands = []
	
	def register(self):
		"""
		Registration of plugin. Key bindings and other initialization should be done.
		"""
		# an Action menu entry which binds "keybinding" to action ":action"
		self.commands.append(Command('OrgActionCommand', ':py ORGMODE.plugins["Example"].action()'))
		self.keybindings.append(Keybinding('keybinding', Plug('OrgAction', self.commands[-1])))
		self.menu + ActionEntry('&Action', self.keybindings[-1])
