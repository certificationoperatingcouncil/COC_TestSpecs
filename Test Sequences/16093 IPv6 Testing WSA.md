
## Testing IPv6 using WSA

### SUT sending IPv6 ping packets to the Test System

Last updated 08/10/2017 ([history](#history))

#### Reference
May be used for WAVENS-TSS&TP (1609.3): TP-16093-IP-COM-BV-01, TP-16093-IP-COM-BV-02

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16093%20IPv6%20Testing%20WSA.html)

```puml
Test_System->SUT: SetInitialState
SUT->Test_System: response
Test_System->SUT: AddUserService
SUT->Test_System: response
Test_System->SUT: WSA messages
SUT->Test_System: Dot3Indication
Test_System->SUT: GetIPv6InterfaceInfo
SUT->Test_System: Dot3ResponseInfo
Test_System->SUT: StartIPv6Ping
SUT->Test_System: response
SUT->IPhost: ping6
IPhost->SUT: ping6 echo
SUT->Test_System: Indication
...
```

**Explanation** (response and exception messages are omitted)
1. **Test System -> SUT**: send *SetInitialState* to reset the SUT to the initial state
2. **Test System -> SUT**: send *AddUserService* to register a User Service on SUT for joining a service advertised in WSA [note2](#note2).
3. **Test System -> SUT**: send *WSA messages* containing a PSID service with IPv6 settings. For testing IPv6 communication using Link Local addresses, WRA is omitted from WSA. For testing IPv6 communication using Global IPv6 addresses, WSA includes WRA.
4. **SUT -> Test System**: send *Dot3Indication* message when the User Service is activated [note4](#note4).
5. **Test System -> SUT**: send *GetIPv6InterfaceInfo* to get IP address settings from the SUT
6. **SUT -> Test System**: send *Dot3ResponseInfo* response message containing IP address settings for the SUT radio WAVE interface [note6](#note6).
7. **Test System -> SUT**: send *StartIPv6Ping* to send ping6 packets from the SUT to the IPhost [note7](#note7)
8. **SUT->IPhost; IPhost->SUT**: the SUT sends ping6 messages to IPhost and receives ping6 echo messages back.
9. **SUT->Test_System**: send *Dot3Indication* message when the SUT receives ping6 echo message  [note9](#note9).

**Termination Sequence**

```puml
Test_System->SUT: StopIPv6Ping
SUT->Test_System: response
Test_System->SUT: DelUserService
SUT->Test_System: response
```

7. **Test System -> SUT**: send *StopIPv6Ping* to terminate transmission of ping6 messages
8. **Test System -> SUT**: send *DelUserService* to delete User Service

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
|8/14/2017|Initial version|


</a>
