*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-gpu");add_argument("--remote-debugging-port=9222")

*** Test Cases ***
Try access google
    ${timestamp}=    Get Current Date    result_format=timestamp
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --remote-debugging-port=9222
    Call Method    ${chrome_options}    add_argument    --user-data-dir=/tmp/chrome-${timestamp}
    
    Open Browser    https://www.google.com/    chrome    options=${chrome_options}
    Close Browser

# *** Keywords ***
# Open Google
#     Open Browser    https://www.google.com/    chrome
#     Maximize Browser Window

# Search on google
#     [Arguments]    ${val}
#     Input Text    //textarea[@id='APjFqb']    ${val}
#     Press Keys    //textarea[@id='APjFqb']    ENTER