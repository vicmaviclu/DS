package Ejercicio1;
import java.util.ArrayList;

public abstract class Carrera {
    private ArrayList<Bicicleta> bicicletas; //Array de bicicletas

    public Carrera(ArrayList<Bicicleta> bicicletas) {
        this.bicicletas = bicicletas;
    }

    public ArrayList<Bicicleta> getBicicletas() {
        return bicicletas;
    }

    public void setBicicletas(ArrayList<Bicicleta> bicicletas) {
        this.bicicletas = bicicletas;
    }

    public abstract void empezarCarrera() throws InterruptedException;
}
