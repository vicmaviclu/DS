from CadenaFiltros import CadenaFiltros
import time
class GestorFiltros:
    def __init__(self, objetivo):
        self.cadena_filtros = CadenaFiltros(objetivo)

    def agregar_filtro(self, filtro):
        self.cadena_filtros.agregar_filtro(filtro)

    def ejecutar_peticion(self, estado_motor):
        print("Estado motor gestor: ", estado_motor)
        self.cadena_filtros.ejecutar_filtros(estado_motor)
