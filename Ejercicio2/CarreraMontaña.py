import Carrera
import random

class CarreraMontaña(Carrera):
    def empezarCarrera(self):
        print(f"La carrera de Montaña ha comenzado con el siguiente número de bicicletas: {len(self.bicicletas)}")

        # Sleep for 60 seconds
        # time.sleep(60)

        # Remove 10% of the bicycles
        nEliminadas = int(len(self.bicicletas) * 0.10)
        for _ in range(nEliminadas):
            numeroAleatorio = random.randint(0, len(self.bicicletas) - 1)  # Generates a random number between 0 and size; (0, size]
            self.eliminarBicicleta(numeroAleatorio)

        print(f"La carrera de Montaña ha terminado con el siguiente número de bicicletas: {len(self.bicicletas)}")
        
        

