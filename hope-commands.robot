*** Settings ***
#Library    /Users/sachinchavan/Documents/SonicS/projects/Hope/python_hope/Hope/HopeLib.py
#Library    /Users/sachinchavan/Documents/docs/programs/robot/SSI.py    Left    /dev/tty.usbserial-AL02A1YP

*** Variables ***
${hopeclifile}    /Users/sachinchavan/Documents/SonicS/projects/Hope/python_hope/Hope/HopeCli.py
${Sony}    192.168.168.103
${port}    ${12345}
${ReadName}                01
${WriteName}               02
${ReadInfo}                05
${WriteInfo}               06
${InfoPayload}             27101005    # model ID 39, color ID 16, length 4101
${ReadSerial}              09
${WriteSerial}             0A
${SerialPayload}           1234567890AB
${SerialPayloadHex}        3132333435363738394142
${ReadSku}                 0D
${WriteSku}                0E
${SkuPayload}              313233343536373839
${ReadFwVersion}           11
${WriteFwVersion}          12
${FwVersionPayload}        
${ReadPCBA}                15
${WritePCBA}               16
${PCBAPayload}             
${ReadSystemMac}           19
${WriteSystemMac}          20
${SystemMacPayload}        
${ReadBattery}             1D
${ReadDigitalGain}         21
${WriteDigitalGain}        22
${DigitalGainPayload}      
${WriteGainIncrement}      26
${GainIncrementPayload}    01
${ReadPlayStatus}          29
${WritePlayStatus}         2A
${PlayStatusPayload}        01
${ReadEffects}             2D
${WriteEffects}            2E
${EffectsPayload}          01     #00, 02, 04, 07
${ReadTransducerGain}      31
${WriteTransducerGain}     32
${TransducerGainPayload}   0707
${WriteFwActions}          36
${WriteFwActionsPayload}    01     # 02, 03, 04, 05
${ReadExtendedBattery}     39
${ReadLed}                 3D
${WriteLed}                3E
${LedPayload}              
${ReadTrialLed}            41
${WriteTrialLed}           42
${TrialLedPayload}         
${ReadLedRamp}             45
${WriteLedRamp}            45
${LedRampPayload}          
${ReadBTSinkScan}          49
${WriteBTSinkScan}         4A
${BTSinkScanPayload}       
${ReadBTSinkChangePair}    51
${WriteBTSinkChangePair}    52
${BTSinkChangePairPayload}    
${ReadBTSinkName}          55
${ReadBTSourceName}        59
${ReadBTSlaveScan}         5D
${ReadBTSlaveChangePair}    65
${WriteBTSlaveChangePair}    66
${BTSlaveChangePairPayload}    
${ReadAnalytics}            69
${ReadAnalyticsExtended}    6D
${ReadDelay}                8D
${ReadLeftSubassembly}      95
${ReadRightSubassembly}     99
${ReadBTSinkMac}            9D
${ReadBTSourceMac}          A1
${ReadAuth}                 A5
${Read}


*** Test Cases ***
Initial Log
	Log To Console    Hello, World!

*** Comments ***
Name
	HopeLib.connect    ${Sony}    ${port}    #192.168.168.103    ${12345}
	${name}=    HopeLib.send    ${ReadName}                  ${empty}    none
	Log To Console    ${name}
#	Should Be Equal    ${name}    01031e536f756c7a0000000000000000000000000000000000000000000000000041    # Device name = Soulz
	${writename}=    HopeLib.send    ${WriteName}                  53393138    hex
	Should Be Equal    ${writename}    0104010179
	${name}=    HopeLib.send    ${ReadName}                  ${empty}    none
	Should Be Equal    ${name}    01031e53393138000000000000000000000000000000000000000000000000000069    # Device name = S918
	Sleep    5 secs


*** Test Cases ***
Info
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${infoResponse}=    HopeLib.send    ${ReadInfo}                  ${empty}    none
	Log To Console      ${infoResponse}
	Should Be Equal     ${infoResponse}    0107042710100528
	${writeInfo}=       HopeLib.send    ${WriteInfo}                  ${infoPayload}    hex
	Should Be Equal     ${writeInfo}    0108010175
#	${writeInfo}=       HopeLib.send    ${WriteInfo}                  ${infoPayload}    string
#	Should Be Equal     ${writeInfo}    0108010175
	Sleep    5 secs

*** Comments ***
Serial Number
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${serialResponse}=    HopeLib.send    ${ReadSerial}                   ${empty}    none
	Log To Console      ${serialResponse}
	Should Be Equal     ${serialResponse}    010b0c313233343536373839304142d8
	${writeSerial}=       HopeLib.send    ${WriteSerial}                  ${SerialPayloadHex}    hex
