
## Testing WSMs

### SUT sending WSM packets to the Test System

Last updated 08/21/2017 ([history](#history))

#### Reference
May be used for WAVENS-TSS&TP (1609.3): TP-16093-WSM-MST-BV-01, TP-16093-WSM-MST-BV-02, TP-16093-WSM-ROP-BV-01, TP-16093-WSM-ROP-BV-02, TP-16093-WSM-ROP-BV-03, TP-16093-WSM-COM-BV-01, TP-16093-WSM-POP-BI-01

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16093%20WSM%20Tx%20Testing.html)

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
Test_System->SUT: SetInitialState **(1)**
SUT->Test_System: response
Test_System->SUT: SetWsmInfo **(2)**
SUT->Test_System: response
Test_System->SUT: StartWsmTx **(3)**
SUT->Test_System: response
...
```

**Explanation** (response and exception messages are omitted)
1. **Test System -> SUT**: send *SetInitialState* to reset the SUT to the initial state
2. **Test System -> SUT**: send *SetWsmInfo* to configure WSM parameters [note2](#note2).
3. **Test System -> SUT**: send *StartWsmTx* to start transmitting WSMs with parameters configured via *SetWsmInfo* [note3](#note3).

**Termination Sequence**

```puml
Test_System->SUT: StopWsmTx
SUT->Test_System: response
```

4. **Test System -> SUT**: send *StopWsmTx* to terminate transmission of WSM messages

Note 2: sample setup for <a name=note2>*SetWsmInfo*</a>

|Parameter|Explanation|Example|
|---|---|---|
|psid|PSID for WSM|0x7F|
|radio|radio interface|radio0|
|security<br>...ContentType<br>...signerIdentifierType|Security context. Options may vary based on message type and security requirements|contentType = mBSM<br>signerIdentifierType=useSecProfilePerContentType|
|channelIdentifier|Channel number|174|
|timeslot|Time slot or continuous|continuous|
|dataRate|The actual data rate (e.g. for 6Mbps is 6, not the encoded value 0xC)|6|
|transmitPowerLevel|Transmit power in dBm|20|
|infoElementsIncluded|WSM-N extensions, e.g. Tx Power, Data Rate, Channel number, or No extensions|transmitPowerUsed \| dataRate \| channelNumber|
|userPriority|User priority|3|
|destinationMACAddr|For broadcast WSMs use FFFFFFFFFFFF|0xFFFFFFFFFFFF|   
|expiryTime|Omnitted||
|channelLoad|Omitted||
|repeatRate|If set to 0, send one message only. Othersize periodic rate expressed as number of messages per 5 sec interval, i.e. 1msg/sec uses value 5|5|
|payload|Omitted||


---

Note 3: sample setup for <a name=note4>*StartWsmTx*</a>

|Parameter|Explanation|Example|
|---|---|---|
|psid|PSID for WSM|0x7F|
|radio|radio interface which generated the event|radio0|

---

<a name=history>
History

|Date|Changes|
|---|---|
|8/21/2017|Initial version|


</a>
