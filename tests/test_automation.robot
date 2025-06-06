*** Settings ***
# Resource files containing reusable keywords for login and automation
Resource    ../common_keywords/keywords/login_keywords.robot
Resource    ../common_keywords/keywords/automation_keywords.robot
Resource    ../common_keywords/keywords/logout.robot
Test Setup    Open Browser To Login Page
Test Teardown    Close Browser
Resource    ../common_resources/resources.robot
# SeleniumLibrary to interact with web browsers
Library    SeleniumLibrary


*** Test Cases ***
Verify user is able to navigate to Automation page
    [Documentation]    This test verifies that a user can successfully log in,
    ...                perform automation-related activities, and navigate
    ...                to the Automation Tasks page.

    Login With Valid Credentials
    Perform Automation Activities
    Click On Automation Tasks
    Logout from the application