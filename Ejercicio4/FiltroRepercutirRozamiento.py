from EstadoMotor import EstadoMotor 

class FiltroRepercutirRozamiento:
    def __init__(self):
        pass

    def ejecutar(self, revoluciones, estado_motor):
        # Disminuir las revoluciones debido al rozamiento
        revoluciones -= 1  # Cantidad fija considerada como la disminución de revoluciones debido al rozamiento
        return revoluciones