*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${browser}    chrome
${url}    https://app.beconversive.com/app/#/conversive/usecase
*** Keywords ***

Open Browser To Login Page
    Set Selenium Speed    1
    Open Browser    ${url}   ${BROWSER}
    Maximize Browser Window
    Title Should Be    Conversive
    Sleep    5s