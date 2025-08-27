*** Settings ***
# Resource    ../resources/imports.resource
Resource    ../resources/google.resource

*** Test Cases ***
Try access google
    Open Google
    Search on google    Tahu Bulat