package Ejercicio1;
import java.util.ArrayList;

public abstract class Carrera {
    private ArrayList<Bicicleta> bicicletas; //Array de bicicletas

    public Carrera(ArrayList<Bicicleta> bicicletas) {
        this.bicicletas = bicicletas;
    }

}
