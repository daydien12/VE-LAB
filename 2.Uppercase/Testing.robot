*** Settings ***

Resource    Renode-Common.robot

*** Variables ***
${MACHINE}     @platforms/cpus/stm32f103.repl
${FIRMWARE}    @${CURDIR}/main.elf


${LENGTH_RUN_1}         30
${STR_CMP_1}            H
${STR_LOAD_TO_RAM_1}    'h'

${LENGTH_RUN_2}         300
${STR_CMP_2}            XINCHAOBANNHETOILABIEN
${STR_LOAD_TO_RAM_2}    'xinchaobannhetoilabien'

${LENGTH_RUN_3}         500
${STR_CMP_3}            HOC VIEN CONG NGHE BUU CHINH VIEN THONG
${STR_LOAD_TO_RAM_3}    'hoc vien cong nghe buu chinh vien thong'


${LENGTH_RUN_4}         500
${STR_CMP_4}            HOC VIEN CONG NGHE BUU CHINH VIEN THONG
${STR_LOAD_TO_RAM_4}    'hoc vIen CONG nghe buu ChInH vien tHOng'

*** Test Cases ***
TC01: Simple String Check One Byte
    [Setup]                  Create Machine
    Start Simulation
    Copy String To RAM       0x10                   ${STR_LOAD_TO_RAM_1}    
    Run Steps                ${LENGTH_RUN_1}
    Pause Simulation
    ${length_str}            Get Length String      ${STR_CMP_1}
    ${read_to_ram}           Read Bytes From RAM    0x100                   ${length_str} 
    ${str2}                  String Conver          ${read_to_ram}
    ${str1}                  Create_List_String     ${STR_CMP_1}
    Lists Should Be Equal    ${str2}                ${str1}
    [Teardown]               Quit Machine


TC02: Long String Check
    [Setup]                  Create Machine
    Start Simulation
    Copy String To RAM       0x10                   ${STR_LOAD_TO_RAM_2}    
    Run Steps                ${LENGTH_RUN_2}
    Pause Simulation
    ${length_str}            Get Length String      ${STR_CMP_2}
    ${read_to_ram}           Read Bytes From RAM    0x100                   ${length_str} 
    ${str2}                  String Conver          ${read_to_ram}
    ${str1}                  Create_List_String     ${STR_CMP_2}
    Lists Should Be Equal    ${str2}                ${str1}
    [Teardown]               Quit Machine

TC03: Check String Spaces
    [Setup]                  Create Machine
    Start Simulation
    Copy String To RAM       0x10                   ${STR_LOAD_TO_RAM_3}    
    Run Steps                ${LENGTH_RUN_3}
    Pause Simulation
    ${length_str}            Get Length String      ${STR_CMP_3}
    ${read_to_ram}           Read Bytes From RAM    0x100                   ${length_str} 
    ${str2}                  String Conver          ${read_to_ram}
    ${str1}                  Create_List_String     ${STR_CMP_3}
    Lists Should Be Equal    ${str2}                ${str1}
    [Teardown]               Quit Machine

TC04: Check String Spaces And Uppercase
    [Setup]                  Create Machine
    Start Simulation
    Copy String To RAM       0x10                   ${STR_LOAD_TO_RAM_4}    
    Run Steps                ${LENGTH_RUN_4}
    Pause Simulation
    ${length_str}            Get Length String      ${STR_CMP_4}
    ${read_to_ram}           Read Bytes From RAM    0x100                   ${length_str} 
    ${str2}                  String Conver          ${read_to_ram}
    ${str1}                  Create_List_String     ${STR_CMP_4}
    Lists Should Be Equal    ${str2}                ${str1}
    [Teardown]               Quit Machine
