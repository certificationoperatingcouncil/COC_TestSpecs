
## Testing WSMs

### SUT receiving WSM packets and sending indications to the Test System

Last updated 08/22/2017 ([history](#history))

#### Reference
May be used for WAVENS-TSS&TP (1609.3): TP-16093-WSM-PP-BV-01, TP-16093-WSM-PP-BV-02, TP-16093-WSM-COM-BV-02

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16093%WSM%20Rx%20Testing.html)

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
Test_System->SUT: StartWsmRx **(2)**
SUT->Test_System: response
SUT->Test_System: Dot3Indication **(3)**
...
```

**Explanation** (response and exception messages are omitted)
1. **Test System -> SUT**: send *SetInitialState* to reset the SUT to the initial state
2. **Test System -> SUT**: send *StartWsmRx* to register a User Service on SUT for joining a service advertised in WSA [note2](#note2).
3. **SUT -> Test System**: send *Dot3Indication* when the SUT receive a packet from the Test System [note3](#note3).

**Termination Sequence**

```puml
Test_System->SUT: StopWsmRx
SUT->Test_System: response
```

4. **Test System -> SUT**: send *StopWsmRx* to terminate reception of WSM messages


Note 2: sample setup for <a name=note2>*StartWsmRx*</a>

|Parameter|Explanation|Example|
|---|---|---|
|psid|PSID of WSM to receive|0x7F|
|radio|radio interface|radio0|
|channelIdentifier|channel number|174|
|timeSlot|Receive WSMs during a specific time slot or in continuous mode|continuous|
|eventHandling<br>...rxFlag<br>...eventFlag<br>...forwardPdu<br>...securityFlag|Configures indications to be sent when WSM with matching PSID is received|*rxFlag* =(recvPsidMatch set to 0), (includePdu set to 0), (includePduParam set to 0)<br>*eventFlag*=eWSM<br>*forwardPdu* omitted<br>securityFlag=1 or 0|

---

Note 3: sample setup for <a name=note3>*Dot3Indication*</a>

|Parameter|Explanation|Example|
|---|---|---|
|radio|radio interface which generated the event|radio0|
|event|Event corresponding to reception of WSM packet with matching PSID|eWsmPktRx|
|eventParams|Omitted||
|pdu|Omitted||
|exception|Omitted unless the SUT detected an exception||

---

<a name=history>
History

|Date|Changes|
|---|---|
|8/22/2017|Initial version|


</a>
