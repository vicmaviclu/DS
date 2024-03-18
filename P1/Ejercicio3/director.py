class Director:
    def __init__(self, builder):
        self._builder = builder
    
    def build_pizza(self):
        self._builder.add_ingredientes()
        self._builder.add_salsa()
        self._builder.set_tamano()
        return self._builder.get_result()
