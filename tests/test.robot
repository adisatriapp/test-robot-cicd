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

*** Keywords ***
Set Selenium Timeouts
    Set Selenium Speed    0.5
    Set Selenium Timeout    30 seconds

Open Google
    Open Browser    https://www.google.com/    chrome    headless=True
    Maximize Browser Window

Search on google
    [Arguments]    ${val}
    Input Text    //textarea[@id='APjFqb']    ${val}
    Press Keys    //textarea[@id='APjFqb']    ENTER
