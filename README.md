# Proyecto-ED

Mondragón Ceballos Evelyn Vianey


# Justificación de la implementación <br>
 <br>
Implementación: <br>

```haskell
data ArbolN a = Void | Nodo a [ArbolN a]
    deriving (Show, Eq)
 <br>
# Explicación de la Estructura
Nuestra implementación utiliza dos constructores:
Void - Árbol vacío
Representa la ausencia de un árbol o nodo. Este constructor es necesario para:

Establecer el caso base en las funciones recursivas
Representar ramas que no existen
Mantener consistencia con la definición de árboles binarios vista en clase

Nodo a [ArbolN a] - Nodo con valor y lista de hijos

a: Es el valor almacenado en el nodo (puede ser de cualquier tipo: Int, Char, String, etc.)
[ArbolN a]: Es una lista de subárboles que representa todos los hijos del nodo

¿Por qué usar una lista de hijos?
La decisión de representar los hijos como [ArbolN a] en lugar de un número fijo permite:

Flexibilidad en la cantidad de hijos: Un nodo puede tener 0, 1, 2, 3... cualquier cantidad de hijos sin restricciones estructurales.
Generalización de árboles binarios: Los árboles binarios son un caso particular donde cada lista tiene exactamente 2 elementos. Nuestra estructura los generaliza.
Diferentes aridades por nodo: Cada nodo en el árbol puede tener una cantidad diferente de hijos, lo cual es esencial para modelar estructuras irregulares.
Recursión natural: Podemos aplicar pattern matching sobre la lista usando [] (lista vacía) y x:xs (cabeza y resto), facilitando las operaciones recursivas.
