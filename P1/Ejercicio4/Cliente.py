import tkinter as tk

class PanelControl(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Panel de Control")

        self.estado_motor = "APAGADO"

        self.etiqueta_estado = tk.Label(self, text=self.estado_motor, font=("Arial", 14), fg="red")
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

    def toggle_encender(self):
        if self.estado_motor == "APAGADO":
            self.estado_motor = "ENCENDIDO"
            self.etiqueta_estado.config(text=self.estado_motor, fg="green")
            self.boton_encender.config(text="Apagar", bg="red")
            self.enable_buttons()
        else:
            self.estado_motor = "APAGADO"
            self.etiqueta_estado.config(text=self.estado_motor, fg="red")
            self.boton_encender.config(text="Encender", bg="green")
            self.boton_acelerar.config(text="Acelerar", bg="SystemButtonFace")
            self.boton_frenar.config(text="Frenar", bg="SystemButtonFace")
            self.disable_buttons()

    def acelerar(self):
        if self.boton_acelerar.cget("text") == "Acelerar":
            self.etiqueta_estado.config(text="ACELERANDO")
            self.boton_acelerar.config(text="Soltar Acelerador", state=tk.DISABLED, bg="red")
            self.boton_frenar.config(text="Frenar", state=tk.NORMAL, bg="SystemButtonFace")
            self.boton_encender.config(state=tk.DISABLED)
        else:
            self.etiqueta_estado.config(text="ENCENDIDO")
            self.boton_acelerar.config(text="Acelerar", bg="SystemButtonFace")
            self.boton_encender.config(state=tk.NORMAL)

    def frenar(self):
        if self.boton_frenar.cget("text") == "Frenar":
            self.etiqueta_estado.config(text="FRENANDO")
            self.boton_frenar.config(text="Soltar Freno", state=tk.DISABLED, bg="red")
            self.boton_acelerar.config(text="Acelerar",bg="SystemButtonFace")
            self.boton_acelerar.config(state=tk.NORMAL)
            self.boton_encender.config(state=tk.NORMAL)
        else:
            self.etiqueta_estado.config(text="ENCENDIDO")
            self.boton_frenar.config(text="Frenar", bg="SystemButtonFace")
            self.boton_acelerar.config(text="Acelerar", bg="SystemButtonFace")
            self.boton_encender.config(state=tk.NORMAL)

    def disable_buttons(self):
        self.boton_acelerar.config(state=tk.DISABLED)
        self.boton_frenar.config(state=tk.DISABLED)

    def enable_buttons(self):
        self.boton_acelerar.config(state=tk.NORMAL)
        self.boton_frenar.config(state=tk.NORMAL)

if __name__ == "__main__":
    app = PanelControl()
    app.mainloop()
