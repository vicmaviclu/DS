from EstadoMotor import EstadoMotor
import time

class CadenaFiltros:
    def __init__(self, objetivo):
        self.filtros = []
        self.objetivo = objetivo
        self.revoluciones=0

    def agregar_filtro(self, filtro):
        self.filtros.append(filtro)

    def ejecutar_filtros(self, estado_motor):
        
        while( estado_motor != EstadoMotor.APAGADO and estado_motor != EstadoMotor.ENCENDIDO):
            for filtro in self.filtros:
                self.revoluciones = filtro.ejecutar(self.revoluciones, estado_motor)
            
            self.objetivo.ejecutar(self.revoluciones)
            time.sleep(2)
        
