# Clase pizza que se construira con el patron builder
class Pizza:
    def __init__(self):
        self.ingredientes = ""
        self.salsa = ""
        self.tamano = ""
    
    def __str__(self):
        return f"La pizza lleva: {self.ingredientes}\nSalsa: {self.salsa}\nTamaño: {self.tamano}"
