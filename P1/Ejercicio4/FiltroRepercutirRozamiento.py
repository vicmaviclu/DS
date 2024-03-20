from EstadoMotor import EstadoMotor 
from Filtro import Filtro  # Importar la clase abstracta Filtro desde el archivo Filtro.py

class FiltroRepercutirRozamiento(Filtro):
    def __init__(self):
        self.rozamiento = 1

    def ejecutar(self, revoluciones, estado_motor):
        # Disminuir las revoluciones debido al rozamiento
        if estado_motor == EstadoMotor.ACELERANDO or estado_motor == EstadoMotor.FRENANDO:
            revoluciones -= self.rozamiento  # Cantidad fija considerada como la disminución de revoluciones debido al rozamiento
        else:
            revoluciones += 0  # No hay disminución de revoluciones

        revoluciones = max(revoluciones, 0) # Máximo de 5000 RPM
        return revoluciones