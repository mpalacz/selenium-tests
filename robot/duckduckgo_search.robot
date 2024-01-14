*** Settings ***
Documentation
...                 Robot opens duckduckgo.com, searches for ${SEARCH_QUERRY}
...                 and takes screenshot of results.
...                 ${BROWSER}: browser used for test
...                 ${SEARCH_QUERRY}: querry to be searched

Resource            kyewords.resource

Suite Setup
...                     Open Browser And Maximize Window
...                     https://www.duckduckgo.com/
...                     %{BROWSER}
Suite Teardown      Close All Browsers


*** Variables ***
${SEARCH_QUERRY}    robot framework


*** Test Cases ***
Search ${SEARCH_QUERRY}
    [Documentation]
    ...    Inputs ${SEARCH_QUERRY} into search bar and starts search.
    Log    Inputing ${SEARCH_QUERRY} into text area.
    ${search_bar}=    Get WebElement    //input[@id="searchbox_input"]
    Wait Until Element Is Visible    ${search_bar}
    Input Text    ${search_bar}    ${SEARCH_QUERRY}
    Log    Clicking search button.
    Click Button    //button[@aria-label='Search']
    Log    Successfully searched for ${SEARCH_QUERRY} in duckduckgo.

Get Link Of First Non Add Link
    [Documentation]
    ...    Inputs ${SEARCH_QUERRY} into search area and clicks search button.
    Skip If
    ...    '${PREV_TEST_STATUS}' == 'FAIL'
    ...    msg=Failed to input ${SEARCH_QUERRY} or click search button.
    Log    Collecting adress of first non ad result.
    Set Test Variable    
    ...    ${first_link_xpath}    
    ...    //article[@id="r1-0"]//a[@data-testid='result-extras-url-link']
    Wait Until Element Is Visible
    ...    ${first_link_xpath}
    ...    error=Firts non ad link is not visible.
    ${first_link}=    Get Element Attribute    
    ...    ${first_link_xpath}
    ...    href
    Log    First result is: ${first_link}

Take Screenshot Of Search Results
    [Documentation]    Takies screenshot of the search results.
    Skip If
    ...    '${PREV_TEST_STATUS}' == 'FAIL'
    ...    msg=Failed to get adress of first non ad result.
    Log    Taking screenshot of search results.
    Capture Page Screenshot    ${SEARCH_QUERRY.replace('/','-')}_results.png
    Log    Successfully took screenshot of search results.
