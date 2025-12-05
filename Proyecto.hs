module Proyecto where

--FUNCION PARA ARBOLES.
data ArbolN a = Void | Nodo a [ArbolN a]
    deriving (Show, Eq)

-- ===ARBOLES DE SINTAXIS ABSTRACTA===

--FUNCIONES AUXILIARES.
--Para formulas de logica proposicional.

-- Fórmulas proposicionales (Variables atómicas)
p, q, r, s, t, u :: Prop
p = Var "p"
q = Var "q"
r = Var "r"
s = Var "s"
t = Var "t"
u = Var "u"

data Prop = Var String | Cons Bool | Not Prop
            | And Prop Prop | Or Prop Prop
            | Impl Prop Prop | Syss Prop Prop
            deriving (Eq)
--Para que se vea bien en la terminal.
instance Show Prop where 
                    show (Cons True) = "Verdadero"
                    show (Cons False) = "Falso"
                    show (Var p) = p
                    show (Not p) = "¬" ++ show p
                    show (Or p q) = "(" ++ show p ++ " ∨ " ++ show q ++ ")"
                    show (And p q) = "(" ++ show p ++ " ∧ " ++ show q ++ ")"
                    show (Impl p q) = "(" ++ show p ++ " → " ++ show q ++ ")"
                    show (Syss p q) = "(" ++ show p ++ " ↔ " ++ show q ++ ")"
-- Sinonimo para los estados.
type Estado = [String]

-- ===EJERCICIOS DEL PROYECTO===
--Punto 1.Una función que reciba una fórmula de la lógica proposicional y regrese como resultado el árbol de sintaxis abstracta de la fórmula ingresada.
formulaArbol :: Prop -> ArbolN Prop
formulaArbol (Cons _) = Void
formulaArbol (Var p) = (Nodo (Var p) [])
formulaArbol (Not p) = (Nodo (Not p) [formulaArbol p])
formulaArbol (Or p q) = (Nodo (Or p q) [formulaArbol p, formulaArbol q])
formulaArbol (And p q) = (Nodo (And p q) [formulaArbol p, formulaArbol q] )
formulaArbol (Impl p q) = (Nodo (Impl p q) [formulaArbol p, formulaArbol q])
formulaArbol (Syss p q) = (Nodo (Syss p q) [formulaArbol p, formulaArbol q])
--Punto 2. Una función que reciba un árbol de sintaxis abstracta y devuelva la fórmula de la lógica proposicional asociada a dicho árbol.
arbolFormula :: ArbolN Prop -> Prop
arbolFormula Void = error "arbol vacio"
arbolFormula (Nodo (Var p) []) = (Var p)
arbolFormula (Nodo (Not _) [i]) = Not (arbolFormula i)
arbolFormula (Nodo (And _ _) [i, d]) = And (arbolFormula i) (arbolFormula d)
arbolFormula (Nodo (Or _ _) [i, d]) = Or (arbolFormula i) (arbolFormula d)
arbolFormula (Nodo (Impl _ _) [i, d]) = Impl (arbolFormula i) (arbolFormula d)
arbolFormula (Nodo (Syss _ _) [i, d]) = Syss (arbolFormula i) (arbolFormula d)
--Punto 3. Una función que reciba un árbol de sintaxis abstracta y un estado de las variables. Esta función debe usar directamente el árbol de sintaxis abstracta para devolver la evaluación de la fórmula asociada al árbol.
evaluacion :: ArbolN Prop -> Estado -> Bool
evaluacion Void estado = error "arbol vacio"
evaluacion (Nodo (Var p) []) estado = p `elem` estado
evaluacion (Nodo (Not _) [i]) estado = not (evaluacion i estado)
evaluacion (Nodo (And _ _) [i, d]) estado = evaluacion i estado && evaluacion d estado
evaluacion (Nodo (Or _ _) [i, d]) estado = evaluacion i estado || evaluacion d estado
evaluacion (Nodo (Impl _ _) [i, d]) estado = not (evaluacion i estado) || evaluacion d estado
evaluacion (Nodo (Syss _ _) [i, d]) estado = evaluacion i estado == evaluacion d estado

