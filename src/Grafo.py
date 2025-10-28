class Graph:
    def __init__(self, size):
        self.adj_matrix = [[0] * size for _ in range(size)]
        self.size = size
        self.vertex_data = [''] * size

    def add_edge(self, u, v, weight):
        if 0 <= u < self.size and 0 <= v < self.size:
            self.adj_matrix[u][v] = weight
            self.adj_matrix[v][u] = weight  

    def add_vertex_data(self, vertex, data):
        if 0 <= vertex < self.size:
            self.vertex_data[vertex] = data

    def dijkstra(self, start_vertex_data, end_vertex_data):
        start_vertex = self.vertex_data.index(start_vertex_data)
        end_vertex = self.vertex_data.index(end_vertex_data)
        distances = [float('inf')] * self.size
        predecessors = [None] * self.size
        distances[start_vertex] = 0
        visited = [False] * self.size

        for _ in range(self.size):
            min_distance = float('inf')
            u = None
            for i in range(self.size):
                if not visited[i] and distances[i] < min_distance:
                    min_distance = distances[i]
                    u = i

            if u is None or u == end_vertex:
                break

            visited[u] = True

            for v in range(self.size):
                if self.adj_matrix[u][v] != 0 and not visited[v]:
                    alt = distances[u] + self.adj_matrix[u][v]
                    if alt < distances[v]:
                        distances[v] = alt
                        predecessors[v] = u

        return distances[end_vertex], self.get_path(predecessors, start_vertex_data, end_vertex_data)

    def get_path(self, predecessors, start_vertex, end_vertex):
        path = []
        current = self.vertex_data.index(end_vertex)
        while current is not None:
            path.insert(0, self.vertex_data[current])
            current = predecessors[current]
            if current == self.vertex_data.index(start_vertex):
                path.insert(0, start_vertex)
                break
        return '->'.join(path)

class NodoArvore:
    def __init__(self, conteudo):
        self.conteudo = conteudo
        self.esq = None
        self.dir = None


