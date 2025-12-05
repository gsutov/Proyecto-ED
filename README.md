# Proyecto-ED

Mondragón Ceballos Evelyn Vianey <br>
323157814  <br>
 <br>
Botello Salcido Gustavo <br>
323177308 <br>
 <br>
# Justificación de la implementación <br>
 <br>
Implementación: <br>

```haskell
data ArbolN a = Void | Nodo a [ArbolN a]
    deriving (Show, Eq)
```
 <br>
 
====== Explicación de la Estructura ====== <br>
 <br>
Nuestra implementación utiliza dos constructores: <br>
---- Void - Árbol vacío: ---- <br>
• Representa la ausencia de un árbol o nodo. Este constructor es necesario para: <br>
• Establecer el caso base en las funciones recursivas <br>
• Representar ramas que no existen <br>
• Mantener consistencia con la definición de árboles binarios vista en clase <br>
 <br>
---- Nodo a [ArbolN a] - Nodo con valor y lista de hijos ----  <br>
a: Es el valor almacenado en el nodo (puede ser de cualquier tipo: Int, Char, String, etc.) <br>
[ArbolN a]: Es una lista de subárboles que representa todos los hijos del nodo <br>
 <br>
El representar a los hijos como [ArbolN a] en lugar de un número fijo permite: <br>

Ser flexibles con la cantidad de hijos que puede tener un nodo, ya que puede tener cualquier cantidad de hijos sin ninuna restricción <br>
Cada nodo puede tener una cantidad diferente de hijos respecto a otro nodo <br>
Un árbol binario tiene sólo 2 hijos por nodo, la estructura implementada los generaliza