-- ===FUNCIONES EXTRAS===

-- 1. cantidadElementos: Una función que recibe un árbol y regresa la cantidad de elementos que hay en el árbol.
cantidadElementos :: ArbolN a -> Int
cantidadElementos Void = 0
cantidadElementos (Nodo x hijos) = 1 + contarHijos hijos
  where
    contarHijos [] = 0
    contarHijos (x:xs) = cantidadElementos x + contarHijos xs

-- 2. busca: Una función que reciba un árbol y un elemento. El resultado debe ser un booleano que indique si el elemento se encuentra o no en el árbol.
busca :: Eq a => ArbolN a -> a -> Bool
busca Void _ = False
busca (Nodo x hijos) y = x == y || buscarHijos hijos y
  where
    buscarHijos [] _ = False
    buscarHijos (x:xs) y = busca x y || buscarHijos xs y

-- 3. sumaElementos: Una función que reciba un árbol y devuelva la suma de todos sus elementos.
sumaElementos :: Num a => ArbolN a -> a
sumaElementos Void = 0
sumaElementos (Nodo x hijos) = x + sumarHijos hijos
  where
    sumarHijos [] = 0
    sumarHijos (x:xs) = sumaElementos x + sumarHijos xs

-- 4. preorden / postorden: Una función que reciba un árbol y haga alguno de estos dos recorridos. El resultado debe ser una lista con el orden en que se recorrió el árbol.
preorden :: ArbolN a -> [a]
preorden Void = []
preorden (Nodo x hijos) = x : recorrerHijos hijos
  where
    recorrerHijos [] = []
    recorrerHijos (x:xs) = preorden x ++ recorrerHijos xs

-- 5. altura: Una función que reciba un árbol y devuleva la altura del árbol
altura :: ArbolN a -> Int
altura Void = 0
altura (Nodo _ []) = 1
altura (Nodo _ (x:xs))=
    let alturasHijos = 1 + altura x
        alturasResto = altura (Nodo undefined xs)
    in if alturasHijos > alturasResto
         then alturasHijos
         else alturasResto

-- 6. espejo: Una función que reciba un árbol y devuelva el espejo de dicho árbol
espejo :: ArbolN a -> ArbolN a
espejo Void = Void
espejo (Nodo x []) = Nodo x []
espejo (Nodo x hijos) = Nodo x (invertir hijos)
    where
        invertir [] = []
        invertir (x:xs) = invertir xs ++ [espejo x]

-- 7. podar: Una función que recibe un árbol y un número entero n. Se debe regresar el mismo árbol
-- pero eliminando todos los subárboles cuyas raíces se encuentren a profundidad n
podar :: ArbolN a -> Int -> ArbolN a
podar _ 0 = Void
podar Void _ = Void
podar (Nodo x hijos) n = Nodo x (podarHijos hijos (n - 1))
    where
        podarHijos [] _ = []
        podarHijos (x:xs) profundidad =
            let podadoHijo = podar x profundidad
            in if esVoid podadoHijo
                    then podarHijos xs profundidad
                    else podadoHijo : podarHijos xs profundidad
        esVoid Void = True
        esVoid _ = False

-- 8. elementosProfundidad: Una función que recibe un árbol y un número entero n. Se debe
-- regresar una lista con todos los elementos que se encuentran a profundidad n
elementosProfundidad :: ArbolN a -> Int -> [a]
elementosProfundidad Void _ = []
elementosProfundidad (Nodo x hijos) 0 = [x]
elementosProfundidad (Nodo _ hijos) n = buscarEnHijos hijos (n-1)
  where
    buscarEnHijos [] _ = []
    buscarEnHijos (x:xs) profundidad = 
      elementosProfundidad x profundidad ++ buscarEnHijos xs profundidad