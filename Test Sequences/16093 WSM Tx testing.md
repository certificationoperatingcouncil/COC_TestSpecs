
## Testing WSMs

### SUT sending WSM packets to the Test System

Last updated 08/21/2017 ([history](#history))

#### Reference
May be used for WAVENS-TSS&TP (1609.3): TP-16093-WSM-MST-BV-01, TP-16093-WSM-MST-BV-02, TP-16093-WSM-ROP-BV-01, TP-16093-WSM-ROP-BV-02, TP-16093-WSM-ROP-BV-03, TP-16093-WSM-COM-BV-01, TP-16093-WSM-POP-BI-01

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16093%WSM%20Tx%20Testing.html)

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
2. **Test System -> SUT**: send *SetWsmInfo* to register a User Service on SUT for joining a service advertised in WSA [note2](#note2).
3. **Test System -> SUT**: send *StartWsmTx* containing a PSID service with IPv6 settings. For testing IPv6 communication using Link Local addresses, WRA is omitted from WSA. For testing IPv6 communication using Global IPv6 addresses, WSA includes WRA.

**Termination Sequence**

```puml
Test_System->SUT: StopWsmTx
SUT->Test_System: response
```

4. **Test System -> SUT**: send *StopWsmTx* to terminate transmission of WSM messages


<a name=note2>
Note 2: sample setup for *AddUserService*
</a>

|Parameter|Explanation|Example|
|---|---|---|
|psid|PSID of the user service|0x7F|
|radio|radio interface|radio0|
|userRequestType|Indicates the requested scheduler behavior. Autoaccess on service match indicates the scheduler should provide SCH access when detecting an available application-service opportunity matching all the criteria indicated in the request.|autoAccessOnMatch|
|wsaType|Secured or Unsecured WSA|secureWsa|
|providerServiceContext|Optional PSC octet string. Maybe be omitted.|"123"|
|channelIdentifier|Desired Sch channel for desired application service.  Must match Sch in WSA ChannelInfo. May be omitted.|174|
|sourceMACAddr|Address of the WSA sender. May be ommitted |0x010203040506|
|advertiserId|Advertiser ID listed in WSA. May be omitted ||
|linkQuality|Optional. May be omitted||
|immediateAccess|Optional. May be omitted||
|wsaChannelIdentifier|The channel where SUT will receive WSAs. Omitted if the default channel 178 is used|
|channelAccess|Time slot used for WSAs. Omitted if the default Time slot 0 is used|
|eventHandling<br>...rxFlag<br>...eventFlag<br>...forwardPdu<br>...securityFlag|Configures indications to be sent when PSID service is joined|rxFlag = includePduParam<br>eventFlag=eWSAServiceActive<br>forwardPdu omitted<br>securityFlag=1 or 0|

Also review WME-UserService.request described in IEEE 1609.3

---

<a name=note4>
Note 4: sample setup for *Dot3Indication*
</a>

|Parameter|Explanation|Example|
|---|---|---|
|radio|radio interface which generated the event|radio0|
|event|Event type|eDot3RequestMatchedAvailAppService|
|eventParams|Parameters relevant to the event|PSID of joined service|
|pdu|Omitted||
|exception|Omitted unless the SUT detected an exception||

---

<a name=note6>
Note 6: sample setup for *Dot3ResponseInfo*
</a>

|Parameter|Explanation|Example|
|---|---|---|
|msgID|Message ID used in the getIpv6InterfaceInfo request|14|
|resultCode|||
|info<br>...interfaceName<br>...ipAddress(s)<br>...macAddress<br>...defaultGateway<br>...primaryDns<br>...gatewayMacAddress|IPv6 settings for each wireless interface.<br>  defaultGateway, primaryDns and gatewayMacAddress are optional if they are not initialized||
|exception|Omitted unless the SUT detected an exception||

---

<a name=note7>
Note 7: sample setup for *StartIPv6Ping*
</a>

|Parameter|Explanation|Example|
|---|---|---|
|radio|index to radio interface|radio0|
|interfaceName||wlan0|
|destIpAddress|IPv6 address of the IPhost|FE80::10|
|protocol|Message protocol i.e. ping6|icmp|
|repeatRate|number of messages per 5 sec interval| 10 i.e. 2msg/sec|
|eventHandling<br>...rxFlag<br>...eventFlag<br>...forwardPdu<br>...securityFlag|Configures indications to be sent when PSID service is joined|rxFlag = '000'B <br>eventFlag=eIcmp6PktRx<br>forwardPdu omitted<br>securityFlag=0|

---

<a name=note9>
Note 9: sample setup for *Dot3Indication*
</a>

|Parameter|Explanation|Example|
|---|---|---|
|radio|radio interface which generated the event|radio0|
|event|Event type|eIcmp6PktRx|
|eventParams|Omitted||
|pdu|Omitted||
|exception|Omitted unless the SUT detected an exception||

---

<a name=history>
History

|Date|Changes|
|---|---|
|8/21/2017|Initial version|


</a>
