from EstadoMotor import EstadoMotor  # Importar el enum desde el archivo EstadoMotor.pyç
from Filtro import Filtro  # Importar la clase abstracta Filtro desde el archivo Filtro.py

class FiltroCalcularVelocidad(Filtro):
    MAX_RPM = 5000  # Máximo de 5000 RPM
    def __init__(self):
        self.incremento_velocidad = 0

    def ejecutar(self, revoluciones, estado_motor):
        print("Estado motor filtro: ", estado_motor)
        if estado_motor == EstadoMotor.APAGADO or estado_motor == EstadoMotor.ENCENDIDO:
            self.incremento_velocidad = 0
        elif estado_motor == EstadoMotor.FRENANDO:
            self.incremento_velocidad = -100
        elif estado_motor == EstadoMotor.ACELERANDO:
            self.incremento_velocidad = 100

        # Aplicar el incremento de velocidad y verificar el límite máximo
        revoluciones += self.incremento_velocidad
        revoluciones = min(revoluciones, FiltroCalcularVelocidad.MAX_RPM) 

        return revoluciones