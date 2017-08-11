
## Perform testing IPv6 in 1609.4 using Tx Profile without WSA

### SUT sending IPv6/UDP packets to the Test System

May be used for 1609.4

Initiation Sequence

1. **Test System -> SUT**: send *AddTxProfile* - request to set TxProfile (Channel, Timeslot, DataRate, TxPower, etc) for IP communication [note1](#note1)
2. **Test System -> SUT**: send *GetIPv6InterfaceInfo* - request to get IP address settings from SUT
3. **SUT -> Test System**: send *Dot4ResponseInfo* - response message containing IP address settings for the radio WAVE interface available from the SUT
4. **Test System -> SUT**: send *SetIPv6Address* - request to set IP address, may be optional if Link Local IP address is already setup
5. **Test System -> SUT**: send *StartIPv6Tx* - request for SUT to send IPv6/UDP packets to the Test System [note5](#note5)

Termination Sequence

6. **Test System -> SUT**: send *StopIPv6Tx* - terminate transmission of messages
7. **Test System -> SUT**: send *DelTxProfile* - remove TxProfile

Note: Response and Exception messages are omitted



<a name=note5>
Sample setup for *StartIPv6Tx*

|parameter|explanation|example|
|---|---|
|radio|index to radio interface|radio1|
|interfaceName||wlan0|
|destIpAddress|Link local IPv6 address of the test system|FE80::1|
|destPort|UDP port for receiving test messages on the test system|55555|
|protocol||UDP|
|repeatRate|number of messages per 5 sec interval| 10 i.e. 2msg/sec|
|eventHandling| omitted, since test system receives messages||
|payload|payload to include in IPv6 packets|"Hello World"|

</a>
