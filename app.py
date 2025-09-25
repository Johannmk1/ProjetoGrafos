from flask import Flask, send_from_directory, request, jsonify
from src.DadosGrafo import DadosGrafo 

app = Flask(__name__, static_folder="src/static")

@app.route("/")
def index():
    return send_from_directory("src/static", "index.html")

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

if __name__ == "__main__":
    app.run()
