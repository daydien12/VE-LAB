*** Settings ***
Library           BuiltIn

*** Keywords ***
Create Machine
    Execute Command    mach create
    Execute Command    machine LoadPlatformDescription ${MACHINE}
    Execute Command    sysbus LoadELF ${FIRMWARE}
    Execute Command    sysbus.cpu ExecutionMode SingleStepNonBlocking

Start Simulation
    Execute Command    start

Pause simulation
    Execute Command    pause

Quit Machine
    Execute Command    Clear

Run 1 Step
    ${return}=    Execute Command    sysbus.cpu Step
    [Return]    ${return}

Run steps
    [Arguments]    ${times}
    FOR    ${index}    IN RANGE    0    ${times}
        Run 1 step
    END

Set Register
    [Arguments]    ${register}    ${value}
    Execute Command    sysbus.cpu SetRegisterUnsafe ${register} ${value}

Get All Register
    ${return}=    Execute Command    sysbus.cpu GetRegistersValues
    Log    ${return}
    [Return]    ${return}

Copy Byte To RAM
    [Arguments]    ${address}    ${value}
    Execute Command    sysbus.sram WriteByte ${address} ${value}

Copy Byte To RAM Offset
    [Arguments]    ${address}    ${offset}    ${value}
    ${readAddress}    Evaluate    ${address}+${offset}
    Execute Command    sysbus.sram WriteByte ${readAddress} ${value}

Read Byte From RAM
    [Arguments]    ${address}
    ${return}=    Execute Command    sysbus.sram ReadByte ${address}
    [Return]    ${return}

Read Bytes From RAM
    [Arguments]    ${address}    ${number}
    ${return}=    Execute Command    sysbus.sram ReadBytes ${address} ${number}
    [Return]    ${return}

Read Byte From RAM Offset
    [Arguments]    ${address}    ${offset}
    ${readAddress}    Evaluate    ${address}+${offset}
    ${return}=    Execute Command    sysbus.sram ReadByte ${readAddress}
    [Return]    ${return}
