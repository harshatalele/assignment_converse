*** Settings ***
# Import SeleniumLibrary for browser automation
Library           SeleniumLibrary
Test Setup    Open Browser To Login Page
Test Teardown    Close Browser
# Import login keywords from external resource file
Resource          ../common_keywords/keywords/login_keywords.robot
Resource    ../common_keywords/keywords/logout.robot
Resource    ../common_resources/resources.robot



*** Test Cases ***
Login to application Credentials
    [Documentation]    Validate login functionality using correct username and password.

    Login with valid credentials
    Logout from the application
