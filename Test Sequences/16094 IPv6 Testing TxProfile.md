
## Testing IPv6 in 1609.4 using Tx Profile without WSA

### SUT sending IPv6/UDP packets to the Test System

Last updated 08/16/2017 ([history](#history))

#### Reference
May be used for WAVEMCO-TSS&TP (1609.4): TP-16094-TXT-IP6-BV-01

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16094%20IPv6%20Testing%20TxProfile.html)

```puml
group Optional
Test_System->SUT: sutCtrl.RequestSutAvailability
SUT->Test_System: sutCtrl.response (resultCode=rcSuccess)
Test_System->SUT: sutCtrl.RequestSutInfo
SUT->Test_System: sutCtrl.SutResponseInfo
Test_System->SUT: sutCtrl.SetTestId
SUT->Test_System: response
end
|||
Test_System->SUT: SetInitialState
SUT->Test_System: response
Test_System->SUT: AddTxProfile
SUT->Test_System: response
Test_System->SUT: GetIPv6InterfaceInfo
SUT->Test_System: Dot4ResponseInfo
Test_System->SUT: SetIPv6Address
SUT->Test_System: response
Test_System->SUT: StartIPv6Tx
SUT->Test_System: response
...
```

**Explanation** (response and exception messages are omitted)
1. **Test System -> SUT**: send *SetInitialState* to reset SUT to the initial state
2. **Test System -> SUT**: send *AddTxProfile* to set TxProfile (Channel, Timeslot, DataRate, TxPower, etc) for IP communication
3. **Test System -> SUT**: send *GetIPv6InterfaceInfo* to get IP address settings from SUT
4. **SUT -> Test System**: send *Dot4ResponseInfo* message containing IP address settings for the radio WAVE interface available from the SUT
5. **Test System -> SUT**: send *SetIPv6Address* to set IP address, may be optional if Link Local IP address is already setup
6. **Test System -> SUT**: send *StartIPv6Tx* for SUT to send IPv6/UDP packets to the Test System [note5](#note5)

**Termination Sequence**

```puml
...
Test_System->SUT: StopIPv6Tx
SUT->Test_System: response
Test_System->SUT: DelTxProfile
SUT->Test_System: response
```

7. **Test System -> SUT**: send *StopIPv6Tx* to terminate transmission of messages
8. **Test System -> SUT**: send *DelTxProfile* to remove TxProfile


<a name=note5>
Sample setup for *StartIPv6Tx*
</a>

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

---

<a name=history>
History
</a>

|Date|Changes|
|---|---|
|8/16/2017|Added optional message block|
|8/10/2017|Initial version|
