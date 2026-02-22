extends Node

#preload das imagens dos icones da ui de cada cor de tinta para deixar no array
#e permitir a funcionalidade do botão interativo que criei na ui
var preto : Texture2D = preload("res://Imagens/carimbos/preto.png")
var magenta : Texture2D = preload("res://Imagens/carimbos/magenta2.png")
var amarelo : Texture2D = preload("res://Imagens/carimbos/amarelo.png")
var ciano : Texture2D = preload("res://Imagens/carimbos/azul.png")

# VARIAVEIS GLOBAIS

# VARIAVEIS do PERSONAGEM

#TINTAS
var arrayTintas = [preto] #só para os icones das cores na ui
var corAtual = 0
var barraEstoqueSize : float = 10

var maxTanque : float = 10

var tanqueTintaPreta : float = 10
var tanqueTintaMagenta : float = 10
var tanqueTintaAmarelo : float = 10
var tanqueTintaCiano : float = 10

func refil_de_tinta():
	tanqueTintaPreta = 10
	tanqueTintaMagenta = 10
	tanqueTintaAmarelo = 10
	tanqueTintaCiano = 10
