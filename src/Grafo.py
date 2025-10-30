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


# ==================== ÁRVORE BINÁRIA ====================

class NodoArvore:
    def __init__(self, conteudo):
        self.conteudo = conteudo
        self.esq = None
        self.dir = None


class ArvoreBinaria:
    def __init__(self):
        self.raiz = None

    # --- INSERIR ---
    def inserir_valor(self, valor):
        v = self._converter_valor(valor)
        if self.pertence(v):
            return False
        self.raiz = self._inserir_rec(self.raiz, v)
        return True

    def _inserir_rec(self, nodo, valor):
        if nodo is None:
            return NodoArvore(valor)
        if valor < nodo.conteudo:
            nodo.esq = self._inserir_rec(nodo.esq, valor)
        elif valor > nodo.conteudo:
            nodo.dir = self._inserir_rec(nodo.dir, valor)
        return nodo

    # --- REMOVER ---
    def remover_valor(self, valor):
        v = self._converter_valor(valor)
        if not self.pertence(v):
            return False
        self.raiz = self._remover_rec(self.raiz, v)
        return True

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

    # --- UTILITÁRIOS ---
    def _converter_valor(self, valor):
        try:
            return int(valor)
        except Exception:
            return str(valor)

    def pertence(self, valor):
        return self._pertence_rec(self.raiz, valor)

    def _pertence_rec(self, nodo, valor):
        if nodo is None:
            return False
        if valor < nodo.conteudo:
            return self._pertence_rec(nodo.esq, valor)
        elif valor > nodo.conteudo:
            return self._pertence_rec(nodo.dir, valor)
        return True

    # --- TRAVESSIA ---
    def travessia(self, tipo="inorder"):
        res = []
        def inorder(n):
            if n: inorder(n.esq); res.append(n.conteudo); inorder(n.dir)
        def preorder(n):
            if n: res.append(n.conteudo); preorder(n.esq); preorder(n.dir)
        def postorder(n):
            if n: postorder(n.esq); postorder(n.dir); res.append(n.conteudo)

        t = tipo.lower()
        if t.startswith("pre"): preorder(self.raiz)
        elif t.startswith("post"): postorder(self.raiz)
        else: inorder(self.raiz)
        return res

    # --- EXPORTAR PARA CYTOSCAPE ---
    def to_cytoscape(self):
        if not self.raiz:
            return {"nodes": [], "edges": []}

        nodes, edges, coords = [], [], {}
        contador = [0]

        def definir_posicoes(nodo, nivel=0):
            if nodo is None:
                return
            definir_posicoes(nodo.esq, nivel + 1)
            coords[nodo.conteudo] = (contador[0], nivel)
            contador[0] += 1
            definir_posicoes(nodo.dir, nivel + 1)

        definir_posicoes(self.raiz)

        for valor, (x, y) in coords.items():
            nodes.append({
                "data": {"id": str(valor), "label": str(valor)},
                "position": {"x": x * 90, "y": y * 100}
            })

        def add_edges(n):
            if not n:
                return
            if n.esq:
                edges.append({"data": {"source": str(n.conteudo), "target": str(n.esq.conteudo)}})
                add_edges(n.esq)
            if n.dir:
                edges.append({"data": {"source": str(n.conteudo), "target": str(n.dir.conteudo)}})
                add_edges(n.dir)

        add_edges(self.raiz)
        return {"nodes": nodes, "edges": edges}
