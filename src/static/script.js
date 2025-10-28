let cy;
let vertices = [];

function desenharGrafo(data) {
  cy = cytoscape({
    container: document.getElementById("cy"),
    elements: [...data.nodes, ...data.edges],
    style: [
      { selector: "node", style: { 
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
      }},
      { selector: "edge", style: { 
          "label": "data(weight)", 
          "width": 3, 
          "line-color": "#ccc", 
          "curve-style": "bezier",
          "font-size": 12,
          "text-background-color": "#fff",
          "text-background-opacity": 0.8
      }},
      { selector: ".highlighted", style: { 
          "line-color": "#e74c3c", 
          "width": 5 
      }}
    ],
    layout: { name: "cose" }
  });
}

function carregarGrafo() {
  fetch("/grafo")
    .then(res => res.json())
    .then(data => {
      vertices = data.nodes.map(n => n.data.id);
      const inicioSelect = document.getElementById("inicio");
      const fimSelect = document.getElementById("fim");
      inicioSelect.innerHTML = "";
      fimSelect.innerHTML = "";
      vertices.forEach(v => {
        inicioSelect.innerHTML += `<option value="${v}">${v}</option>`;
        fimSelect.innerHTML += `<option value="${v}">${v}</option>`;
      });
      desenharGrafo(data);
    });
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
        (e.data("source") === path[i] && e.data("target") === path[i+1]) ||
        (e.data("source") === path[i+1] && e.data("target") === path[i])
      ).addClass("highlighted");
    }
  });
}

function abrirModal(id) {
  const modal = document.getElementById(id);
  modal.style.display = "flex";

  function escListener(e) {
    if (e.key === "Escape") {
      fecharModal(id);
      document.removeEventListener("keydown", escListener);
    }
  }
  document.addEventListener("keydown", escListener);

  modal.addEventListener("click", function foraClick(e) {
    if (e.target === modal) {
      fecharModal(id);
      modal.removeEventListener("click", foraClick);
      document.removeEventListener("keydown", escListener);
    }
  });
}

function fecharModal(id) {
  document.getElementById(id).style.display = "none";
}

document.addEventListener("DOMContentLoaded", () => {
  const sections = document.querySelectorAll("section");
  const navLinks = document.querySelectorAll("header .menu");

  window.addEventListener("scroll", () => {
    let current = "";

    sections.forEach(section => {
      const sectionTop = section.offsetTop - 100;
      if (window.scrollY >= sectionTop) {
        current = section.getAttribute("id");
      }
    });

    navLinks.forEach(link => {
      link.classList.remove("active");
      if (link.getAttribute("href") === "#" + current) {
        link.classList.add("active");
      }
    });
  });
});

document.addEventListener("DOMContentLoaded", () => {
  carregarGrafo();
  document.getElementById("btnCalcular").addEventListener("click", calcular);
});

// --- ARVORE: carregar/desenhar ---
let cyArvore = null;

function desenharArvore(data) {
  // se já existe um cytoscape, destrói e recria
  if (cyArvore) {
    cyArvore.destroy();
    cyArvore = null;
  }

  cyArvore = cytoscape({
    container: document.getElementById('cy_arvore'),
    elements: [...data.nodes, ...data.edges],
    style: [
      { selector: 'node', style: {
          'content': 'data(label)',
          'text-valign': 'center',
          'text-halign': 'center',
          'width': 40,
          'height': 40,
          'font-size': 12,
          'background-color': '#9ae6b4',
          'border-color': '#2f855a',
          'border-width': 2
      }},
      { selector: 'edge', style: {
          'width': 3,
          'curve-style': 'bezier',
          'target-arrow-shape': 'triangle',
          'line-color': '#ccc',
          'target-arrow-color': '#ccc',
          'label': ''
      }},
      { selector: '.highlight', style: {
          'background-color': '#f6ad55', 'line-color': '#f6ad55', 'width': 50, 'height':50
      }}
    ],
    layout: { name: 'breadthfirst', directed: true, padding: 10, spacingFactor: 1.6 }
  });

  // centraliza
  cyArvore.fit();
}

function carregarArvore() {
  fetch('/arvore').then(r=>r.json()).then(data=>{
    // se não há nodes, cria um node vazio (para o cytoscape não quebrar)
    if (!data.nodes || data.nodes.length === 0) {
      document.getElementById('cy_arvore').innerHTML = '<p>Árvore vazia</p>';
      return;
    }
    desenharArvore(data);
  });
}
