from Conn import Conexao
from visualizar import desenhar_grafo 

def main():
    db = Conexao()
    db.conectar()

    grafo = db.CriarGrafo()

    print("Vértices do Grafo:")
    print(grafo.vertex_data)

    # Desenha o grafo antes de pedir os vértices
    desenhar_grafo(grafo)

    # Defina os vértices inicial e final para o Dijkstra
    inicio = input("Digite o vértice inicial: ").upper()
    fim = input("Digite o vértice final: ").upper()

    distancia, caminho = grafo.dijkstra(inicio, fim)

    print(f"Distância mínima: {distancia}")
    print(f"Caminho: {caminho}")

if __name__ == "__main__":
    main()
