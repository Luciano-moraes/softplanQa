**** Settings ***
Library                  Selenium2Library
Suite Setup              Abrir navegador
Suite Teardown           Finalizar sessão
Resource                 common.robot


*** Variables *** 
${produto}              dresses
${prod_I}               calça


*** Test Cases ***

Deve ser possível consultar os produtos cadastrados por meio de um campo de pesquisa
   Dado que estou no campo de pesquisa  
   Quando pesquiso um produto      ${produto}
   Então retorna produto           ${produto}

Quando nenhum produto for encontrado, deve ser exibida a mensagem: "No results were found for your search '{TEXTO DA PESQUISA}'
   Dado que estou no campo de pesquisa  
   Quando pesquiso produto inexistente      ${prod_I}
   Então deve aparecer msg                  ${prod_I}  

Ao realizar uma pesquisa, deve ser exibido o total de resultados  
   Dado que estou no campo de pesquisa  
   Quando pesquiso um produto                 ${produto}
   Então deve exibido o total de resultados   ${produto}

Os resultados devem ser exibidos em formato de grid e lista
   Dado que estou no campo de pesquisa 
   Quando pesquiso um produto                 ${produto}
   Então posso fazer consulta formato Grid
   E posso fazer em formato Lista

Deve ser exibido o total de itens e quantidade por página
   Dado que estou no campo de pesquisa 
   Quando pesquiso um produto                     ${produto}
   Então devo ver total de itens e qtd po página   ${produto}

*** Keywords ***

Dado que estou no campo de pesquisa
   Mouse Down       id:search_query_top  

Quando pesquiso um produto 
   [Arguments]         ${produto}     
   Input Text         id:search_query_top         ${produto}
   Click Button       submit_search

Então retorna produto
   [Arguments]       ${result}
   Page should Contain      ${result}

Quando pesquiso produto inexistente 
   [Arguments]         ${prod_I}     
   Input Text         id:search_query_top         ${prod_I}
   Click Button       submit_search

Então deve aparecer msg    
   [Arguments]         ${prod_I}      
   ${text}=      get text       //*[@id="center_column"]/p
   log to console        ${text}
   Should be equal       ${text}         No results were found for your search "${prod_I}"  
   
Então deve exibido o total de resultados  
   [Arguments]          ${produto}     
   ${total}=      get text         //*[@id="center_column"]/h1/span[2]
   log to console         ${total}
 
Então posso fazer consulta formato Grid
   Click Element                 id:grid

E posso fazer em formato Lista
   Click Element              id:list

Então devo ver total de itens e qtd po página
   [Arguments]          ${produto}     
   ${pagina}=      get text         //*[@id="center_column"]/div[1]/div[2]/div[2]
   log to console         ${pagina}



