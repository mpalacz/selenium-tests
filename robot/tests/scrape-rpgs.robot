*** Settings ***
Documentation
...                 Robots reads all rpgs names from table and saves them into file as sql script.
...                 Robot created for help, during development of project at: https://github.com/mpalacz/RollOut
...                 The robot is raw. TODO: make it more universal

Resource            ../kyewords.resource

Suite Setup
...                     Open Browser And Maximize Window
...                     https://en.wikipedia.org/wiki/List_of_tabletop_role-playing_games
...                     %{BROWSER}
Suite Teardown      Close All Browsers


*** Test Cases ***
Get List Of RPGs
    @{rpgs_elements}=    Get WebElements    //div[@id='mw-content-text']//tr/td[1]//i[1]/a
    @{RPGS}=    Create List
    FOR    ${element}    IN    @{rpgs_elements}
        ${game_name}=    Get Text    ${element}
        Append To List    ${RPGS}    ${game_name}
    END
    Set Suite Variable    @{RPGS}

Create SQL Script
    ${file_text}=    Set Variable    INSERT INTO GameSystem (name) VALUES
    FOR    ${rpg}    IN    @{RPGS}
        ${file_text}=    Set Variable    ${file_text} ("${rpg}"),
    END
    ${file_text_length}=    Get Length    ${file_text}
    ${file_text}=
    ...    Set Variable
    ...    ${file_text.replace("'", "''").replace('"', "'")}[0:${file_text_length-1}];
    Create File
    ...    add_rpgs_to_db.sql
    ...    ${file_text}
