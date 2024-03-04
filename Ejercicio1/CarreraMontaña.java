package Ejercicio1;

import java.util.ArrayList;
import java.util.Random;

public class CarreraMontaña  extends Carrera {
    public CarreraMontaña(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }

    @Override
    public void empezarCarrera() throws InterruptedException{
        System.out.println("La carrera ha comenzado!");
        
        // Dormir durante 60 segundos        
        //Thread.sleep(60000);
        
        // Eliminar el 20% de las bicicletas
        Random random = new Random();
        int nEliminadas = (int) (getBicicletas().size() * 0.20);
        for(int i = 0; i < nEliminadas; i++){
            int numeroAleatorio = random.nextInt(nEliminadas + 1 - i); // Genera un numero aleatorio entre 0 y nEliminadas -i o sea todo el espacio del array; (0, nEliminadas)
            eliminarBicicleta(numeroAleatorio);
        }

        System.out.println("La carrera ha terminado!");
    }
}
