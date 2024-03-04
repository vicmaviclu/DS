import java.util.ArrayList;

import Ejercicio1.Bicicleta;
import Ejercicio1.Carrera;
import Ejercicio1.FactoriaCarreraYBicicleta;
import Ejercicio1.FactoriaCarretera;
import Ejercicio1.FactoriaMontaña;

public class ejercicio1 {
    public static void main(String[] args) {
        final int N = 10;

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
        Thread threadCarretera = new Thread(() -> {
            // Lógica de la carrera de carretera
            try {
                carreraCarretera.empezarCarrera();
            } catch (InterruptedException e) {
                e.printStackTrace(); // O manejar la excepción de otra manera
            }
        });

        Thread threadMontaña = new Thread(() -> {
            // Lógica de la carrera de montaña
            try {
                carreraMontaña.empezarCarrera();
            } catch (InterruptedException e) {
                e.printStackTrace(); // O manejar la excepción de otra manera
            }
        });

        // Iniciar los hilos
        threadCarretera.start();
        threadMontaña.start();
    }
}
