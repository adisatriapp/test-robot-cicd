*** Settings ***
Resource    ../resources/imports.robot

Test Setup      Start Headless Browser
Test Teardown   Close Browser


*** Test Cases ***
Run Page Check
    [Documentation]  This test will check if a certain text 
    ...  can be found on a certain page.
    Check if ${URL} contains ${TEXT}


