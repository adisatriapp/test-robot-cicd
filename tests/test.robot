*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

Suite Setup    Set Selenium Timeouts

*** Variables ***
${TIMEOUT}    30 seconds

*** Test Cases ***
Try access google
    Open Google
    Search on google    Tahu Bulat
    Set Selenium Implicit Wait    ${TIMEOUT}

*** Keywords ***
Set Selenium Timeouts
    Set Selenium Speed    0.5
    Set Selenium Timeout    ${TIMEOUT}

Open Google
    Open Browser    https://www.google.com/    chrome    headless=True    disable-gpu=True    window-size=1920x1080
    Maximize Browser Window

Search on google
    [Arguments]    ${val}
    Input Text    //textarea[@id='APjFqb']    ${val}
    Press Keys    //textarea[@id='APjFqb']    ENTER
