package Ejercicio1;

import java.util.ArrayList;

public class FactoriaCarretera implements FactoriaCarreraYBicicleta{

    @Override
    public Bicicleta crearBicicleta() {
        return new BicicletaCarretera();
        
    }

    @Override
    public Carrera crearCarrera(ArrayList<Bicicleta> bicis) {
        return new CarreraCarretera(bicis);
    }

}
