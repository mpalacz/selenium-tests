*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Wait And Click
    [Documentation]    
    ...    Waits unlit element is visible and clicks it.
    ...    ${xpath}: Xpath to element.
    ...    ${timeout}: Time after keywords fails 
    ...    when element is not visible. Defaults to 15s.
    ...    ${error}: Message disaplyed when element is not visible.
    [Arguments]    
    ...    ${xpath}    
    ...    ${timeout}=15    
    ...    ${error}=Element is not visible after ${timeout} seconds.   
    Wait Until Element Is Visible    ${xpath}    ${timeout}    ${error}
    Click Element    ${xpath} 
