from EstadoMotor import EstadoMotor  # Importar el enum desde el archivo EstadoMotor.py

class FiltroCalcularVelocidad:
    def __init__(self):
        self.incremento_velocidad = 0

    def ejecutar(self, revoluciones, estado_motor):
        if estado_motor == EstadoMotor.APAGADO or estado_motor == EstadoMotor.ENCENDIDO:
            self.incremento_velocidad = 0
        elif estado_motor == EstadoMotor.FRENANDO:
            self.incremento_velocidad = -100
        elif estado_motor == EstadoMotor.ACELERANDO:
            self.incremento_velocidad = 100

        # Aplicar el incremento de velocidad y verificar el límite máximo
        revoluciones += self.incremento_velocidad
        revoluciones = min(revoluciones, 5000) # Máximo de 5000 RPM

        return revoluciones