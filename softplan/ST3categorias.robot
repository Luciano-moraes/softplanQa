**** Settings ***
Library                 Selenium2Library
Suite Setup              Abrir navegador
Suite Teardown           Finalizar sessão
Resource                 common.robot


*** Variables ***
${menuWoman}            xpath://*[@id="block_top_menu"]/ul/li[1]/a
${menuDresses}          xpath://*[@id="block_top_menu"]/ul/li[2]/a
${ProdTshirt}           xpath://*[@id="block_top_menu"]/ul/li[1]/ul/li[1]/ul/li[1]/a 

*** Test Cases ***

Devem ser exibidos os menus Woman, Dress e T-shirts
  verificar menus             Women
  verificar menus             Dresses
  verificar menus             T-shirts

No menu Woman
  Dado que estou no menu Woman
  Entao deve conter as categorias T-shirts e Blouses, e Dresses, com as categorias Casual Dresses, Evening Dresses e Summer Dresses
  Clicar em produto T-shirts

No menu Dresses 
  Dado que estou no menu Dresses
  Então devem ser exibidas as categorias CASUAL DRESSES, EVENING DRESSES e SUMMER DRESSES


*** Keywords ***

verificar menus
  [Arguments]               ${menu}   
  Page Should contain               ${menu} 

Dado que estou no menu Woman
  Mouse Down           ${menuWoman}

Entao deve conter as categorias T-shirts e Blouses, e Dresses, com as categorias Casual Dresses, Evening Dresses e Summer Dresses
  Page Should contain       T-shirts    
  Page Should contain       Blouses  
  Page Should contain       Dresses
  Page Should contain       Casual Dresses
  Page Should contain       Evening Dresses
  Page Should contain       Summer Dresses

Dado que estou no menu Dresses
  Mouse Down           ${menuDresses} 

Então devem ser exibidas as categorias CASUAL DRESSES, EVENING DRESSES e SUMMER DRESSES
  Page Should contain       Casual Dresses  
  Page Should contain       Evening Dresses
  Page Should contain       Summer Dresses

Clicar em produto T-shirts
  Mouse Down                       ${menuWoman}
  click Element                    ${ProdTshirt} 
  Page Should contain              T-shirts


