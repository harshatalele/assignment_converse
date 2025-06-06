*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    ../../utility/python_utilities/excelUtility.py
Resource   ../../utility/robot_utilities/common_utilities.robot
Library    Collections

*** Variables ***
${RAW_PATH}      ${CURDIR}${/}..${/}..${/}test_data${/}template_data.xlsx
${sheet_name}    Sheet1

*** Keywords ***

Get Template Locators From Excel
    [Documentation]    Reads template names from Excel and returns a list of XPath locators for each template.
    ${file_path}=    Normalize Path    ${RAW_PATH}
    ${template_names}=    Get Template Names From Excel    ${file_path}    ${sheet_name}
    ${locators}=    Create List
    FOR    ${template_name}    IN    @{template_names}
        ${locator}=    Set Variable    xpath=//p[@class="title-align" and text()="${template_name}"]
        Wait for element to appear on page    ${locator}
        Append To List    ${locators}    ${locator}
    END
    [Return]    ${locators}



# The following code handles cases where there are duplicate task names like "Staffing Appointment Assistant"
# It appends locators with an index to differentiate between multiple identical entries
#Get Template Locators From Excel
#    [Arguments]    ${file_path}    ${sheet_name}
#    ${template_names}=    Get Template Names From Excel    ${file_path}    ${sheet_name}
#    ${locators}=    Create List
#    ${index}=    Set Variable    1
#    FOR    ${template_name}    IN    @{template_names}
#        ${locator}=    Set Variable    (//p[@class="title-align" and text()="${template_name}"])[${index}]
#        Append To List    ${locators}    ${locator}
#        ${index}=    Evaluate    ${index} + 1
#    END
#    [Return]    ${locators}


