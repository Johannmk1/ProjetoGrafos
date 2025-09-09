let cy;
let vertices = [];

function desenharGrafo(data) {
  cy = cytoscape({
    container: document.getElementById("cy"),
    elements: [...data.nodes, ...data.edges],
    style: [
      { selector: "node", style: { "content": "data(label)", "background-color": "#61bffc", "color": "#000" }},
      { selector: "edge", style: { "label": "data(weight)", "width": 2, "line-color": "#ccc", "curve-style": "bezier" }},
      { selector: ".highlighted", style: { "line-color": "red", "width": 4 }}
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

    cy.elements().removeClass("highlighted");
    const path = data.caminho.split("->");
    for (let i = 0; i < path.length - 1; i++) {
      cy.edges().filter(e =>
        (e.data("source") === path[i] && e.data("target") === path[i+1]) ||
        (e.data("source") === path[i+1] && e.data("target") === path[i])
      ).addClass("highlighted");
    }
  });
}

document.addEventListener("DOMContentLoaded", () => {
  carregarGrafo();
  document.getElementById("btnCalcular").addEventListener("click", calcular);
});
