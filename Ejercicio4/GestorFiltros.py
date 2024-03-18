from CadenaFiltros import CadenaFiltros

class GestorFiltros:
    def __init__(self):
        self.cadena_filtros = CadenaFiltros()

    def agregar_filtro(self, filtro):
        self.cadena_filtros.agregar_filtro(filtro)

    def ejecutar_peticion_filtros(self, revoluciones, estado_motor):
        return self.cadena_filtros.ejecutar_filtros(revoluciones, estado_motor)