#	Should Be Equal     ${writeSerial}    010c010171
#	${writeSerial}=       HopeLib.send    ${WriteSerial}                  ${SerialPayload}    string
	Should Be Equal     ${writeSerial}    010c010171

*** Test Cases ***

SKU
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${serialResponse}=    HopeLib.send    ${ReadSku}                  ${empty}    none
	Log To Console      ${serialResponse}
	Should Be Equal     ${serialResponse}    010f0a3132333435363738393059
	${writeSku}=       HopeLib.send    ${WriteSku}                  ${SkuPayloadHex}    hex
#	Should Be Equal     ${writeSku}    010c010171
#	${writeSku}=       HopeLib.send    ${WriteSku}                  ${SkuPayload}    string
	Should Be Equal     ${writeSku}    010c010171

FwVersion
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${fwVersionResponse}=    HopeLib.send    ${ReadFwVersion}                  ${empty}    none
	Log To Console      ${fwVersionResponse}
	Should Be Equal     ${fwVersionResponse}    010f0a3132333435363738393059
	${writeFwVersion}=       HopeLib.send    ${WriteFwVersion}                  ${FwVersionPayloadHex}    hex
#	Should Be Equal     ${writeFwVersion}    010c010171
#	${writeFwVersion}=       HopeLib.send    ${WriteFwVersion}                  ${FwVersionPayload}    string
	Should Be Equal     ${writeFwVersion}    010c010171

PCBA (HW Rev)
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${hwRevResponse}=    HopeLib.send    ${ReadPCBA}                  ${empty}    none
	Log To Console      ${hwRevResponse}
	Should Be Equal     ${hwRevResponse}    010f0a3132333435363738393059
	${writeHwRev}=       HopeLib.send    ${WriteFwVersion}                  ${PCBAPayloadHex}    hex
#	Should Be Equal     ${writeHwRev}    010c010171
#	${writeHwRev}=       HopeLib.send    ${WriteFwVersion}                  ${PCBAPayload}    string
	Should Be Equal     ${writeHwRev}    010c010171

System Mac Address
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${sysMacResponse}=    HopeLib.send    ${ReadSystemMac}                  ${empty}    none
	Log To Console      ${sysMacResponse}
	Should Be Equal     ${sysMacResponse}    010f0a3132333435363738393059
	${writeSysMac}=       HopeLib.send    ${WriteFwVersion}                  ${SysMacPayloadHex}    hex
#	Should Be Equal     ${writeSysMac}    010c010171
#	${writeSysMac}=       HopeLib.send    ${WriteSysMac}                  ${SysMacPayload}    string
	Should Be Equal     ${writeSysMac}    010c010171

Battery Level
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${hwRevResponse}=    HopeLib.send    ${ReadBattery}                  ${empty}    none
	Log To Console      ${hwRevResponse}
	Should Be Equal     ${hwRevResponse}    010f0a3132333435363738393059

Digital Gain
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${digGainResponse}=    HopeLib.send    ${ReadDigitalGain}                  ${empty}    none
	Log To Console      ${digGainResponse}
	Should Be Equal     ${digGainResponse}    010f0a3132333435363738393059
	${writeDigGain}=       HopeLib.send    ${WriteDigitalGain}                  ${DigitalGainPayloadHex}    hex
#	Should Be Equal     ${writeDigGain}    010c010171
#	${writeDigGain}=       HopeLib.send    ${writeDigGain}                  ${DigitalGainPayload}    string
	Should Be Equal     ${writeDigGain}    010c010171

Gain Increment
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${writeGainInc}=       HopeLib.send    ${WriteGainIncrement}                  ${GainIncrementPayloadHex}    hex
#	Should Be Equal     ${writeGainInc}    010c010171
#	${writeGainInc}=       HopeLib.send    ${writeGainInc}                  ${GainIncrementPayload}      string
	Should Be Equal     ${writeGainInc}    010c010171

Play Status
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${PlayStatusResponse}=    HopeLib.send    ${ReadPlayStatus}                  ${empty}    none
	Log To Console      ${PlayStatusResponse}
	Should Be Equal     ${PlayStatusResponse}    010f0a3132333435363738393059
	${writePlayStatus}=       HopeLib.send    ${WritePlayStatus}                  ${PlayStautsPayloadHex}    hex
