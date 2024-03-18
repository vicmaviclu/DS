package Ejercicio1;
import java.util.ArrayList;
import java.util.Scanner;

public class ejercicio1 {
    public static void main(String[] args) {
        // Pedir el número de bicicletas por terminal y comprobar si es un entero
        Scanner scanner = new Scanner(System.in);
        int N = 0;
        System.out.println("Por favor, introduzca un número entero de las bicicletas que participan en las carreras:");
        while (!scanner.hasNextInt()) { // Devuelve true si el valor introducido es un entero
            System.out.println("Eso no es un número entero. Por favor, introduzca un número entero:");
            scanner.next(); // Elimina la entrada incorrecta
        }
        N = scanner.nextInt();
        scanner.close();

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

