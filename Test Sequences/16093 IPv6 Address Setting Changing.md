
## Test System verify and change IPv6 address setting of the SUT

Last updated 08/16/2017 ([history](#history))

#### Reference
May be used for WAVENS-TSS&TP (1609.3): TP-16093-IP-CFG-BV-02

**Initiation Sequence** [with images]( https://htmlpreview.github.io/?https://github.com/certificationoperatingcouncil/COC_TestSpecs/blob/master/Test%20Sequences/html/16093%20IPv6%20Address%20Setting%20Changing.html)

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
Test_System->SUT: GetIPv6InterfaceInfo **(2)**
SUT->Test_System: Dot3ResponseInfo **(3)**
SUT->Test_System: response
Test_System->SUT: SetIPv6Address **(4)**
SUT->Test_System: response
Test_System->SUT: GetIPv6InterfaceInfo
SUT->Test_System: Dot3ResponseInfo **(5)**
```

**Explanation** (response and exception messages are omitted)
1. **Test System -> SUT**: send *SetInitialState* to reset the SUT to the initial state
2. **Test System -> SUT**: send *GetIPv6InterfaceInfo* to get IP address settings from the SUT for specific radio interface
3. **SUT -> Test System**: send *Dot3ResponseInfo* response message containing IP address settings for the SUT radio WAVE interface [note3](#note3).
4. **Test System -> SUT**: send *SetIPv6Address* to set address for the SUT radio WAVE interface [note4](#note4).
5. **SUT -> Test System**: send *Dot3ResponseInfo* response message containing IP address settings for the SUT radio WAVE interface used to verify that the new IPv6 address is set.

**Termination Sequence**
None

**Note 3: sample setup for <a name=note6>*Dot3ResponseInfo*</a>**

|Parameter|Explanation|Example|
|---|---|---|
|msgID|Message ID used in the *GetIPv6InterfaceInfo* request|14|
|resultCode|TCI message was successfully received|rcSuccess|
|info<br>...interfaceName<br>...ipAddress(s)<br>...macAddress<br>...defaultGateway<br>...primaryDns<br>...gatewayMacAddress|IPv6 settings for each wireless interface.<br>  defaultGateway, primaryDns and gatewayMacAddress are optional if they are not initialized||
|exception|Omitted unless the SUT detected an exception||

---

**Note 4: sample setup for <a name=note4>*SetIPv6Address*</a>**

|Parameter|Explanation|Example|
|---|---|---|
|radio|radio interface which generated the event|radio0|
|interfaceName|interface name obtained from *Dot3ResponseInfo*|wlan0|
|ipAddress|Global IPv6 address|2001::ef01|

---

<a name=history>
History

|Date|Changes|
|---|---|
|8/16/2017|Initial version|


</a>
