from GestorFiltros import GestorFiltros
from Cliente import Cliente
from Objetivo import Objetivo
from FiltroCalcularVelocidad import FiltroCalcularVelocidad
from FiltroRepercutirRozamiento import FiltroRepercutirRozamiento

salpicadero = Objetivo()
gestor = GestorFiltros(salpicadero)
filtro1 = FiltroCalcularVelocidad()
filtro2 = FiltroRepercutirRozamiento()
gestor.agregar_filtro(filtro1)
gestor.agregar_filtro(filtro2)
cliente = Cliente(gestor)
cliente.ejecutar()



