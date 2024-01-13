*** Settings ***
Documentation
...                 Robot opens google.com, searches for ${SEARCH_QUERRY}
...                 and takes screenshot of results.
...                 ${SEARCH_QUERRY}: querry to be searched
...                 ${BROWSER}: browser used for test

Resource            kyewords.resource

Suite Setup         Open Browser    https://www.google.com/    ${BROWSER}
Suite Teardown      Close All Browsers


*** Variables ***
%{BROWSER}
${SEARCH_QUERRY}    robot framework


*** Test Cases ***
Reject Cookies
    [Documentation]    Rejects google coockie policy.
    Log    Rejecting cookies policy.
    Wait And Click    //button[@id="W0wltc"]    error=Failed to reject
    Log    Successfully rejected cookies polity.

Search ${SEARCH_QUERRY}
    [Documentation]
    ...    Inputs ${SEARCH_QUERRY} into search bar and starts search.
    Log    Inputing ${SEARCH_QUERRY} into text area.
    Set Test Variable    ${search_bar}    //textarea[@id="APjFqb"]
    Wait Until Element Is Visible    ${search_bar}
    Input Text    ${search_bar}    ${SEARCH_QUERRY}
    Log    Clicking search button.
    Wait And Click    //div[@jsname='VlcLAe']//input[@name='btnK']
    Log    Successfully searched for ${SEARCH_QUERRY} in google.

Get Link Of First Non Add Link
    [Documentation]
    ...    Inputs ${SEARCH_QUERRY} into search area and clicks search button.
    Log    Collecting adress of first non ad result.
    Set Test Variable    ${first_link_xpath}    (//cite)[1]
    Wait Until Element Is Visible
    ...    ${first_link_xpath}
    ...    error=Firts non ad link is not visible.
    ${first_link}=    Get Text    ${first_link_xpath}
    Log    First result is: ${first_link.replace('"','')}

Take Screenshot Of Search Results
    [Documentation]    Takies screenshot of the search results.
    Log    Taking screenshot of search results.
    Capture Page Screenshot    ${SEARCH_QUERRY.replace('/','-')}_results.png
    Log    Successfully took screenshot of search results.
