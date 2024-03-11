package Ejercicio1;

public abstract class Bicicleta {
    private int idCarrera;


    public Bicicleta(int id) {
        this.idCarrera = id;
    }

    public int getIdCarrera() {
        return idCarrera;
    }

    public void setIdCarrera(int idCarrera) {
        this.idCarrera = idCarrera;
    }

    // public abstract ArrayList<Bicicleta> crearBicicletas(int N);
    public abstract String toString();
}
