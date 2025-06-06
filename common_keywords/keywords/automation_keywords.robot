*** Settings ***
Library        SeleniumLibrary
Resource    ../../locators/automation_locators.robot
Resource    ../../utility/robot_utilities/common_utilities.robot
Resource    ../../utility/robot_utilities/excelUtility.robot


*** Variables ***
${OPTION_TEXT}             WEB-DEMO-80051954 (Webchat)  # can be automated through excel
*** Keywords ***
Perform automation activities
    [Documentation]    Navigate to Automation Library and verify the page heading
    Click Element    ${profile_menu}
    Click Element    ${automation_library}
    Verify Heading Is Present    ${automation_heading}    5s

Click On Automation Tasks
    [Documentation]    Trigger the process to click on automation templates read from Excel.
    Click Templates From Excel

Click Templates From Excel
    [Documentation]    Retrieve all template locators from Excel and click each template sequentially.
    ${locators}=    Get Template Locators From Excel
    FOR    ${locator}    IN    @{locators}
        Log    Clicking: ${locator}
        Click Element    ${locator}
        Sleep    2s
        Perform Automation Task
    END

Perform automation task
   [Documentation]    Execute automation task workflow after selecting a template.
   Verify Automation heading when opened
   Click Button       ${get_automation_button}
   Wait Until Page Contains Element   ${page_load_on_automation_task}    timeout=5s
   Select Sender ID From Dropdown
   Click Button    ${activate_button}
   Wait Until Page Contains    Confirm Automation Activation
   Click Button    ${confirmation_activation}
   Verify Account Is Activated
   Click Element    ${navigated_to_automation_library}

Select Sender ID From Dropdown
    [Documentation]    Select a sender ID from dropdown before activating automation.
    Click Element                    ${select_sender}
    Sleep                            1s                         # Optional: give dropdown time to render
    Click Element                    xpath=//div[contains(@class,"option") and text()="${OPTION_TEXT}"]

Verify Account is activated
    [Documentation]    Confirm that automation activation succeeded by checking the status.
    Wait Until Page Contains    Active    timeout=3s
