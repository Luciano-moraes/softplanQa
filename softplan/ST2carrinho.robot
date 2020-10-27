**** Settings ***
Library                 Selenium2Library
Suite Setup              Abrir navegador
Suite Teardown           Finalizar sessão
Resource                 common.robot


Documentation
...     ST2: Utilizar o carrinho de compras para adicionar e remover produtos.
...   Critérios de aceite:
...  Quando o carrinho estiver vazio, deve ser exibida a mensagem: “Your shopping cart is empty
...  Ao adicionar um produto ao carrinho, o usuário deve ser questionado se deseja continuar comprando ou finalizar a compra
...  Ao acessar o carrinho, deve ser possível excluir os produtos;
...  No carrinho deve ser exibido o preço unitário do produto, total e a quantidade;
...  Deve ser exibido o total da compra.



*** Variables ***
${cart}        xpath://*[@id="header"]/div[3]/div/div/div[3]/div/a
${vlUnitario}          $16.51
${vlTotal}             $18.51
${vlQtd}               1

*** Test Cases ***

Quando o carrinho estiver vazio, deve ser exibida a mensagem: “Your shopping cart is empty
  Dado que estou sem produto no carrinho
  Quando vou no carrinho
  Então devo ver a msg    Your shopping cart is empty.

Ao adicionar um produto ao carrinho, o usuário deve ser questionado se deseja continuar comprando ou finalizar a compra
  Dado que adiciono produto carrinho       t-shirt
  Quando vou no carrinho
  Então devo ver a msg             Continue shopping
  Então devo ver a msg             Proceed to checkout

No carrinho deve ser exibido o preço unitário do produto, total e a quantidade
  Quando vou no carrinho
  Então posso ver valor unitário
  E valor total
  E quantidade de produtos

Ao acessar o carrinho, deve ser possível excluir os produtos  
  Quando vou no carrinho
  Então devo poder excluir produto
 
*** Keywords ***

Dado que estou sem produto no carrinho
  go to                       ${url_base}?controller=order

Quando vou no carrinho
  Click Element                css:div[class=shopping_cart]
   
Então devo ver a msg  
  [Arguments]                  ${mensagem} 
  Wait Until Page contains     ${mensagem}  

Dado que adiciono produto carrinho
   [Arguments]                 ${produto}  
   Input Text                  id:search_query_top         ${produto}
   Click Button                submit_search
   Click Element               id:list
   click Element               //a[@class="button ajax_add_to_cart_button btn btn-default"]
   sleep                 2
   Execute JavaScript          document.querySelector(".cross").click()
  
Então devo poder excluir produto
   Mouse Down                  ${cart} 
   Execute JavaScript          document.querySelector(".remove_link a").click()
   sleep                 2

Então posso ver valor unitário
    Mouse Down                   ${cart} 
    ${unitario}=                  Execute Javascript            return document.querySelector('.price').textContent
    Log to Console                ${unitario}
    Should Be Equal               ${unitario}          ${vlUnitario}  

E valor total
   ${total}=                      Execute Javascript             return document.querySelector('.cart_block_total').textContent
   Log to Console                 ${total}
   Should Be Equal                ${total}             ${vlTotal}   

E quantidade de produtos
   ${qtd}=                        Execute Javascript             return document.querySelector('.quantity').textContent
   Log to Console                 ${qtd}
   Should Be Equal                ${qtd}               ${vlQtd}    



