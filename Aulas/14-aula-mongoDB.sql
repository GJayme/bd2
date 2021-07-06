show dbs

use aula

db.clientes.insertOne(
{
    "_id" : 7,
    "nome" : "Luciano do Vale",
    "cpf" : "563.876.987-08",
    "telefones" : {
        "Celular" : {
            "ddd" : 19,
            "numero" : "76569-0900"
        }
    },
    "enderecos" : {
        "casa" : {
            "rua" : "R. das Árvores, 4356",
            "bairro" : "Jd. do Bosque",
            "cidade" : "Campinas",
            "uf" : "SP",
            "cep" : "19087-099"
        },
        "trabalho" : {
            "rua" : "R. Presidente Vargas, 177",
            "cidade" : "Campinas",
            "uf" : "SP",
            "cep" : "19876-564"
        }
    },
    "metodos" : {
        "metodo1" : {
            "tipo" : "Cartão",
            "numero" : "546478349876",
            "validade" : "08/23",
            "nome_impresso" : "LUCIANO DO VALE"
        }
    },
    "pedidos" : [
    {
        "numero" : 113,
        "data" : "16/07/2020",
        "total" : 168.5,
        "itens" : [ {
            "codigo" : "S0001",
            "descricao" : "Sapato de Couro Milano",
            "preco" : 125.5,
            "cor" : "Marrom",
            "tamanho" : 42,
            "qtde" : 1
            },
            {
            "codigo" : "L00012",
            "descricao" : "Sapato de Couro Milano",
            "preco" : 43,
            "paginas" : 273,
            "capa" : "Dura",
            "editora" : "Ática",
            "edição" : 2
            }
],
"endereco_entrega" : {
"rua" : "R. das Árvores, 4356",
"bairro" : "Jd. do Bosque",
"cidade" : "Campinas",
"uf" : "SP",
"cep" : "19087-099"
},
"metodo_pagamento" : {
"tipo" : "Cartão",
"numero" : "546478349876",
"validade" : "08/23",
"nome_impresso" : "LUCIANO DO VALE"
}
}
]
}
)

db.clientes.update({"_id" : 7},
{$push : {"pedidos":
{
"numero" : 189,
"data" : "21/05/2020",
"total" : 168.5,
"itens" : [ {
"codigo" : 1675432876,
"descricao" : "A Garota do Lago",
"tipo" : "livro",
"preco" : 39.75,
"Autor" : "Zé da Silva",
"paginas" : 228,
"edicao" : 2,
"editora" : "Pearson"
}
],
"endereco_entrega" : {
"rua" : "R. das Árvores, 4356",
"bairro" : "Jd. do Bosque",
"cidade" : "Campinas",
"uf" : "SP",
"cep" : "19087-099"
},
"metodo_pagamento" : {
"tipo" : "Cartão",
"numero" : "546478349876",
"validade" : "08/23",
"nome_impresso" : "LUCIANO DO VALE"
}
}
}
}
)

db.clientes.update({"_id" : 7, "pedidos.numero" : 189},
{$push : {"pedidos.$.itens":
    {
        "codigo" : 17846632876,
        "descricao" : "A Última Música",
        "tipo" : "livro",
        "preco" : 45.00,
        "Autor" : "Nicholas Spark",
        "paginas" : 287
    }}})


db.clientes.find()

db.clientes.insertOne(
    {
        "_id" : 8,
        "nome" : "Roberto Luis de Andrade",
        "cpf" : "123.543.3767-99",
        "telefones" : {
        "Celular" : {
        "ddd" : 19,
        "numero" : "76569-0900"
    }
    },
    "enderecos" : {
        "casa" : {
            "rua" : "R. das Árvores, 4356",
            "bairro" : "Jd. do Bosque",
            "cidade" : "Campinas",
            "uf" : "SP",
            "cep" : "19087-099"
    }
},
"metodos" : {
"metodo1" : {
"tipo" : "Cartão",
"numero" : "111987652224",
"validade" : "12/24",
"nome_impresso" : "ROBERTO L ANDRADE"
}
},
"pedidos" : []
}
)

