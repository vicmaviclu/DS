package Ejercicio1;

public class BicicletaCarretera extends Bicicleta{
    private static int id= 0;
    
    public BicicletaCarretera() {
        super(id);
        ++id;
    }
/* 
    @Override
    public ArrayList<Bicicleta> crearBicicletas(int N){
        ArrayList<Bicicleta> bicicletas = new ArrayList<>();
        for(int i = 0; i < N; i++){
            bicicletas.add(new BicicletaCarretera());
        }
        return bicicletas;
    }
*/   
    @Override
    public String toString() {
        return ("Bicicleta de carretera con identificador de carrera " + getIdCarrera());
    }
}
