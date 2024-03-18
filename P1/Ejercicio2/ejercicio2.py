from FactoriaCarretera import FactoriaCarretera
from FactoriaMontaña import FactoriaMontaña

class Ejercicio2:
    def main(self):
        N = int(input("Por favor, introduzca un número entero de las bicicletas que participan en las carreras: "))

        # Carretera
        factoria_carretera = FactoriaCarretera()
        bici_carretera = factoria_carretera.crear_bicicleta()
        bicicletas_carretera = [bici_carretera.clone() for _ in range(N)]
        carrera_carretera = factoria_carretera.crear_carrera(bicicletas_carretera)

        # Montaña
        factoria_montaña = FactoriaMontaña()
        bici_montaña = factoria_montaña.crear_bicicleta()
        bicicletas_montaña = [bici_montaña.clone() for _ in range(N)]
        carrera_montaña = factoria_montaña.crear_carrera(bicicletas_montaña)

        # Empezar carreras
        carrera_carretera.empezar_carrera()
        carrera_montaña.empezar_carrera()

if __name__ == "__main__":
    ejercicio2 = Ejercicio2()
    ejercicio2.main()