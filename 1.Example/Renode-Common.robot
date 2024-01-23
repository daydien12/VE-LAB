*** Settings ***
Library           BuiltIn
Library           CustomLibrary.py
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

Print
    [Arguments]    ${string}    ${value}
    Log To Console    ${string}
    FOR    ${index}    IN RANGE    ${value}
        Log To Console     ${string}    # one, two, three
    END

Run steps
    [Arguments]    ${times}
    FOR    ${index}    IN RANGE    0    ${times}
        Run 1 step
    END

Set Register
    [Arguments]    ${register}    ${value}
    Execute Command    sysbus.cpu SetRegisterUnsafe ${register} ${value}

Get Register
    [Arguments]    ${register} 
    ${return}=    Execute Command    sysbus.cpu GetRegisterUnsafe ${register} 
    Log To Console    ${return}
    [Return]    ${return}

Get All Register
    ${return}=    Execute Command    sysbus.cpu GetRegistersValues
    Log To Console    ${return}
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
    #Log To Console  ${return}
    [Return]    ${return}

Read Byte From RAM Offset
    [Arguments]    ${address}    ${offset}
    ${readAddress}    Evaluate    ${address}+${offset}
    ${return}=    Execute Command    sysbus.sram ReadByte ${readAddress}
    [Return]    ${return}


String To Bytes
    [Arguments]    ${input_string}
    ${result_bytes}=    Evaluate    bytearray([ord(c) for c in "${input_string}"])
    [Return]    ${result_bytes}

Copy String To RAM
    [Arguments]    ${address}    ${value}
    Execute Command    sysbus.sram WriteString ${address} ${value}

Check Type Data 
    [Arguments]     ${type_data}
    ${type string}=    Evaluate     type(${type_data})
    Log To Console     ${type string}

# Convert List To Int Array
#     [Arguments]    ${input_list}
#     ${int_array}=    Evaluate    list(map(int, ${input_list}))    modules=python
#     [Return]    ${int_array}

# Convert List To Int Array
#     [Arguments]    ${input_list}
#     ${int_array}=    Evaluate    [int(x, 0) for x in ${input_list}]
#     [Return]    ${int_array}

Convert List To Int Array
    [Arguments]    @{input_list}
    ${int_array}=    Evaluate    [eval(x) for x in $input_list]
    [Return]    ${int_array}
