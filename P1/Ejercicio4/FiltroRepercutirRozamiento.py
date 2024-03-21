from Filtro import Filtro 

class FiltroRepercutirRozamiento(Filtro):
    def __init__(self):
        self.rozamiento = 1

    def ejecutar(self, revoluciones, estado_motor):
        # Disminuir las revoluciones debido al rozamiento
        revoluciones -= self.rozamiento

        # Asegurarse de que las revoluciones no sean menos de 0
        revoluciones = max(revoluciones, 0)
        return revoluciones