package Ejercicio1;

import java.util.ArrayList;
import java.util.Random;

public class CarreraCarretera extends Carrera {
    public CarreraCarretera(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }

    @Override
    public void empezarCarrera() throws InterruptedException{
        // Dormir durante 60 segundos
        //Thread.sleep(60000);
        // Eliminar el 10% de las bicis
        Random random = new Random();
        int nEliminadas = (int) (getBicicletas().size() * 0.10);
        for(int i = 0; i < nEliminadas; i++){
            int numeroAleatorio = random.nextInt(nEliminadas + 1 - i); // Genera un numero aleatorio entre 0 y nEliminadas -i o sea todo el espacio del array; (0, nEliminadas)
            eliminarBicicleta(numeroAleatorio);
        }

        System.out.println("La carrera ha comenzado!");

        for (Bicicleta bicicleta : getBicicletas() ) {
            System.out.println("Bicicleta " + bicicleta.getIdCarrera() + " en la carrera de " + this.getClass().getSimpleName());
        }

        // Lógica adicional de la carrera (puede incluir comprobaciones de finalización, etc.)
        // ...

        System.out.println("La carrera ha terminado!");
    }
}
