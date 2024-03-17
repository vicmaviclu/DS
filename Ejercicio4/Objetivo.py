from EstadoMotor import EstadoMotor 

class Objetivo:
    def __init__(self):
        pass

    def ejecutar(self, revoluciones, estado_motor):
        # Modificar parámetros de movimiento del vehículo en el salpicadero
        # Utilizar las revoluciones recalculadas teniendo en cuenta el estado del vehículo y el rozamiento
        # Aquí deberías implementar la lógica para modificar la velocidad angular, la velocidad lineal y la distancia recorrida
        velocidad_angular = revoluciones  # Aquí se asume que la velocidad angular es igual a las revoluciones
        velocidad_lineal = revoluciones * 2 * 3.1416 * 0.15 * (60/1000)  # Calcular la velocidad lineal a partir de las revoluciones (fórmula proporcionada)
        distancia_recorrida = velocidad_lineal / 60  # Calcular la distancia recorrida (suponiendo que la velocidad lineal está en km/h y la distancia en km)

        # Devolver los parámetros modificados
        return velocidad_angular, velocidad_lineal, distancia_recorrida
