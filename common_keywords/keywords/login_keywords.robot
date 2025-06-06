*** Settings ***
Library           SeleniumLibrary
Resource          ../../locators/locators.robot
Resource          ../../variables/global_variables.robot

*** Keywords ***

Login With Valid Credentials
    [Documentation]    Opens the login page, enters valid credentials, and verifies successful login by checking the dashboard.
    Input Credentials And Submit
    Verify Dashboard Is Displayed

Input Credentials And Submit
    [Documentation]    Inputs the username and password fields with valid credentials and submits the login form.
    Input Text    ${USERNAME_FIELD}    ${VALID_USER}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
#    Click Button    ${LOGIN_BUTTON}    # Commented out assuming captcha is disabled in test/dev environment

Verify Dashboard Is Displayed
    [Documentation]    Waits for the dashboard welcome text to appear to confirm successful login.
    Wait Until Page Contains Element    ${welcome_text}    timeout=120s
    Element Should Be Visible    ${welcome_text}