class ArvoreBinaria:
    def __init__(self):
        self.raiz = None

    # --- PERTENCE ---
    def pertence(self, valor):
        return self._pertence_rec(self.raiz, valor)

    def _pertence_rec(self, nodo, valor):
        if nodo is None:
            return False
        if valor < nodo.conteudo:
            return self._pertence_rec(nodo.esq, valor)
        elif valor > nodo.conteudo:
            return self._pertence_rec(nodo.dir, valor)
        else:
            return True
        
    # --- NÍVEL ---
    def nivel(self, valor, n=0):
        if self.pertence(valor):
            return self._nivel_rec(self.raiz, valor, n)           
        else:
            return -1
        

    def _nivel_rec(self, nodo, valor, n):
        if valor < nodo.conteudo:
            return self._nivel_rec(nodo.esq, valor, n=n+1)
        elif valor > nodo.conteudo:
            return self._nivel_rec(nodo.dir, valor, n=n+1)
        else:
            return n    

    # --- INSERIR ---
    def inserir(self, valor):
        if self.pertence(valor):
            print(valor , " já pertence à árvore.")
        else:
            self.raiz = self._inserir_rec(self.raiz, valor)


    def _inserir_rec(self, nodo, valor):
        if nodo is None:
            return NodoArvore(valor)
        if valor < nodo.conteudo:
            nodo.esq = self._inserir_rec(nodo.esq, valor)
        elif valor > nodo.conteudo:
            nodo.dir = self._inserir_rec(nodo.dir, valor)
        return nodo

    # --- REMOVER ---
    def remover(self, valor):
        if self.pertence(valor):
            self.raiz = self._remover_rec(self.raiz, valor)
        else:
            print(valor , " não esta na árvore.")

    def _remover_rec(self, nodo, valor):
        if nodo is None:
            return None
        if valor < nodo.conteudo:
            nodo.esq = self._remover_rec(nodo.esq, valor)
        elif valor > nodo.conteudo:
            nodo.dir = self._remover_rec(nodo.dir, valor)
        else:
            if nodo.esq is None:
                return nodo.dir
            elif nodo.dir is None:
                return nodo.esq
            sucessor = self._minimo(nodo.dir)
            nodo.conteudo = sucessor.conteudo
            nodo.dir = self._remover_rec(nodo.dir, sucessor.conteudo)
        return nodo

    def _minimo(self, nodo):
        while nodo.esq is not None:
            nodo = nodo.esq
        return nodo

    # --- COMPLETA ---
    def completa(self, nodo=None, interno=False):
        if not interno:
            nodo = self.raiz
        if nodo is None:
            return
        if nodo.esq is None and nodo.dir is None:
            return True
        if nodo.esq is None or nodo.dir is None:
            return False
        return self.completa(nodo.esq, True) and self.completa(nodo.dir, True)
    
    # --- CHEIA ---
    def _contar_nos(self, nodo):
        if nodo is None:
            return 0
        return 1 + self._contar_nos(nodo.esq) + self._contar_nos(nodo.dir)
    
    def cheia(self):
        if self.raiz is None:
            return True
        return self._contar_nos(self.raiz) == (2 ** (self.altura() + 1) - 1)
   
    # --- ALTURA ---
    def altura(self, nodo=None, interno=False):
        if not interno:
            nodo = self.raiz
        if nodo is None:
            return -1  
        altura_esq = self.altura(nodo.esq, True)
        altura_dir = self.altura(nodo.dir, True)
        return 1 + max(altura_esq, altura_dir)

    # --- VISUALIZAÇÃO ---
    def mostrar(self, nodo=None, nivel=0, interno=False):
        """Exibe a árvore com indentação hierárquica."""
        if not interno:
            nodo = self.raiz
        if nodo is None:
            return
        if nodo.dir:
            self.mostrar(nodo.dir, nivel + 1, True)
        print("   " * nivel + f"-> {nodo.conteudo}")
        if nodo.esq:
            self.mostrar(nodo.esq, nivel + 1, True)
    
    def mostrarPreOrdem(self, nodo=None, interno=False):
        if not interno:
            nodo = self.raiz
        if nodo:
            print(nodo.conteudo, end=" - ")
            self.mostrarPreOrdem(nodo.esq, True)
            self.mostrarPreOrdem(nodo.dir, True)
        else:
            return

    def mostrarOrdem(self, nodo=None, interno=False):
        if not interno:
            nodo = self.raiz
        if nodo:
            self.mostrarOrdem(nodo.esq, True)
            print(nodo.conteudo, end=" - ")
            self.mostrarOrdem(nodo.dir, True)
        else:
            return

    def mostrarPosOrdem(self, nodo=None, interno=False):
        if not interno:
            nodo = self.raiz
        if nodo:
            self.mostrarPosOrdem(nodo.esq, True)
            self.mostrarPosOrdem(nodo.dir, True)
            print(nodo.conteudo, end=" - ")
        else:
            return

    # --- MOSTRAR NÓS FOLHAS ---
    def mostrar_folhas(self, nodo=None, interno=False):
        if not interno:
            nodo = self.raiz
        if nodo:
            if nodo.esq is None and nodo.dir is None:
                print(nodo.conteudo, end=' ')
            if nodo.esq:
                self.mostrar_folhas(nodo.esq, True)
            if nodo.dir:
                self.mostrar_folhas(nodo.dir, True)


# --------------------------------------
if __name__ == "__main__":
    arv = ArvoreBinaria()
    for valor in [8, 5, 10, 11, 9, 12]:
        arv.inserir(valor)

    print("\nÁrvore inicial:")
    arv.mostrar()

    print("\nÁrvore inicial pre ordem:")
    arv.mostrarPreOrdem()

    print("\nÁrvore inicial ordem:")
    arv.mostrarOrdem()

    print("\nÁrvore inicial pos ordem:")
    arv.mostrarPosOrdem()

    print("\nRemovendo 3...")
    arv.remover(3)
    arv.mostrar()

    print("\nRemovendo 10...")
    arv.remover(10)
    arv.mostrar()

    print("\nNós folhas:")
    arv.mostrar_folhas()

    if arv.completa():
        print("\nCompleta")
    else:
        print("\nNão completa")

    if arv.cheia():
        print("\nCheia")
    else:
        print("\nNão cheia")

    if arv.nivel(10) >= 0:
        print("\nO Nível de 10 é: ", arv.nivel(10))
    else:
        print("\n10 não esta na arvore")

    if arv.altura() >= 0:
        print("\nAltura da arvore: ", arv.altura())
    else:
        print("\nArvore vazia")