
## Update 20171006
**RSU Requirements**

FHWA RSU requirements - RSU 4.1 ver 5 - published April 28, 2017
([FHWA-JPO-17-589.pdf](https://ntl.bts.gov/lib/61000/61700/61794/FHWA-JPO-17-589.pdf)) 

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
