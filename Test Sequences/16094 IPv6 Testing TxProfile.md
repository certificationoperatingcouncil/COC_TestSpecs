
## Testing IPv6 in 1609.4 using Tx Profile without WSA

### SUT sending IPv6/UDP packets to the Test System

Last updated 08/10/2017 ([history](#history))

#### Reference
May be used for WAVEMCO-TSS&TP (1609.4): TP-16094-TXT-IP6-BV-01

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16094%20IPv6%20Testing%20TxProfile.html)

```puml
Test_System->SUT: SetInitialState
Test_System->SUT: AddTxProfile
Test_System->SUT: GetIPv6InterfaceInfo
SUT->Test_System: Dot4ResponseInfo
Test_System->SUT: SetIPv6Address
Test_System->SUT: StartIPv6Tx
```

1. **Test System -> SUT**: send *SetInitialState* - request to reset SUT to the initial state
2. **Test System -> SUT**: send *AddTxProfile* - request to set TxProfile (Channel, Timeslot, DataRate, TxPower, etc) for IP communication
3. **Test System -> SUT**: send *GetIPv6InterfaceInfo* - request to get IP address settings from SUT
4. **SUT -> Test System**: send *Dot4ResponseInfo* - response message containing IP address settings for the radio WAVE interface available from the SUT
5. **Test System -> SUT**: send *SetIPv6Address* - request to set IP address, may be optional if Link Local IP address is already setup
6. **Test System -> SUT**: send *StartIPv6Tx* - request for SUT to send IPv6/UDP packets to the Test System [note5](#note5)

**Termination Sequence**

```puml
Test_System->SUT: StopIPv6Tx
Test_System->SUT: DelTxProfile
```

7. **Test System -> SUT**: send *StopIPv6Tx* - terminate transmission of messages
8. **Test System -> SUT**: send *DelTxProfile* - remove TxProfile

Note: Response and Exception messages are omitted



<a name=note5>
Sample setup for *StartIPv6Tx*

|Parameter|Explanation|Example|
|---|---|---|
|radio|index to radio interface|radio0|
|interfaceName||wlan0|
|destIpAddress|Link local IPv6 address of the test system|FE80::1|
|destPort|UDP port for receiving test messages on the test system|55555|
|protocol||udp|
|repeatRate|number of messages per 5 sec interval| 10 i.e. 2msg/sec|
|eventHandling| omitted, since test system receives messages||
|payload|payload to include in IPv6 packets|"Hello World"|

</a>

<a name=history>
History

|Date|Changes|
|---|---|
|8/10/2017|Initial version|


</a>