#	Should Be Equal     ${writePlayStatus}    010c010171
#	${writePlayStatus}=       HopeLib.send    ${WritePlayStatus}                  ${PlayStautsPayload}    string
	Should Be Equal     ${writePlayStatus}    010c010171

Effects
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${EffectsResponse}=    HopeLib.send    ${ReadEffects}                  ${empty}    none
	Log To Console      ${EffectsResponse}
	Should Be Equal     ${EffectsResponse}    010f0a3132333435363738393059
	${writeEffects}=       HopeLib.send    ${WriteEffects}                  ${EffectsPayloadHex}    hex
#	Should Be Equal     ${writeEffects}    010c010171
#	${writeEffects}=       HopeLib.send    ${WriteEffects}                  ${EffectsPayload}    string
	Should Be Equal     ${writeEffects}    010c010171

Transducer Intensity
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${IntensityResponse}=    HopeLib.send    ${ReadTransducerGain}                  ${empty}    none
	Log To Console      ${IntensityResponse}
	Should Be Equal     ${IntensityResponse}    010f0a3132333435363738393059
	${writeIntensity}=       HopeLib.send    ${WriteTransducerGain}                  ${TransducerGainPayloadHex}    hex
#	Should Be Equal     ${writeIntensity}    010c010171
#	${writeIntensity}=       HopeLib.send    ${WriteEffects}                  ${TransducerGainPayload}    string
	Should Be Equal     ${writeIntensity}    010c010171

FW Actions
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${writeFwActions}=       HopeLib.send    ${WriteFwActions}                  ${WriteFwActionsPayload}    hex
#	Should Be Equal     ${writeFwActions}    010c010171
#	${writeFwActions}=       HopeLib.send    ${WriteFwActions}                  ${WriteFwActionsPayload}    string
	Should Be Equal     ${writeFwActions}    010c010171

Extended Battery
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${extBatteryResponse}=    HopeLib.send    ${ReadExtendedBattery}                  ${empty}    none
	Log To Console      ${extBatteryResponse}
	Should Be Equal     ${extBatteryResponse}    010f0a3132333435363738393059

LED
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${LedResponse}=    HopeLib.send    ${ReadLed}                  ${empty}    none
	Log To Console      ${LedResponse}
	Should Be Equal     ${LedResponse}    010f0a3132333435363738393059
	${writeLed}=       HopeLib.send    ${WriteLed}                  ${LedPayloadHex}    hex
#	Should Be Equal     ${writeLed}    010c010171
#	${writeLed}=       HopeLib.send    ${WriteLed}                  ${LedPayload}    string
	Should Be Equal     ${writeLed}    010c010171

Trial LED
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${TrialLedResponse}=    HopeLib.send    ${ReadTrialLed}                  ${empty}    none
	Log To Console      ${TrialLedResponse}
	Should Be Equal     ${TrialLedResponse}    010f0a3132333435363738393059
	${writeTrialLed}=       HopeLib.send    ${WriteTrialLed}                  ${TrialLedPayloadHex}    hex
#	Should Be Equal     ${writeLed}    010c010171
#	${writeTrialLed}=       HopeLib.send    ${WriteTrialLed}                  ${TrialLedPayload}    string
	Should Be Equal     ${writeLed}    010c010171

LED Ramp
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${LedRampResponse}=    HopeLib.send    ${ReadLedRamp}                  ${empty}    none
	Log To Console      ${LedRampResponse}
	Should Be Equal     ${LedRampResponse}    010f0a3132333435363738393059
	${writeLedRamp}=       HopeLib.send    ${WriteLedRamp}                  ${LedRampPayloadHex}    hex
#	Should Be Equal     ${writeLedRamp}    010c010171
#	${writeLedRamp}=       HopeLib.send    ${WriteLedRamp}                  ${LedRampPayload}    string
	Should Be Equal     ${writeLedRamp}    010c010171

BT Sink Scan
	HopeLib.connect     ${Sony}    ${port}    #192.168.168.103    ${12345}
	${BTSinkScanResponse}=    HopeLib.send    ${ReadBTSinkScan}                  ${empty}    none
	Log To Console      ${BTSinkScanResponse}
	Should Be Equal     ${BTSinkScanResponse}    010f0a3132333435363738393059
	${writeBTSinkScan}=       HopeLib.send    ${WriteBTSinkScan}                  ${BTSinkScanPayloadHex}    hex
#	Should Be Equal     ${writeBTSinkScan}    010c010171
#	${writeBTSinkScan}=       HopeLib.send    ${WriteBTSinkScan}                  ${BTSinkScanPayload}    string
	Should Be Equal     ${writeBTSinkScan}    010c010171
