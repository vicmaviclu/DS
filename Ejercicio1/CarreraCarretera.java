package Ejercicio1;

import java.util.ArrayList;

public class CarreraCarretera extends Carrera {
    public CarreraCarretera(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }

    @Override
    public void empezarCarrera() throws InterruptedException{
        // Dormir durante 60 segundos
        //Thread.sleep(60000);
        // Eliminar el 10% de las bicis
        System.out.println("La carrera ha comenzado!");

        for (Bicicleta bicicleta : getBicicletas() ) {
            System.out.println("Bicicleta " + bicicleta.getIdCarrera() + " en la carrera de " + this.getClass().getSimpleName());
        }

        // Lógica adicional de la carrera (puede incluir comprobaciones de finalización, etc.)
        // ...

        System.out.println("La carrera ha terminado!");
    }
}
