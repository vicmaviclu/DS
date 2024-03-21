from GestorFiltros import GestorFiltros
from Cliente import Cliente
from Objetivo import Objetivo
from FiltroCalcularVelocidad import FiltroCalcularVelocidad
from FiltroRepercutirRozamiento import FiltroRepercutirRozamiento

def crear_filtros():
    # Crea instancias de FiltroCalcularVelocidad y FiltroRepercutirRozamiento
    filtro1 = FiltroCalcularVelocidad()
    filtro2 = FiltroRepercutirRozamiento()
    return [filtro1, filtro2]

def configurar_gestor(salpicadero, filtros):
    # Crea una instancia de GestorFiltros y agrega los filtros a él
    gestor = GestorFiltros(salpicadero)
    for filtro in filtros:
        gestor.agregar_filtro(filtro)
    return gestor

def iniciar_cliente(gestor):
    # Crea una instancia de Cliente y lo ejecuta con el gestor configurado
    cliente = Cliente(gestor)
    cliente.ejecutar()

if __name__ == "__main__":
    # Crea una instancia de Objetivo como el salpicadero
    salpicadero = Objetivo()
    # Crea una lista de filtros usando la función crear_filtros
    filtros = crear_filtros()
    # Configura el gestor con el salpicadero y los filtros
    gestor = configurar_gestor(salpicadero, filtros)
    # Inicia el cliente con el gestor configurado
    iniciar_cliente(gestor)



