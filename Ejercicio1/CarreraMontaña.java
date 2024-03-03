package Ejercicio1;

import java.util.ArrayList;

public class CarreraMontaña  extends Carrera{
    public CarreraMontaña(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }

    @Override
    public void empezarCarrera() throws InterruptedException{
        // Dormir durante 60 segundos
        Thread.sleep(60000);
        // Eliminar el 20% de las bicis
    }
}
