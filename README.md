    network_custom_commands
    Network Batch Cisco Commands. In case you need to gather the output from many
    show commands on many newwork devices
    Copyright (C) 2017  Manolis Kartsonakis

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Just edit the following files:

	commands.list -  your commands
	devices.list - your devises
	customcase.sh - your username/password on line 14/15

    Run with:
	
	./custom-shows.sh devices.list
