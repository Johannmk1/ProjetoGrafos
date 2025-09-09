from Conexao import Conexao
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    caminho = None
    distancia = None

    if request.method == "POST":
        inicio = request.form["inicio"]
        fim = request.form["fim"]

        db = Conexao()
        db.conectar()
        grafo = db.CriarGrafo()

        distancia, caminho = grafo.dijkstra(inicio, fim)

    return render_template("index.html", caminho=caminho, distancia=distancia)

if __name__ == "__main__":
    app.run(debug=True)
