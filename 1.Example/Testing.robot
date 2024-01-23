*** Settings ***

Resource          Renode-Common.robot

*** Variables ***
${MACHINE}        @platforms/cpus/stm32f103.repl
${FIRMWARE}       @${CURDIR}/main.elf
${LENGTH_RUN}     30

${R2}       0x00000068

${R6_OLD}       0x12345678
${R6_NEW}       0x00000041

${R5_OLD}       0xAAAAAAAA
${R5_NEW}       0x0000596F


${R4_OLD}       0x55555555
${R4_NEW}       0x69565555

${R3_OLD}       0x00000000
${R3_NEW}       0x20230101
${a}    hello
@{my_list1}    1    2    3    4
@{my_list2}    1    2    3    4
*** Test Cases ***

Divide Numbers
    ${result}   divide    4   2
    ${result1}   test    ${my_list1}    ${my_list2}  
    #Print    ${result1}  0
TC00: Test2
    Print    'BIENNQ1111'    0

    [Setup]    Create Machine
    Start Simulation
    Copy String To RAM   0x100    'hello'
    ${read_to_ram}     Read Bytes From RAM     0x100   5
    Check Type Data     ${read_to_ram}
    Print    ${read_to_ram}    0

    #-----------------------------------------------------------------------#

    ${str2}    delete space     ${read_to_ram}
    Check Type Data      ${str2}
    Print    ${str2}    0
    ${str1}     Create_List_String  ${a}
    Lists Should Be Equal   ${str2}    ${str1}

    [Teardown]    Quit Machine
    