*** Variables ***
${USERNAME_FIELD}       xpath://input[@type="email"]
${PASSWORD_FIELD}       xpath://input[@type="password"]
${LOGIN_BUTTON}         xpath://button[@type='submit']
${DASHBOARD_HEADER}     xpath://h1[text()='Dashboard']
${welcome_text}    xpath://h3[contains(text(),'Welcome ')]
${click_user}    xpath://div[@class='text-xs capitalize']
${sign_out}    xpath://span[contains(text(),'Sign Out')]

