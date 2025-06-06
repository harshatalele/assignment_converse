*** Settings ***
Resource          ../../locators/locators.robot
Library    SeleniumLibrary


*** Keywords ***
Logout from the application
    Select user to click
    Click on Logout to sign off from application

Select user to click
    Click Element    ${click_user}
Click on Logout to sign off from application
    Click Element    ${sign_out}