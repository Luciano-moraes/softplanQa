**** Settings ***
Library                 RequestsLibrary
Library                 Collections
Library                 JSONLibrary

Documentation 
...     ST1: Permitir o cadastro de livros.
...       Critérios de aceite:
...   No cadastro de livros, os seguintes campos devem ser informados: título,
...   descrição, número de páginas, resumo e data de publicação. Todos os campos são opcionais.
...     ST2: Retornar livros cadastrados.
...       Critérios de aceite:
...   No retorno devem ser exibidas as informações: título, descrição, número de páginas, resumo e data de publicação.
...     ST3: Retornar apenas um livro.
...       Critério de aceite:
...   Devem ser exibidas as informações do livro consultado.

*** Variables ***
${url_base}             https://fakerestapi.azurewebsites.net:443




*** Test Cases ***
ST1: Permitir o cadastro de livros
   Create session         mysession                 ${url_base} 
   ${body}=               Create dictionary         ID=320                 Title=livro1         Description=descricao livro        PageCount=233           Excerpt=ewrwerwere            PublishDate=2020-10-27
   ${header}=             Create dictionary         Content-Type=application/json     
   ${response}=           Post Request              mysession          /api/Books            data=${body}           headers=${header}

   log to console         ${response.status_code}
   log to console         ${response.content}

   ${status_code}=        convert to string         ${response.status_code}
   Should be equal        ${status_code}            200

   ${res_body}=           convert to string         ${response.content}
   Should contain         ${res_body}               livro1
   Should contain         ${res_body}               descricao livro

   ${json}         Convert String to JSON       ${response.content}
   ${title}             Get Value From Json          ${json}         $.Title
   ${descricao}         Get Value From Json          ${json}         $.Description
   ${PageCount}         Get Value From Json          ${json}         $.PageCount
   ${Excerpt}           Get Value From Json          ${json}         $.Excerpt  
   ${PublishDate}       Get Value From Json          ${json}         $.PublishDate                                             

ST2: Retornar livros cadastrados
   Create session         mysession                  ${url_base} 
   ${response}=           get Request                mysession          /api/Books
   log to console         ${response.status_code} 
   #log to console         ${response.content}   

   ${status_code}=        convert to string           ${response.status_code}
   Should be equal        ${status_code}              200
    

ST3: Retornar apenas um livro
   Create session         mysession                  ${url_base} 
   ${response}=           get Request                mysession          /api/Books/12 
   log to console         ${response.status_code}
   #log to console         ${response.content}    

   ${status_code}=        convert to string           ${response.status_code}
   Should be equal        ${status_code}              200

   ${json}         Convert String to JSON       ${response.content}
   ${Id}                Get Value From Json          ${json}         $.ID
   ${title}             Get Value From Json          ${json}         $.Title
   ${descricao}         Get Value From Json          ${json}         $.Description
   ${PageCount}         Get Value From Json          ${json}         $.PageCount
   ${Excerpt}           Get Value From Json          ${json}         $.Excerpt  
   ${PublishDate}       Get Value From Json          ${json}         $.PublishDate      




  
 


