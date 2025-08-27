*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Try access google
    Open Browser    https://www.google.com/    chrome

# *** Keywords ***
# Open Google
#     Open Browser    https://www.google.com/    chrome
#     Maximize Browser Window

# Search on google
#     [Arguments]    ${val}
#     Input Text    //textarea[@id='APjFqb']    ${val}
#     Press Keys    //textarea[@id='APjFqb']    ENTER