extends Node

var preto : Texture2D = preload("res://Imagens/preoUI.png")
var magenta : Texture2D = preload("res://Imagens/magentaUI.png")
var amarelo : Texture2D = preload("res://Imagens/amareloUI.png")
var ciano : Texture2D = preload("res://Imagens/cianoUI.png")

# VARIAVEIS GLOBAIS

# VARIAVEIS do PERSONAGEM

#ESTOQUE DE TINTAS	
var arrayTintas = [preto, magenta, amarelo, ciano]
var corAtual = 0
var barraEstoqueSize : float = 10

var maxTanque : float = 10

var tanqueTintaPreta : float = 10
var tanqueTintaMagenta : float = 10
var tanqueTintaAmarelo : float = 10
var tanqueTintaCiano : float = 10
