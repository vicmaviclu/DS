import tkinter as tk
from EstadoMotor import EstadoMotor
import os
import json
import tkinter as tk

class Velocimetro(tk.Frame):
    def __init__(self, master, revoluciones):
        super().__init__(master, bg="white", padx=10, pady=10)        
        self.label_velocimetro = tk.Label(self, text="Velocímetro", font=("Arial", 12, "bold"), bg="white")
        self.label_velocimetro.pack()
        self.label_km_h = tk.Label(self, text="", font=("Arial", 12), bg="white")  # Define self.label_km_h aquí
        self.label_km_h.pack()
        self.actualizar(revoluciones)

    def actualizar(self, revoluciones):
        valor_km_h = self.calcular_velocidad(revoluciones)
        self.label_km_h.config(text="{} km/h".format(valor_km_h))

    def calcular_velocidad(self, revoluciones):
        return int(2 * 3.141592 * 0.15 * revoluciones * (60 / 1000))


class CuentaKilometros(tk.Frame):
    def __init__(self, master):
        super().__init__(master, bg="white", padx=10, pady=10)
        self.label_cuentakilometros = tk.Label(self, text="Cuentakilómetros", font=("Arial", 12, "bold"), bg="white")
        self.label_cuentakilometros.pack()

        # Carga los valores desde el archivo
        if os.path.exists('P1/Ejercicio4/datos.json'):
            with open('P1/Ejercicio4/datos.json', 'r') as f:
                datos = json.load(f)
                self.valor_total = datos['valor_total']
        else:
            self.valor_total = 0

        self.valor_reciente = 0
        self.label_reciente = tk.Label(self, text="Reciente: {} km".format(self.valor_reciente), font=("Arial", 10), bg="white")
        self.label_reciente.pack()

        self.label_total = tk.Label(self, text="Total: {} km".format(self.valor_total), font=("Arial", 10), bg="white")
        self.label_total.pack()
    
    def actualizar(self, velocidad):
        # Actualiza los valores en la interfaz de usuario
        distancia_total = abs((velocidad / 3600)) * 2  # distancia en km, multiplicada por 2 porque la función se llama cada 2 segundos
        self.valor_reciente += distancia_total
        self.valor_total += distancia_total
        
        self.label_reciente.config(text="Reciente: {} km".format(self.valor_reciente))
        self.label_total.config(text="Total: {} km".format(self.valor_total))

        # Guarda los valores en el archivo para uso futuro
        with open('P1\Ejercicio4\datos.json', 'w') as f:
            json.dump({'valor_total': self.valor_total}, f)  

class CuentaRevoluciones(tk.Frame):
    def __init__(self, master, revoluciones):
        super().__init__(master, bg="white", padx=10, pady=10)
        self.label_cuentarrevoluciones = tk.Label(self, text="Cuentarrevoluciones", font=("Arial", 12, "bold"), bg="white")
        self.label_cuentarrevoluciones.pack()
        self.valor_rpm = revoluciones
        self.label_rpm = tk.Label(self, text="{} RPM".format(self.valor_rpm), font=("Arial", 10), bg="white")
        self.label_rpm.pack()


class Objetivo:
    def __init__(self):
        self.root = None
        self.revoluciones = 0
        self.EstadoMotor = EstadoMotor.APAGADO

        self.root = tk.Tk()
        self.root.title("Salpicadero")

        # Marco principal para el salpicadero
        self.marco_salpicadero = tk.Frame(self.root, bg="lightgrey", padx=20, pady=20)
        self.marco_salpicadero.pack()

        # Etiqueta para el título del salpicadero
        self.etiqueta_salpicadero = tk.Label(self.marco_salpicadero, text="Salpicadero", font=("Arial", 16, "bold"), bg="lightgrey")
        self.etiqueta_salpicadero.pack()

        # Instancias de los componentes del salpicadero
        self.velocimetro = Velocimetro(self.marco_salpicadero, self.revoluciones)
        self.velocimetro.pack(pady=10)

        self.cuenta_kilometros = CuentaKilometros(self.marco_salpicadero)
        self.cuenta_kilometros.pack(pady=10)

        self.cuenta_revoluciones = CuentaRevoluciones(self.marco_salpicadero, self.revoluciones)
        self.cuenta_revoluciones.pack(pady=10)

    def ejecutar(self, revoluciones, estadomotor):
        # Ejecuta el salpicadero con las revoluciones y el estado del motor proporcionados.
        self.revoluciones = revoluciones
        self.EstadoMotor = estadomotor

        if self.root is None:
            self.root.mainloop()
        self.actualizar_datos()

    def actualizar_datos(self):
        # Método que actualiza los datos del salpicadero según el estado del motor.
        if self.EstadoMotor == EstadoMotor.ACELERANDO or self.EstadoMotor == EstadoMotor.FRENANDO:
            self.actualizar_salpicadero()
            self.root.update()
        elif self.EstadoMotor == EstadoMotor.APAGADO:
            self.resetear_salpicadero()

    def actualizar_salpicadero(self):
        # Actualiza los datos del salpicadero.
        self.velocimetro.actualizar(self.revoluciones)
        self.actualizar_cuenta_revoluciones()
        self.cuenta_kilometros.actualizar(self.velocimetro.calcular_velocidad(self.revoluciones))

    def resetear_salpicadero(self):
        # Reinicia los datos del salpicadero cuando el motor está apagado.
        self.velocimetro.label_km_h.config(text="0 km/h")
        self.cuenta_revoluciones.label_rpm.config(text="0 RPM")
        self.cuenta_kilometros.label_reciente.config(text="Reciente: 0 km")
        self.revoluciones = 0

    def calcular_velocidad(self):
        # Calcula la velocidad en kilómetros por hora.
        return int(2 * 3.141592 * 0.15 * self.revoluciones * (60 / 1000))

    def actualizar_velocimetro(self, velocidad):
        # Actualiza la velocidad en el velocímetro.
        self.velocimetro.label_km_h.config(text="{} km/h".format(velocidad))

    def actualizar_cuenta_revoluciones(self):
        # Actualiza las revoluciones en el cuenta revoluciones.
        self.cuenta_revoluciones.label_rpm.config(text="{} RPM".format(self.revoluciones))


    
