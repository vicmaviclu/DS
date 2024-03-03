package Ejercicio1;
public class BicicletaMontaña extends Bicicleta {
    private static int id = 0;

    public BicicletaMontaña() {
        super(id);
        ++id;
    }
}
