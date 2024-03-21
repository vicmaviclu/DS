from EstadoMotor import EstadoMotor
import time

class CadenaFiltros:
    def __init__(self, objetivo):
        self.filtros = []
        self.objetivo = objetivo
        self.revoluciones=0
        self.estado_motor = EstadoMotor.APAGADO

    def agregar_filtro(self, filtro):
        # Agrega un nuevo filtro a la lista de filtros
        self.filtros.append(filtro)

    def ejecutar_filtros(self, estado_motor):
        # Ejecuta los filtros mientras el estado del motor sea ACELERANDO o FRENANDO
        self.estado_motor = estado_motor
        while self.estado_motor in (EstadoMotor.ACELERANDO, EstadoMotor.FRENANDO):
            self.ejecutar_operaciones(estado_motor)
            time.sleep(2)
        self.ejecutar_operaciones(estado_motor)

    def ejecutar_operaciones(self, estado_motor):
        # Ejecuta las operaciones dependiendo del estado del motor
        if self.estado_motor == EstadoMotor.APAGADO:
            self.revoluciones = 0
        else:
            for filtro in self.filtros:
                self.revoluciones = filtro.ejecutar(self.revoluciones, estado_motor)
        self.objetivo.ejecutar(self.revoluciones, estado_motor)
