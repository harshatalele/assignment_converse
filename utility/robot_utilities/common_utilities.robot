*** Settings ***
Library    SeleniumLibrary
Resource   ../../locators/automation_locators.robot


*** Keywords ***
Verify Heading Is Present
    [Documentation]    Waits until the element identified by ${locator} is visible, then verifies it is visible.
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Element Should Be Visible        ${locator}


Verify Automation heading when opened
    [Documentation]    Retrieves the text from the automation heading locator and logs it.
    ${value}=    Get Text From Locator    ${converse_servey_text}
    Log         The text is: ${value}


Get Text From Locator
    [Documentation]    Returns the text content of the element identified by ${locator}.
    [Arguments]    ${locator}
    ${text}=    Get Text    ${locator}
    [Return]    ${text}


Wait for element to appear on page
    [Arguments]    ${locator}
    Wait Until Element Is Visible        ${locator}    timeout=5s
