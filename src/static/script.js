// ------------------------- GRAFOS -------------------------
let cy;
let vertices = [];

function desenharGrafo(data) {
  if (cy) {
    try { cy.destroy(); } catch (e) {}
    cy = null;
  }

  cy = cytoscape({
    container: document.getElementById("cy"),
    elements: [...data.nodes, ...data.edges],
    style: [
      {
        selector: "node",
        style: {
          "content": "data(label)",
          "background-color": "#61bffc",
          "color": "#000",
          "text-valign": "center",
          "text-halign": "center",
          "font-size": 14,
          "width": 45,
          "height": 45,
          "border-width": 2,
          "border-color": "#1f3a93"
        }
      },
      {
        selector: "edge",
        style: {
          "label": "data(weight)",
          "width": 2.5,
          "line-color": "#ccc",
          "curve-style": "bezier",
          "font-size": 12,
          "text-background-color": "#fff",
          "text-background-opacity": 0.8
        }
      },
      {
        selector: ".highlighted",
        style: { "line-color": "#e74c3c", "width": 5 }
      }
    ],
    layout: { name: "cose", animate: true }
  });
}

function carregarGrafo() {
  fetch("/grafo")
    .then(res => res.json())
    .then(data => {
      vertices = data.nodes.map(n => n.data.id);
      const inicioSelect = document.getElementById("inicio");
      const fimSelect = document.getElementById("fim");
      if (inicioSelect && fimSelect) {
        inicioSelect.innerHTML = "";
        fimSelect.innerHTML = "";
        vertices.forEach(v => {
          inicioSelect.innerHTML += `<option value="${v}">${v}</option>`;
          fimSelect.innerHTML += `<option value="${v}">${v}</option>`;
        });
      }
      desenharGrafo(data);
    })
    .catch(err => console.error("Erro ao carregar grafo:", err));
}

function calcular() {
  const inicio = document.getElementById("inicio").value;
  const fim = document.getElementById("fim").value;

  fetch("/dijkstra", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ inicio, fim })
  })
    .then(res => res.json())
    .then(data => {
      document.getElementById("resultado").innerHTML =
        `<p><b>Distância:</b> ${data.distancia}</p>
         <p><b>Caminho:</b> ${data.caminho}</p>`;

      if (!cy) return;
      cy.elements().removeClass("highlighted");
      const path = data.caminho.split("->").filter(Boolean);
      for (let i = 0; i < path.length - 1; i++) {
        cy.edges().filter(e =>
          (e.data("source") === path[i] && e.data("target") === path[i + 1]) ||
          (e.data("source") === path[i + 1] && e.data("target") === path[i])
        ).addClass("highlighted");
      }
    });
}

// ------------------------- ÁRVORES -------------------------
let cyArvore = null;

function desenharArvore(data) {
  if (!data || !data.nodes || data.nodes.length === 0) {
    const holder = document.getElementById("cy_arvore");
    if (holder) holder.innerHTML = "<p>Árvore vazia</p>";
    return;
  }

  if (cyArvore) {
    try { cyArvore.destroy(); } catch (e) {}
    cyArvore = null;
  }

  cyArvore = cytoscape({
    container: document.getElementById("cy_arvore"),
    elements: [...data.nodes, ...data.edges],
    style: [
      {
        selector: "node",
        style: {
          "content": "data(label)",
          "text-valign": "center",
          "text-halign": "center",
          "width": 40,
          "height": 40,
          "font-size": 12,
          "background-color": "#9ae6b4",
          "border-color": "#2f855a",
          "border-width": 2
        }
      },
      {
        selector: "edge",
        style: {
          "width": 3,
          "curve-style": "bezier",
          "target-arrow-shape": "triangle",
          "line-color": "#ccc",
          "target-arrow-color": "#ccc"
        }
      },
      {
        selector: ".highlight",
        style: { "background-color": "#f6ad55", "line-color": "#f6ad55" }
      }
    ],
    layout: { name: "preset" } // ✅ Usa posições calculadas no backend
  });

  cyArvore.fit();
}

function carregarArvore() {
  fetch("/arvore")
    .then(r => r.json())
    .then(data => desenharArvore(data))
    .catch(err => {
      console.error("Erro ao carregar árvore:", err);
      const holder = document.getElementById("cy_arvore");
      if (holder) holder.innerHTML = "<p>Erro ao carregar árvore</p>";
    });
}

// ------------------------- INICIALIZAÇÃO GLOBAL -------------------------
document.addEventListener("DOMContentLoaded", () => {
  // Página de grafos
  if (document.getElementById("cy")) {
    carregarGrafo();
    const btnCalc = document.getElementById("btnCalcular");
    if (btnCalc) btnCalc.addEventListener("click", calcular);
  }

  // Página de árvores
  if (document.getElementById("cy_arvore")) {
    const valorInput = document.getElementById("valor");
    const btnInserir = document.getElementById("btnInserir");
    const btnRemover = document.getElementById("btnRemover");
    const btnTraverse = document.getElementById("btnVerTraverse");
    const btnAtualizar = document.getElementById("btnAtualizar");
    const tipoSelect = document.getElementById("tipoTraverse");

    if (btnInserir) btnInserir.onclick = () => {
      const v = valorInput.value;
      fetch("/arvore/insert", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ valor: v })
      }).then(() => { valorInput.value = ""; carregarArvore(); });
    };

    if (btnRemover) btnRemover.onclick = () => {
      const v = valorInput.value;
      fetch("/arvore/remove", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ valor: v })
      }).then(() => { valorInput.value = ""; carregarArvore(); });
    };

    if (btnTraverse) btnTraverse.onclick = () => {
      const tipo = tipoSelect.value;
      fetch(`/arvore/traverse?tipo=${tipo}`)
        .then(r => r.json())
        .then(j => {
          const out = document.getElementById("listaTraverse");
          if (out) out.textContent = "Lista: " + (j.lista || []).join(" - ");
        });
    };

    if (btnAtualizar) btnAtualizar.onclick = carregarArvore;
    carregarArvore();
  }
});
