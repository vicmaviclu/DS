package Ejercicio1;

public class BicicletaCarretera extends Bicicleta{
    private static int id= 0;
    
    public BicicletaCarretera() {
        super(id);
        ++id;
    }

    @Override
    public String toString() {
        return ("Bicicleta de carretera con identificador de carrera " + getIdCarrera());
    }
}
