from flask import Flask, jsonify, send_from_directory, request
from src.Grafo import ArvoreBinaria
from src.DadosGrafo import DadosGrafo

app = Flask(__name__, static_folder="src/static", static_url_path="/static")

# -------------------- PÁGINAS --------------------

@app.route("/")
def index():
    return send_from_directory("src/static", "index.html")

@app.route("/pratica/grafos")
def pratica_grafos():
    return send_from_directory("src/static", "pratica_grafos.html")

@app.route("/pratica/arvores")
def pratica_arvores():
    return send_from_directory("src/static", "pratica_arvores.html")

# -------------------- GRAFO (DIJKSTRA) --------------------

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
                edges.append({
                    "data": {"source": grafo.vertex_data[i], "target": grafo.vertex_data[j], "weight": w}
                })
    return jsonify({"nodes": nodes, "edges": edges})


@app.route("/dijkstra", methods=["POST"])
def dijkstra():
    data = request.get_json()
    inicio, fim = data.get("inicio"), data.get("fim")

    dg = DadosGrafo()
    grafo = dg.CriarGrafo()

    distancia, caminho = grafo.dijkstra(inicio, fim)
    return jsonify({"distancia": distancia, "caminho": caminho})


# -------------------- ÁRVORE BINÁRIA --------------------

arvore = ArvoreBinaria()

@app.route("/arvore")
def arvore_json():
    return jsonify(arvore.to_cytoscape())

@app.route("/arvore/insert", methods=["POST"])
def arvore_insert():
    valor = (request.get_json() or {}).get("valor")
    ok = arvore.inserir_valor(valor)
    return jsonify({"ok": ok})

@app.route("/arvore/remove", methods=["POST"])
def arvore_remove():
    valor = (request.get_json() or {}).get("valor")
    ok = arvore.remover_valor(valor)
    return jsonify({"ok": ok})

@app.route("/arvore/traverse")
def arvore_traverse():
    tipo = request.args.get("tipo", "inorder")
    lista = arvore.travessia(tipo)
    return jsonify({"lista": lista})


if __name__ == "__main__":
    app.run(debug=True)
