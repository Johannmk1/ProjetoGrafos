from .Grafo import Graph 

class DadosGrafo:
    def CriarGrafo(self):
        vertices = [
            'AGL', 'AGN', 'ATA', 'AUR', 'BRA', 'CHA', 'DON',
            'GET', 'IBI', 'ITU', 'JOS', 'LAU', 'LON', 'MIR',
            'NER', 'PET', 'POU', 'RDC', 'RDO', 'RDS', 'SAL',
            'TAI', 'TER', 'TRO', 'VID', 'VIT', 'WIT'
        ]

        g = Graph(len(vertices))

        for i, nome in enumerate(vertices):
            g.add_vertex_data(i, nome)

        arestas = [
            ('AGL', 'CHA', 64.26),
            ('AUR', 'ITU', 16.90),
            ('JOS', 'TAI', 2.00),
            ('AGN', 'SAL', 47.25),
            ('BRA', 'POU', 55.25),
            ('AUR', 'PET', 18.00),
            ('ATA', 'JOS', 30.60),
            ('AGN', 'JOS', 22.50),
            ('AUR', 'NER', 11.70),
            ('ATA', 'LON', 6.80),
            ('AUR', 'LON', 14.00),
            ('AUR', 'TAI', 10.20),
            ('AUR', 'IBI', 7.80),
            ('DON', 'LON', 22.10),
            ('MIR', 'VID', 14.40),
            ('BRA', 'TRO', 17.68),
            ('GET', 'RDS', 12.50),
            ('DON', 'RDO', 3.06),
            ('CHA', 'MIR', 40.63),
            ('BRA', 'MIR', 23.40),
            ('DON', 'RDC', 36.72),
            ('CHA', 'PET', 39.10),
            ('DON', 'PET', 11.05),
            ('DON', 'VID', 5.40),
            ('BRA', 'NER', 8.75),
            ('CHA', 'NER', 21.13),
            ('CHA', 'TRO', 6.00),
            ('CHA', 'JOS', 15.30),
            ('IBI', 'NER', 20.00),
            ('PET', 'WIT', 15.75),
            ('DON', 'TAI', 27.30),
            ('ITU', 'TAI', 21.13),
            ('IBI', 'SAL', 22.10),
            ('GET', 'PET', 64.26),
            ('DON', 'TER', 23.40),
            ('IBI', 'RDS', 6.00),
            ('GET', 'RDC', 39.10),
            ('AGL', 'RDC', 1.00),
            ('DON', 'WIT', 43.20),
            ('LAU', 'TER', 40.63),
            ('RDO', 'VIT', 10.20),
            ('LAU', 'SAL', 19.50),
            ('AGN', 'BRA', 2.00),
            ('AGL', 'LON', 6.25),
            ('ATA', 'RDC', 17.68),
            ('GET', 'JOS', 15.00),
            ('LAU', 'WIT', 36.00),
            ('NER', 'TAI', 16.00),
            ('AGL', 'POU', 25.50),
            ('ATA', 'RDS', 19.80),
        ]

        for origem, destino, peso in arestas:
            g.add_edge(vertices.index(origem), vertices.index(destino), peso)

        return g
