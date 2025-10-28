from flask import Flask, send_from_directory, request, jsonify
from src.DadosGrafo import DadosGrafo 

app = Flask(__name__, static_folder="src/static")

@app.route("/")
def index():
    return send_from_directory("src/static", "index.html")

@app.route("/pratica/grafos")
def pratica_grafos():
    return send_from_directory("src/static", "pratica_grafos.html")

@app.route("/pratica/arvores")
def pratica_arvores():
    return send_from_directory("src/static", "pratica_arvores.html")

@app.route("/grafo")
def grafo_json():
    dg = DadosGrafo()
    grafo = dg.CriarGrafo()

    nodes = [{"data": {"id": v, "label": v}} for v in grafo.vertex_data if v]
    edges = []
    for i in range(grafo.size):
        for j in range(i + 1, grafo.size):
            w = grafo.adj_matrix[i][j]
            if w != 0:
                edges.append({"data": {
                    "source": grafo.vertex_data[i],
                    "target": grafo.vertex_data[j],
                    "weight": w
                }})

    return jsonify({"nodes": nodes, "edges": edges})

@app.route("/dijkstra", methods=["POST"])
def dijkstra():
    data = request.get_json()
    inicio, fim = data["inicio"], data["fim"]

    dg = DadosGrafo()
    grafo = dg.CriarGrafo()

    distancia, caminho = grafo.dijkstra(inicio, fim)
    return jsonify({"distancia": distancia, "caminho": caminho})


# adicionar no topo (junto aos imports)
from Grafo import ArvoreBinaria  # usa a classe já existente em Grafo.py. :contentReference[oaicite:2]{index=2}

# criar instância global da árvore (serve para testes enquanto o servidor roda)
arvore = ArvoreBinaria()
# opcional: popular alguns valores iniciais para testes
for v in [8,5,10,11,9,12]:
    arvore.inserir(v)

# --- endpoint para retornar a árvore em formato nodes/edges (Cytoscape) ---
@app.route("/arvore")
def arvore_json():
    def build(n):
        nodes = []
        edges = []
        if n is None:
            return nodes, edges
        nodes.append({"data": {"id": str(n.conteudo), "label": str(n.conteudo)}})
        if n.esq:
            nodes_child, edges_child = build(n.esq)
            nodes += nodes_child
            edges += edges_child
            edges.append({"data": {"source": str(n.conteudo), "target": str(n.esq.conteudo)}})
        if n.dir:
            nodes_child, edges_child = build(n.dir)
            nodes += nodes_child
            edges += edges_child
            edges.append({"data": {"source": str(n.conteudo), "target": str(n.dir.conteudo)}})
        return nodes, edges

    nodes, edges = build(arvore.raiz)
    return jsonify({"nodes": nodes, "edges": edges})

# --- inserir um valor na árvore ---
@app.route("/arvore/insert", methods=["POST"])
def arvore_insert():
    data = request.get_json()
    valor = data.get("valor")
    # tenta converter para int, se não conseguir guarda como string
    try:
        valor = int(valor)
    except Exception:
        pass
    arvore.inserir(valor)
    return jsonify({"ok": True})

# --- remover um valor da árvore ---
@app.route("/arvore/remove", methods=["POST"])
def arvore_remove():
    data = request.get_json()
    valor = data.get("valor")
    try:
        valor = int(valor)
    except Exception:
        pass
    arvore.remover(valor)
    return jsonify({"ok": True})

# --- obter uma travessia (inorder, preorder, postorder) ---
@app.route("/arvore/traverse")
def arvore_traverse():
    tipo = request.args.get("tipo", "inorder").lower()
    res = []
    def inorder(n):
        if not n: return
        inorder(n.esq); res.append(n.conteudo); inorder(n.dir)
    def preorder(n):
        if not n: return
        res.append(n.conteudo); preorder(n.esq); preorder(n.dir)
    def postorder(n):
        if not n: return
        postorder(n.esq); postorder(n.dir); res.append(n.conteudo)

    if tipo.startswith("pre"):
        preorder(arvore.raiz)
    elif tipo.startswith("post"):
        postorder(arvore.raiz)
    else:
        inorder(arvore.raiz)

    return jsonify({"lista": res})


if __name__ == "__main__":
    app.run()
