package Ejercicio1;

import java.util.ArrayList;

public class CarreraCarretera extends Carrera {
    public CarreraCarretera(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }

    @Override
    public void empezarCarrera() throws InterruptedException{
        // Dormir durante 60 segundos
        Thread.sleep(60000);
        // Eliminar el 10% de las bicis
    }
}
