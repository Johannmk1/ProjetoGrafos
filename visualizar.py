import matplotlib.pyplot as plt
import networkx as nx

def desenhar_grafo(grafo):
    G = nx.Graph()

    # Adiciona vértices
    for v in grafo.vertex_data:
        if v:
            G.add_node(v)

    # Adiciona arestas
    for i in range(grafo.size):
        for j in range(i + 1, grafo.size):
            if grafo.adj_matrix[i][j] != 0:
                G.add_edge(
                    grafo.vertex_data[i],
                    grafo.vertex_data[j],
                    weight=grafo.adj_matrix[i][j]
                )

    pos = nx.spring_layout(G, seed=42)
    weights = nx.get_edge_attributes(G, 'weight')

    nx.draw(G, pos, with_labels=True, node_size=1500,
            node_color="lightblue", font_size=10, font_weight="bold")
    nx.draw_networkx_edge_labels(G, pos, edge_labels=weights)

    plt.show()
