# Luz

Apenas um desafio proposto pela empresa em questão.


## Installation

Clonar o repositório e rodar:

   $ bundle

Tem 2 formas de rodar a aplicação, a primeira delas é sem instalar a gem:

   $ ruby -Ilib ./bin/luz coupons.csv products.csv orders.csv order_items.csv outuput.csv
   
E caso deseje instalar a gem

   $ rake install
   $ luz coupons.csv products.csv orders.csv order_items.csv outuput.csv

Para executar os testes:

    $ rspec
