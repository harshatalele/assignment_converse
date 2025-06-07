
*** Variables ***
${profile_menu}    xpath://div[contains(@class, 'header-action-item-hoverable')]//div[contains(@class, 'text-2xl')]
${automation_library}    xpath://span[contains(text(), 'Automation Library')]
${automation_heading}    xpath://h2[contains(text(), 'Automation')]
${converse_servey_text}    xpath=//p[@class="converse_servey_text"]
${get_automation_button}    xpath://button[contains(text(), "Get this automation")]
${select_sender}    xpath://div[@id='senderId']
${page_load_on_automation_task}    xpath://div[@class='welcone-message-all-contnet-alignment']
${activate_button}    xpath://button[contains(text(), 'Activate')]
${confirmation_activation}    xpath://button[contains(text(),'OK')]
${flow_active}    xpath://div[contains(text(),'Active')]
${navigated_to_automation_library}    xpath://span[contains(text(),'Back')]
${enter_sender_text}    (//div[contains(@class, 'css-')])[1]