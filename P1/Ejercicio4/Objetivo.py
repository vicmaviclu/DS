import tkinter as tk
from EstadoMotor import EstadoMotor
import os
import json

class Velocimetro(tk.Frame):
    def __init__(self, master, revoluciones):
        super().__init__(master, bg="white", padx=10, pady=10)        

        self.label_velocimetro = tk.Label(self, text="Velocímetro", font=("Arial", 12, "bold"), bg="white")
        self.label_velocimetro.pack()
        self.valor_km_h = 2 * 3.141592 * 0.15 * revoluciones * (60 / 1000)
        self.label_km_h = tk.Label(self, text="{} km/h".format(self.valor_km_h), font=("Arial", 10), bg="white")
        self.label_km_h.pack()


class CuentaKilometros(tk.Frame):
    def __init__(self, master):
        super().__init__(master, bg="white", padx=10, pady=10)
        self.label_cuentakilometros = tk.Label(self, text="Cuentakilómetros", font=("Arial", 12, "bold"), bg="white")
        self.label_cuentakilometros.pack()

                # Cargar los valores desde el archivo
        if os.path.exists('datos.json'):
            with open('datos.json', 'r') as f:
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
        # Actualizar los valores en la interfaz de usuario
        distancia_total = abs((velocidad / 3600)) * 2  # distancia en km, multiplicada por 2 porque la función se llama cada 2 segundos
        self.valor_reciente += distancia_total
        self.valor_total += distancia_total
        
        self.label_reciente.config(text="Reciente: {} km".format(self.valor_reciente))
        self.label_total.config(text="Total: {} km".format(self.valor_total))

        # Guardar los valores en el archivo
        with open('datos.json', 'w') as f:
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

        # Crear marco principal para el salpicadero
        self.marco_salpicadero = tk.Frame(self.root, bg="lightgrey", padx=20, pady=20)
        self.marco_salpicadero.pack()

        # Crear etiqueta para el título del salpicadero
        self.etiqueta_salpicadero = tk.Label(self.marco_salpicadero, text="Salpicadero", font=("Arial", 16, "bold"), bg="lightgrey")
        self.etiqueta_salpicadero.pack()

        # Crear instancias de los componentes del salpicadero
        self.velocimetro = Velocimetro(self.marco_salpicadero, self.revoluciones)
        self.velocimetro.pack(pady=10)

        self.cuenta_kilometros = CuentaKilometros(self.marco_salpicadero)
        self.cuenta_kilometros.pack(pady=10)

        self.cuenta_revoluciones = CuentaRevoluciones(self.marco_salpicadero, self.revoluciones)
        self.cuenta_revoluciones.pack(pady=10)


    def ejecutar(self, revoluciones, estadomotor):
        self.revoluciones = revoluciones
        self.EstadoMotor = estadomotor

        if self.root is None:
            self.root.mainloop()
        self.actualizar_datos()


    def actualizar_datos(self):
        if self.EstadoMotor == EstadoMotor.ACELERANDO or self.EstadoMotor == EstadoMotor.FRENANDO:
            self.actualizar_salpicadero()
            self.root.update()
        elif self.EstadoMotor == EstadoMotor.APAGADO:
            self.resetear_salpicadero()

    def actualizar_salpicadero(self):
        # Aquí es donde actualizas las revoluciones y otros datos del salpicadero
        velocidad = self.calcular_velocidad()
        # Actualizar los valores de los componentes del salpicadero
        self.actualizar_velocimetro(velocidad)
        self.actualizar_cuenta_revoluciones()
        self.cuenta_kilometros.actualizar(velocidad)
        print("Actualizando datos del salpicadero...")

    def resetear_salpicadero(self):
        self.velocimetro.label_km_h.config(text="0 km/h")
        self.cuenta_revoluciones.label_rpm.config(text="0 RPM")
        self.cuenta_kilometros.label_reciente.config(text="Reciente: 0 km")
        self.revoluciones = 0

    def calcular_velocidad(self):
        return int(2 * 3.141592 * 0.15 * self.revoluciones * (60 / 1000))

    def actualizar_velocimetro(self, velocidad):
        self.velocimetro.label_km_h.config(text="{} km/h".format(velocidad))

    def actualizar_cuenta_revoluciones(self):
        self.cuenta_revoluciones.label_rpm.config(text="{} RPM".format(self.revoluciones))


    
