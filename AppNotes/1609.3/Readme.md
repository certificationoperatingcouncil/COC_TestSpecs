
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



**dot3 ASN1**

FHWA RSU requirements - RSU 4.1 ver 5 - published April 28, 2017
([FHWA-JPO-17-589.pdf](https://ntl.bts.gov/lib/61000/61700/61794/FHWA-JPO-17-589.pdf))

Revision to Dedicated Short Range Communication Roadside Equipment Specification – RSU 4.1 Bench Test Plan - published April 28, 2017
([FHWA-JPO-17-591.pdf](https://ntl.bts.gov/lib/62000/62100/62162/FHWA-JPO-17-591.pdf))

Added __RSU\RSU-MIB.txt__ provided by Leidos on October 3, 2017.
Changes include updates based on vendor comments.
This MIB file will superseed MIB included in RSU 4.1 ver 5.

## Update 20170516
**1609.3-Guidance-Note-2-MIB-v1.1-20170515.pdf**

From Kevin Smith  

Please find a revised Guidance Note 2 for the 1609.3 WME MIB. The changes from v1.0 are as follows:

- Removed the minor-version number from the MIB OID.
- Updated the date in the DESCRIPTION section to the current date

This change came about after discussions during the recent 1609 WG meetings. William White captured the issue nicely in an email and I’ve reproduced his comments here:

“ASN.1 module version numbers: Ken Vaughn said that the convention is not to include the minor version number in the module OID but to include it in a comment or something. This means that IF there are changes which just include adding elements after an extension number, or adding names to integers, or anything else that won't break IMPORT statements based on the previous version of the module, THEN the OID isn't incremented. This means that those modules don't have to change their import statements. According to Ken, this is common practice in ISO. I'm happy to take this as a precedent for us, meaning that we should remove the *minor* version number from the OIDs. ”
