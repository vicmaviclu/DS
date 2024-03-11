package Ejercicio1;

import java.util.ArrayList;
import java.util.Random;

public class CarreraCarretera extends Carrera {
    public CarreraCarretera(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }

    @Override
    public void empezarCarrera() throws InterruptedException{
        System.out.println("La carrera de Carretera ha comenzado con el siguiente número de bicicletas: " + getBicicletas().size());
        
        // Dormir durante 60 segundos        
        //Thread.sleep(60000);
        
        // Eliminar el 10% de las bicicletas
        Random random = new Random();
        int nEliminadas = (int) (getBicicletas().size() * 0.10);
        for(int i = 0; i < nEliminadas; i++){
            int numeroAleatorio = random.nextInt(getBicicletas().size()); // Genera un numero aleatorio entre 0 y size; (0, size]
            eliminarBicicleta(numeroAleatorio);
        }

        System.out.println("La carrera de Carretera ha terminado con el siguiente número de bicicletas: " + getBicicletas().size());
    }
}
