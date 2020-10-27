**** Settings ***
Library                 Selenium2Library



*** Variables ***
${url_base}             http://automationpractice.com/index.php   


*** Keywords ***

Abrir navegador
   Open Browser                 ${url_base}        Chrome
   Maximize Browser Window

Quando faço a pesquisa por um produto existente
   [Arguments]       ${produto}
   Input Text         id:search_query_top         ${produto}
   Click Button       submit_search
Então devo ver o retorno:    
  [Arguments]               ${saida}
  Wait Until Page Contains           ${saida}     

Finalizar sessão
   Close Browser
