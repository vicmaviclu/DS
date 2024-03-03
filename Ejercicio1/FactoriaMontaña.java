package Ejercicio1;

import java.util.ArrayList;

public class FactoriaMontaña implements FactoriaCarreraYBicicleta {

    @Override
    public Bicicleta crearBicicleta() {
        Bicicleta bici = new BicicletaMontaña();
        return bici;
    }

    @Override
    public Carrera crearCarrera(ArrayList<Bicicleta> bicis) {
        Carrera carrera = new CarreraMontaña(bicis);
        return carrera;
    }

}
