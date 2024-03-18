package Ejercicio1;

import java.util.ArrayList;

public class FactoriaMontaña implements FactoriaCarreraYBicicleta {

    @Override
    public Bicicleta crearBicicleta() {
        return new BicicletaMontaña();
    }

    @Override
    public Carrera crearCarrera(ArrayList<Bicicleta> bicis) {
        return new CarreraMontaña(bicis);
    }

}
