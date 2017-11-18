
## Update 20171118

[Here is the Link](https://github.com/certificationoperatingcouncil/TCI_ASN1/tree/master/TCI%20Interface/ASN1/1609dot3) to the dot3 ASN1 files. Note that the included ASN1 files were modified to reflect changes discussed in "1609_3 guidance presentation 11 Oct 2017 v1.pdf" (Update 20171011)

Changes were made to wee.asn as follows: 

> -- Longitude ::= INTEGER (-1800000000..1800000001) as defined in 1609.3 -- DEPRECATED
Longitude ::= INTEGER (-1799999999..1800000001) -- changed to J2735 definition
-- 1/10 micro degree
-- Providing a range of plus-minus 180 degrees

> Elevation ::= INTEGER (-4096..61439)
-- In units of 10 cm steps above or below the reference ellipsoid
-- Providing a range of -409.5 to + 6143.9 meters
-- The value -4096 shall be used when Unknown is to be sent

ASN.1 files from the original published IEEE1609.3-2016 are included in 1609.3-2016 ASN1.zip

## Update 20171011

1609_3 guidance presentation 11 Oct 2017 v1.pdf - 1609_3 guidance presentation prepared for the OmniAir plugfest in Fremont. Covered topics:

* Note regarding ASN.1 and UPER
* Elevation
* Latitude
* Channel Access
* 1609.2 security header

## Update 20170516

1609.3-Guidance-Note-2-MIB-v1.1-20170515.pdf - addresses changes in the dot3 MIB. Includes updated MIB file
MIB1609dot3v3-ieee1609_3_4_2-GN2v1_1.txt - updated MIB file from the Guidence Note 2

## Update 20161219

1609.3-Guidance-Note-1-v0.3-20161219.pdf - addresses encoding of Transmit Power in WSM/WSA
