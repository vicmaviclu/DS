package Ejercicio1;

import java.util.ArrayList;

public class FactoriaCarretera implements FactoriaCarreraYBicicleta{

    @Override
    public Bicicleta crearBicicleta() {
        Bicicleta bici = new BicicletaCarretera();
        return bici;
    }

    @Override
    public Carrera crearCarrera(ArrayList<Bicicleta> bicis) {
        Carrera carrera = new CarreraCarretera(bicis);
        return carrera;
    }

}
