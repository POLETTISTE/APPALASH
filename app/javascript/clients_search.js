document.addEventListener("DOMContentLoaded", function () {
  const searchInput = document.getElementById("search_input");

  searchInput.addEventListener("input", function () {
    const query = searchInput.value;

    fetch(`/clients?search=${query}`, {
      headers: {
        Accept: "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        const clientsDiv = document.getElementById("clients");
        clientsDiv.innerHTML = "";

        if (data.length > 0) {
          data.forEach((client) => {
            const clientDiv = document.createElement("div");
            clientDiv.classList.add("card-client");
            clientDiv.innerHTML = `
              <div>${client.name} ${client.firstname}</div>
              <p><a href="/clients/${client.id}">VOIR LE CLIENT</a></p>
            `;
            clientsDiv.appendChild(clientDiv);
          });
        } else {
          clientsDiv.innerHTML = "<p>No clients found</p>";
        }
      });
  });
});
