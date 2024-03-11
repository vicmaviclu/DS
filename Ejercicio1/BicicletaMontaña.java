package Ejercicio1;

public class BicicletaMontaña extends Bicicleta {
    private static int id = 0;

    public BicicletaMontaña() {
        super(id);
        ++id;
    }
/* 
    @Override
    public ArrayList<Bicicleta> crearBicicletas(int N) {
        ArrayList<Bicicleta> bicicletas = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            bicicletas.add(new BicicletaMontaña());
        }
        return bicicletas;
    }
*/
    @Override
    public String toString() {
        return ("Bicicleta de montaña con identificador de carrera " + getIdCarrera());
    }
}
