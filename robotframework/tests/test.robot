*** Settings ***
Resource    ../resources/keyword.resource

Test Setup      Start Headless Browser
Test Teardown   Close Browser


*** Test Cases ***
Run Page Check
    [Documentation]  This test will find tahu bulat on google
    Search Tahu Bulat on Google


