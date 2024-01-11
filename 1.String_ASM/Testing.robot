*** Settings ***
Resource          Renode-Common.robot

*** Variables ***
${MACHINE}        @platforms/cpus/stm32f103.repl
${FIRMWARE}       @${CURDIR}/main.elf
${LENGTH_RUN}     15
${R6_OLD}       0x12345678
${R6_NEW}       0x00000041

${R5_OLD}       0xAAAAAAAA
${R5_NEW}       0x0000596F


${R4_OLD}       0x55555555
${R4_NEW}       0x69565555

${R3_OLD}       0x00000000
${R3_NEW}       0x20230101

*** Test Cases ***
TC01: Check R6
    [Setup]    Create Machine
    Start Simulation
    Set Register    6   ${R6_OLD}
    Run Steps    ${LENGTH_RUN}
    Pause Simulation
    Register Should Be Equal  6  ${R6_NEW}
    [Teardown]    Quit Machine


TC02: Check R5
    [Setup]    Create Machine
    Start Simulation
    Set Register    5   ${R5_OLD}
    Run Steps    ${LENGTH_RUN}
    Pause Simulation
    Register Should Be Equal  5  ${R5_NEW}
    [Teardown]    Quit Machine


TC03: Check R4
    [Setup]    Create Machine
    Start Simulation
    Set Register    4   ${R4_OLD}
    Run Steps    ${LENGTH_RUN}
    Pause Simulation
    Register Should Be Equal  4  ${R4_NEW}
    [Teardown]    Quit Machine


TC04: Check R3
    [Setup]    Create Machine
    Start Simulation
    Set Register    3   ${R3_OLD}
    Run Steps    ${LENGTH_RUN}
    Pause Simulation
    Register Should Be Equal  3  ${R3_NEW}
    [Teardown]    Quit Machine
