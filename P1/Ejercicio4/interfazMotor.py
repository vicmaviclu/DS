import tkinter as tk
from EstadoMotor import EstadoMotor

class PanelControl(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Mandos")

        self.estado_motor = EstadoMotor.APAGADO

        self.etiqueta_estado = tk.Label(self, text=self.estado_motor.value, font=("Arial", 14), fg="red")
        self.etiqueta_estado.pack(pady=10)

        self.botones_frame = tk.Frame(self)
        self.botones_frame.pack()

        self.boton_encender = tk.Button(self.botones_frame, text="Encender", command=self.toggle_encender, bg="green")
        self.boton_encender.pack(side=tk.LEFT)

        self.boton_acelerar = tk.Button(self.botones_frame, text="Acelerar", command=self.acelerar)
        self.boton_acelerar.pack(side=tk.LEFT)

        self.boton_frenar = tk.Button(self.botones_frame, text="Frenar", command=self.frenar)
        self.boton_frenar.pack(side=tk.LEFT)

        self.disable_buttons()

    def cambiar_estado_motor(self, estado, color, texto_boton):
        self.estado_motor = estado
        self.etiqueta_estado.config(text=self.estado_motor.value, fg=color)
        self.boton_encender.config(text=texto_boton, bg=color)

    def toggle_encender(self):
        if self.estado_motor == EstadoMotor.APAGADO:
            self.cambiar_estado_motor(EstadoMotor.ENCENDIDO, "green", "Apagar")
            self.enable_buttons()
        else:
            self.cambiar_estado_motor(EstadoMotor.APAGADO, "red", "Encender")
            self.disable_buttons()

    def acelerar(self):
        if self.boton_acelerar.cget("text") == "Acelerar":
            self.cambiar_estado_motor(EstadoMotor.ACELERANDO, "red", "Soltar Acelerador")
            self.boton_frenar.config(text="Frenar", state=tk.NORMAL, bg="SystemButtonFace")
            self.boton_encender.config(state=tk.DISABLED)
        else:
            self.cambiar_estado_motor(EstadoMotor.ENCENDIDO, "green", "Encender")
            self.boton_encender.config(state=tk.NORMAL)

    def frenar(self):
        if self.boton_frenar.cget("text") == "Frenar":
            self.cambiar_estado_motor(EstadoMotor.FRENANDO, "red", "Soltar Freno")
            self.boton_acelerar.config(text="Acelerar",bg="SystemButtonFace")
            self.boton_acelerar.config(state=tk.NORMAL)
            self.boton_encender.config(state=tk.NORMAL)
        else:
            self.cambiar_estado_motor(EstadoMotor.ENCENDIDO, "green", "Encender")
            self.boton_encender.config(state=tk.NORMAL)

    # Desactivar o activar los botones de acelerar y frenar
    def disable_buttons(self):
        self.boton_acelerar.config(state=tk.DISABLED)
        self.boton_frenar.config(state=tk.DISABLED)

    def enable_buttons(self):
        self.boton_acelerar.config(state=tk.NORMAL)
        self.boton_frenar.config(state=tk.NORMAL)


