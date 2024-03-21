from EstadoMotor import EstadoMotor  # Importar el enum desde el archivo EstadoMotor.pyç
from Filtro import Filtro  # Importar la clase abstracta Filtro desde el archivo Filtro.py

class FiltroCalcularVelocidad(Filtro):
    MAX_RPM = 5000  # Máximo de 5000 RPM
    
    # Diccionario con los incrementos de velocidad según el estado del motor
    INCREMENTOS_VELOCIDAD = {
        EstadoMotor.APAGADO: 0,
        EstadoMotor.ENCENDIDO: 0,
        EstadoMotor.FRENANDO: -100,
        EstadoMotor.ACELERANDO: 100,
    }

    def __init__(self):
        self.incremento_velocidad = 0

    def ejecutar(self, revoluciones, estado_motor):
        print(f"Estado motor filtro: {estado_motor}")
        self.incremento_velocidad = self.INCREMENTOS_VELOCIDAD[estado_motor]

        # Aplicar el incremento de velocidad y verificar el límite máximo
        revoluciones = min(revoluciones + self.incremento_velocidad, self.MAX_RPM)

        return revoluciones