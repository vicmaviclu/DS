package Ejercicio1;
import java.util.ArrayList;

public class ejercicio1 {
    public static void main(String[] args) {
        final int N = 5;

        //  Carretera //////////////////////////////////////////////////////////////////
        // Crear Factoria de Carretera
        FactoriaCarreraYBicicleta factoriaCarretera = new FactoriaCarretera();
        // Añadir las bicis Carretera
        ArrayList<Bicicleta> bicicletasCarretera = new ArrayList<>();
        for(int i = 0; i < N; i++){
            Bicicleta bici = factoriaCarretera.crearBicicleta();
            bicicletasCarretera.add(bici);
        }
        // Crear Carrera Carretera
        Carrera carreraCarretera = factoriaCarretera.crearCarrera(bicicletasCarretera);

        //  Montaña ////////////////////////////////////////////////////////////////// 
        // Crear Factoria de Montaña
        FactoriaCarreraYBicicleta factoriaMontaña = new FactoriaMontaña();
        // Añadir las bicis Montaña
        ArrayList<Bicicleta> bicicletasMontaña = new ArrayList<>();
        for(int i = 0; i < N; i++){
            Bicicleta bici = factoriaMontaña.crearBicicleta();
            bicicletasMontaña.add(bici);
        }
        // Crear Carrera Montaña
        Carrera carreraMontaña = factoriaMontaña.crearCarrera(bicicletasMontaña);

        // Iniciar Carreras a la vez (no se como ayuda, tranquilo pookie, ya llegué)
        
        HiloCarrera threadCarretera = new HiloCarrera(carreraCarretera);
        HiloCarrera threadMontaña = new HiloCarrera(carreraMontaña);

        threadCarretera.setCarrera(carreraCarretera);
        threadMontaña.setCarrera(carreraMontaña);
        
        // Iniciar los hilos
        threadCarretera.start();
        threadMontaña.start();

        try {
            // Esperar a que ambos hilos terminen
            threadCarretera.join();
            threadMontaña.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
