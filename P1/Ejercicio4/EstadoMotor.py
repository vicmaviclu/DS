from enum import Enum

# Posibles estados del motor
class EstadoMotor(Enum):
    APAGADO = 0
    ENCENDIDO = 1
    ACELERANDO = 2
    FRENANDO = 3