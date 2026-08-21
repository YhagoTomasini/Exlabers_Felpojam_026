extends Node
#extends Resource

const SAVE_PATH := "user://saveInfo.tres"
#preload das imagens dos icones da ui de cada cor de tinta para deixar no array
#e permitir a funcionalidade do botão interativo que criei na ui
var preto : Texture2D = preload("res://Imagens/carimbos/preto_ui.png")
var magenta : Texture2D = preload("res://Imagens/carimbos/magenta2_ui.png")
var amarelo : Texture2D = preload("res://Imagens/carimbos/amarelo_ui.png")
var ciano : Texture2D = preload("res://Imagens/carimbos/azul_i.png")

# VARIAVEIS GLOBAIS
var dados : SaveInfo

#TINTAS
var arrayTintas = [preto] #só para os icones das cores na ui
var corAtual = 0
var barraEstoqueSize : float = 10

var maxTanque : float = 10

var tanqueTintaPreta : float = 10
var tanqueTintaMagenta : float = 10
var tanqueTintaAmarelo : float = 10
var tanqueTintaCiano : float = 10

var tanqueAtualPreta : float = 10
var tanqueAtualMagenta : float = 10
var tanqueAtualAmarelo : float = 10
var tanqueAtualCiano : float = 10


func saveTanqueCena():
	tanqueAtualPreta = tanqueTintaPreta
	tanqueAtualMagenta = tanqueTintaMagenta
	tanqueAtualAmarelo = tanqueTintaAmarelo
	tanqueAtualCiano = tanqueTintaCiano
	
func refil_de_tinta():
	tanqueTintaPreta = tanqueAtualPreta
	tanqueTintaMagenta = tanqueAtualMagenta
	tanqueTintaAmarelo = tanqueAtualAmarelo
	tanqueTintaCiano = tanqueAtualCiano
	
func reset_de_tinta():
	tanqueTintaPreta = 10
	tanqueTintaMagenta = 10
	tanqueTintaAmarelo = 10
	tanqueTintaCiano = 10
	
func novo_jogo():
	arrayTintas = [preto]
	
	reset_de_tinta()
	saveTanqueCena()

func speedRun():
	if !arrayTintas.has(amarelo):
		arrayTintas.append(amarelo)
	if !arrayTintas.has(magenta):
		arrayTintas.append(magenta)
	if !arrayTintas.has(ciano):
		arrayTintas.append(ciano)
	saveTanqueCena()
	
	
func felpses_counter(n : int):
	var index = n - 1
	
	if !dados.felps_contados[index]:
		dados.felps_contados[index] = true
		dados.totalFelps += 1
		
	if dados.totalFelps == dados.felps_contados.size():
		Achivements._liberar_conquista(4)
	
#sistema de save
func salvar_jogo():
	ResourceSaver.save(dados, SAVE_PATH)

func carregar_save():
	if ResourceLoader.exists(SAVE_PATH):
		dados = load(SAVE_PATH)
	else:
		dados = SaveInfo.new()

func apagar_save():
	dados = SaveInfo.new()
	salvar_jogo()
