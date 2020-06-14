*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${baseurl}        https://www.noorbank.com/
${browser}        chrome

*** Test Cases ***
Logo and copy rights verification
    #Local browser launch
    Jenkins browser launch
    Element Should Be Visible    xpath=(.//a[@class='navbar-brand']/img)[1]
	    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Text Should Be    xpath=.//li[@class='copyrightss']    Copyright © Noor Bank PJSC. All Rights Reserved.
    Execute JavaScript    window.scrollTo(document.body.scrollHeight, 0)
	
header menu list and link redirection verification
    ${menu_list}=    Get Element Count    xpath=.//div[@id='navbarSupportedContent']/ul/li
    Should Be True    ${menu_list}>=7

Search
    Click Element    xpath=.//button[@class='openBtn']
    Input Text    id=edit-keys    ksngjdsnfjksdfj
    Click Element    id=edit-submit
    Element Should Be Visible    xpath=.//div[@class='col-md-12 search-result']/h3

header and footer verification
    Element Should Be Visible    xpath=.//header
    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Should Be Visible    xpath=.//footer

*** Keywords ***
Jenkins browser launch
    Set Selenium Speed    1s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${baseurl}
    Maximize Browser Window
    Set Browser Implicit Wait    15s

Local browser launch
    Set Selenium Speed    1s
    Open Browser    ${baseurl}    ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    15s
