import psycopg2
from Grafo import Graph

class Conexao:
    def conectar(self):
        self.conn = psycopg2.connect(
            dbname="MapAltoVale",
            user="postgres",
            password="unidavi",
            host="localhost",
            port="5432"
        )
        self.cur = self.conn.cursor()

    def CriarGrafo(self):
        self.cur.execute("SELECT id, nome FROM vertices")
        vertices = self.cur.fetchall()

        g = Graph(len(vertices))
        for vid, nome in vertices:
            g.add_vertex_data(vid - 1, nome)

        self.cur.execute("""
            SELECT v1.nome, v2.nome, a.peso
            FROM arestas a
            JOIN vertices v1 ON v1.id=a.origem
            JOIN vertices v2 ON v2.id=a.destino
        """)
        for origem, destino, peso in self.cur.fetchall():
            g.add_edge(g.vertex_data.index(origem), g.vertex_data.index(destino), peso)

        return g
