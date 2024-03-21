from CadenaFiltros import CadenaFiltros

class GestorFiltros:
    def __init__(self, objetivo):
        self.cadena_filtros = CadenaFiltros(objetivo)  # Inicializamos la cadena de filtros con el objetivo

    # Método para agregar un nuevo filtro a la cadena de filtros
    def agregar_filtro(self, filtro):
        self.cadena_filtros.agregar_filtro(filtro) 

    # Método para ejecutar la petición, pasando el estado del motor
    def ejecutar_peticion(self, estado_motor):
        # print("Estado motor gestor: ", estado_motor)  # Imprimimos el estado del motor
        self.cadena_filtros.ejecutar_filtros(estado_motor)  # Ejecutamos los filtros con el estado del motor
