from EstadoMotor import EstadoMotor
import time

class CadenaFiltros:
    def __init__(self, objetivo):
        self.filtros = []
        self.objetivo = objetivo
        self.revoluciones=0
        self.estado_motor = EstadoMotor.APAGADO

    def agregar_filtro(self, filtro):
        self.filtros.append(filtro)

    def ejecutar_filtros(self, estado_motor):
        self.estado_motor = estado_motor
        while self.estado_motor == EstadoMotor.ACELERANDO or self.estado_motor == EstadoMotor.FRENANDO:
            for filtro in self.filtros:
                self.revoluciones = filtro.ejecutar(self.revoluciones, estado_motor)
        
            self.objetivo.ejecutar(self.revoluciones, estado_motor)
            time.sleep(2)        
