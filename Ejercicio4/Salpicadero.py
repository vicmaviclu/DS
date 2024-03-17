import tkinter as tk

class SalpicaderoApp:
    def __init__(self, master):
        self.master = master
        master.title("Salpicadero")

        # Crear marco principal
        self.marco_principal = tk.Frame(master)
        self.marco_principal.pack()

        # Crear etiqueta para el salpicadero
        self.etiqueta_salpicadero = tk.Label(self.marco_principal, text="Salpicadero")
        self.etiqueta_salpicadero.grid(row=0, column=0, columnspan=3)

        # Crear Velocímetro
        self.velocimetro_frame = tk.Frame(self.marco_principal, relief=tk.GROOVE, borderwidth=2)
        self.velocimetro_frame.grid(row=1, column=0, padx=10, pady=10)
        self.label_velocimetro = tk.Label(self.velocimetro_frame, text="Velocímetro")
        self.label_velocimetro.pack()
        self.contador_km_h = tk.Label(self.velocimetro_frame, text="0 km/h")
        self.contador_km_h.pack()

        # Crear Cuentakilómetros
        self.cuentakilometros_frame = tk.Frame(self.marco_principal, relief=tk.GROOVE, borderwidth=2)
        self.cuentakilometros_frame.grid(row=1, column=1, padx=10, pady=10)
        self.label_cuentakilometros = tk.Label(self.cuentakilometros_frame, text="Cuentakilómetros")
        self.label_cuentakilometros.pack()
        self.contador_reciente = tk.Label(self.cuentakilometros_frame, text="Reciente: 0 km")
        self.contador_reciente.pack()
        self.contador_total = tk.Label(self.cuentakilometros_frame, text="Total: 0 km")
        self.contador_total.pack()

        # Crear Cuentarrevoluciones
        self.cuentarrevoluciones_frame = tk.Frame(self.marco_principal, relief=tk.GROOVE, borderwidth=2)
        self.cuentarrevoluciones_frame.grid(row=1, column=2, padx=10, pady=10)
        self.label_cuentarrevoluciones = tk.Label(self.cuentarrevoluciones_frame, text="Cuentarrevoluciones")
        self.label_cuentarrevoluciones.pack()
        self.contador_rpm = tk.Label(self.cuentarrevoluciones_frame, text="0 RPM")
        self.contador_rpm.pack()

root = tk.Tk()
app = SalpicaderoApp(root)
root.mainloop()
