class CadenaFiltros:
    def __init__(self):
        self.filtros = []

    def agregar_filtro(self, filtro):
        self.filtros.append(filtro)

    def ejecutar_filtros(self, revoluciones, estado_motor):
        revoluciones_actualizadas = revoluciones
        for filtro in self.filtros:
            revoluciones_actualizadas = filtro.ejecutar(revoluciones_actualizadas, estado_motor)
        return revoluciones_actualizadas