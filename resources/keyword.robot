*** Settings ***
Library    SeleniumLibrary
Variables    ../test-data/data.py
Resource    imports.robot

*** Variables ***
@{chrome_arguments}    --disable-infobars    --headless
...    --disable-gpu   --no-sandbox   --window-size=1920,1080

*** Keywords ***
Check if ${URL} contains ${TEXT}
    Log  Check if ${URL} contains "${TEXT}"  console=True
    Wait Until Page Contains Element  //*[contains(text(),'${TEXT}')]

Start Headless Browser
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}   add_argument    headless
    Call Method    ${chrome_options}   add_argument    disable-gpu
    ${options}=     Call Method     ${chrome_options}    to_capabilities
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${URL}
    
Open Chrome With Options
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    start-maximized
    ${options}=    Call Method    ${chrome_options}    to_capabilities
    ${chrome_options}=    Set Chrome Options

    ${driver}=    Create Webdriver    Chrome    options=${chrome_options}
    Register Keyword To Run On Failure    ${driver}

    Go To    ${URL}
    Sleep    5s
    Close Browser

Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR    ${option}    IN    @{chrome_arguments}
        Call Method    ${options}    add_argument    ${option}
    END
    [Return]    ${options}