db.pedidos.insertOne(
{
    "_id" : 11,
    "id_cliente" : 8,
    "data" : ISODate("2020-08-22"),
    "total" : 2756.48,
    "itens" : [
        {
            "codigo" : 13456,
            "descricao" : "TV Samsung 4K 42",
            "preco" : 2723.78,
            "polegadas" : 42,
            "marca" : "Samsung",
            "dimensoes" : "105 x 60 x 5",
            "qtde" : 1
        },
        {
            "codigo" : 654532,
            "descricao" : "Rei Leão",
            "preco" : 32.7,
            "tipo" : "DVD",
            "lancamento" : 2018,
            "duracao" : "118 min",
            "produtora" : "Disney"
        }
    ],
    "endereco_entrega" : {
        "rua" : "R. das Árvores, 4356",
        "bairro" : "Jd. do Bosque",
        "cidade" : "Campinas",
        "uf" : "SP",
        "cep" : "19087-099"
    },
    "metodo_pagamento" : {
        "tipo" : "Cartão",
        "numero" : "111987652224",
        "validade" : "12/24",
        "nome_impresso" : "ROBERTO L ANDRADE"
    },
    "status" : "Aprovado"
    }
)

db.clientes.update({"_id":8}, {$push : {"pedidos": 11}})

db.clientes.find()
db.pedidos.find()

db.pedidos.insertOne(
{
"_id" : 15,
"id_cliente" : 8,
"data" : ISODate("2020-08-23"),
"total" : 168.5,
"itens" : [
{
"codigo" : 76544,
"descricao" : "Smartphome Samsung S10 Plus",
"preco" : 2825.5,
"marca" : "Samsung",
"modelo": "S10 Plus",
"dimensoes" : "20 x 8 x 3",
"memoria" : "128 Gb",
"processador" : "octacore",
"qtde" : 1
}
],
"endereco_entrega" : {
"rua" : "R. das Árvores, 4356",
"bairro" : "Jd. do Bosque",
"cidade" : "Campinas",
"uf" : "SP",
"cep" : "19087-099"
},
"metodo_pagamento" : {
"tipo" : "Cartão",
"numero" : "111987652224",
"validade" : "12/24",
"nome_impresso" : "ROBERTO L ANDRADE"
},
"status" : "Aprovado"
}
)

db.clientes.update({"_id":8}, {$push : {"pedidos": 15}})

db.pedidos.insertOne(
{
"_id" : 24,
"id_cliente" : 8,
"data" : new Date("2020-06-21"),
"total" : 168.5,
"itens" : [
{
"codigo" : 76544,
"descricao" : "Smartphome Motorola G5",
"preco" : 1430,
"marca" : "Motorola",
"modelo": "G5 Maxx",
"dimensoes" : "20 x 8 x 3",
"memoria" : "32 Gb",
"processador" : "dualcore",
"qtde" : 2
}
],
"endereco_entrega" : {
"rua" : "R. das Árvores, 4356",
"bairro" : "Jd. do Bosque",
"cidade" : "Campinas",
"uf" : "SP",
"cep" : "19087-099"
},
"metodo_pagamento" : {
"tipo" : "Cartão",
"numero" : "111987652224",
"validade" : "12/24",
"nome_impresso" : "ROBERTO L ANDRADE"
},
"status" : "Aprovado"
}
)

db.clientes.update({"_id":8}, {$push : {"pedidos": 24}})

db.clientes.find()

// buscar usando operador IN
db.pedidos.find({"_id": { $in: [11,15]}})

// buscar utilizando maior que
db.pedidos.find({"data": {$gt: ISODate("2020-08-01")}})

//buscar utilizando maior ou igual
db.pedidos.find({"data": {$gte: ISODate("2020-08-01")}})

// buscar utilizando menor que
db.pedidos.find({"data": {$lt: ISODate("2020-08-01")}})

//buscar utilizando menor ou igual
db.pedidos.find({"data": {$lte: ISODate("2020-08-01")}})

//buscar por intervalo
db.pedidos.find({"data": {$gte: ISODate("2020-08-01"), $lte: ISODate("2020-08-31")}})

//find sempre retorna toda a collection
db.pedidos.find({"itens.marca": "Samsung"})

//operador de igualdade
db.pedidos.find({"itens.qtde": {$gte: 2}})

//alterando valor de algum campo, deve utilizar o operador $set
db.pedidos.update({"_id": 24}, {$set: {"status": "Cancelado"}})
db.pedidos.update({"_id": 24}, {$set: {"data_cancelamento": new Date("2021-07-05")}})

//apagar dados
db.pedidos.deleteOne({"_id":24})
db.pedidos.find()

//apagar mais de um
db.pedidos.deleteMany({"id_cliente": 8})

//remove, porém deprecated
db.pedidos.remove({})

//apagar collections
db.pedidos.drop()
db.clientes.drop()

show collections

//apagar database
db.dropDatabase()
show dbs