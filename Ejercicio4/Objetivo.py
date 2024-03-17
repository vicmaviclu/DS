import tkinter as tk

class Velocimetro(tk.Frame):
    def __init__(self, master):
        super().__init__(master, bg="white", padx=10, pady=10)
        self.label_velocimetro = tk.Label(self, text="Velocímetro", font=("Arial", 12, "bold"), bg="white")
        self.label_velocimetro.pack()
        self.valor_km_h = 222.42
        self.label_km_h = tk.Label(self, text="{} km/h".format(self.valor_km_h), font=("Arial", 10), bg="white")
        self.label_km_h.pack()

class CuentaKilometros(tk.Frame):
    def __init__(self, master):
        super().__init__(master, bg="white", padx=10, pady=10)
        self.label_cuentakilometros = tk.Label(self, text="Cuentakilómetros", font=("Arial", 12, "bold"), bg="white")
        self.label_cuentakilometros.pack()
        self.valor_reciente = 1.06
        self.label_reciente = tk.Label(self, text="Reciente: {} km".format(self.valor_reciente), font=("Arial", 10), bg="white")
        self.label_reciente.pack()
        self.valor_total = 1.32
        self.label_total = tk.Label(self, text="Total: {} km".format(self.valor_total), font=("Arial", 10), bg="white")
        self.label_total.pack()

class CuentaRevoluciones(tk.Frame):
    def __init__(self, master):
        super().__init__(master, bg="white", padx=10, pady=10)
        self.label_cuentarrevoluciones = tk.Label(self, text="Cuentarrevoluciones", font=("Arial", 12, "bold"), bg="white")
        self.label_cuentarrevoluciones.pack()
        self.valor_rpm = 59.00
        self.label_rpm = tk.Label(self, text="{} RPM".format(self.valor_rpm), font=("Arial", 10), bg="white")
        self.label_rpm.pack()

class SalpicaderoApp(tk.Frame):
    def __init__(self, master):
        super().__init__(master, bg="lightgrey", padx=20, pady=20)
        self.master = master
        master.title("Salpicadero")

        # Crear marco principal para el salpicadero
        self.marco_salpicadero = tk.Frame(master, bg="lightgrey", padx=20, pady=20)
        self.marco_salpicadero.pack()

        # Crear etiqueta para el título del salpicadero
        self.etiqueta_salpicadero = tk.Label(self.marco_salpicadero, text="Salpicadero", font=("Arial", 16, "bold"), bg="lightgrey")
        self.etiqueta_salpicadero.pack()

        # Crear instancias de los componentes del salpicadero
        self.velocimetro = Velocimetro(self.marco_salpicadero)
        self.velocimetro.pack(pady=10)

        self.cuenta_kilometros = CuentaKilometros(self.marco_salpicadero)
        self.cuenta_kilometros.pack(pady=10)

        self.cuenta_revoluciones = CuentaRevoluciones(self.marco_salpicadero)
        self.cuenta_revoluciones.pack(pady=10)

# Crear la ventana principal y el salpicadero
root = tk.Tk()
app = SalpicaderoApp(root)
app.pack()

# Ejecutar la aplicación
root.mainloop()
