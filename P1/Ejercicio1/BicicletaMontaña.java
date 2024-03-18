package Ejercicio1;

public class BicicletaMontaña extends Bicicleta {
    private static int id = 0;

    public BicicletaMontaña() {
        super(id);
        ++id;
    }

    @Override
    public String toString() {
        return ("Bicicleta de montaña con identificador de carrera " + getIdCarrera());
    }
}
