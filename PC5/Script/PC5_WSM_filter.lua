--[[
WireShark dissector for PC5 C-V2X protocol for Wireshark
===================================================
Copyright 2019 by D.Khijniak

License
=======
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

Links
=====
WireShark       http://www.wireshark.org/

Prerequisites
=============
Wireshark must have an existing decoder for WSMP LLC 0x88DC registered as an ethertype disector

Installation
============
Open Wireshark -> About Wireshark -> Folders 
copy this Lua into folder Personal Plugins or Global Plugins
Ctrl-Shift-L to reload plugins
Open Wireshark -> About Wireshark -> Plugins and check that this lua is included in the plugin listing

Changelog
=========
4/27/2019   v0.1     Initial version


]]--
-- get original disector handle ieee1609dot3 based on ethertype
local WSMEthertype = 35036 -- 0x88DC
local dissector_ethertype_table = DissectorTable.get("ethertype")
wsm_disector = dissector_ethertype_table:get_dissector(WSMEthertype)

local pcf_proto = Proto("PC5","C-V2X PC5 Protocol")

local f_proto_uint16 = ProtoField.uint16("pcf.type","Packet Type")

pcf_proto.fields = {
		f_proto_uint16
 }
      
-- create a function to dissect protocol
function pcf_proto.dissector(buffer,pinfo,tree)

  length=buffer:len()
  if length == 0 then return end
  
  pinfo.cols.protocol = pcf_proto.name -- "PC5 C-V2X"
  
  subtree = tree:add(pcf_proto, buffer (0,1), "PC5 [size: " ..buffer():len().."]")
  subtree:add(f_proto_uint16, buffer(0,1))
   
   newbuf=buffer(1,length-1):tvb()
   if wsm_disector ~= nil then
      wsm_disector:call(newbuf, pinfo, tree)
   end
   
end  

-- Initialize Protocol
function pcf_proto.init()
end

-- register protocol to handle udp port 1234
local dissector_table = DissectorTable.get("udp.port")
dissector_table:add(1234,pcf_proto)   
