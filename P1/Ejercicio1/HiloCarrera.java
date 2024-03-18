package Ejercicio1;

public class HiloCarrera extends Thread {
    private Carrera carrera;

    public HiloCarrera(Carrera carrera) {
        this.carrera = carrera;
    }
    @Override
    public void run() {
        try{
            carrera.empezarCarrera();
        }catch (InterruptedException e){
            e.printStackTrace();
        }      
    }

    public void setCarrera(Carrera carrera) {
        this.carrera = carrera;
    }
}