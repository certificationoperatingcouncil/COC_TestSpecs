# Wireshark LUA script for PC5

This folder contains a LUA script to allow wireshark to parse WAVE Short Messages containing BSM, etc embedded inside PC5 frame.

* Script\ includes the LUA script
* PCAP\ contains PCAP for testing

This script was tested with Wireshark customized by 3M.

It is not guaranteed to work with Wireshark customized by others to support WSM parsing.

## Prerequisites

Wireshark must have an existing decoder for WSMP LLC 0x88DC registered as an ethertype disector

## Installation

* Open Wireshark -> About Wireshark -> Plugins and check that this lua is included in the plugin listing
* Open Wireshark -> About Wireshark -> Folders 
* copy this Lua into folder Personal Plugins or Global Plugins
* Ctrl-Shift-L to reload plugins
* Open the PCAP file and validate that WSM data is parseable

## Changelog

4/27/2019   v0.1     Initial version

