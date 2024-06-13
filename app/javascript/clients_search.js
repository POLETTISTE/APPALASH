// document.addEventListener("DOMContentLoaded", function () {
//   const searchInput = document.getElementById("search_input");

//   searchInput.addEventListener("input", function () {
//     const query = searchInput.value.trim(); // Trim to remove leading/trailing spaces

//     // Check if query is empty
//     if (query === "") {
//       const clientsDiv = document.getElementById("clients");
//       clientsDiv.innerHTML = "";
//       return;
//     }

//     fetch(`/clients?search=${query}`, {
//       headers: {
//         Accept: "application/json",
//       },
//     })
//       .then((response) => response.json())
//       .then((data) => {
//         const clientsDiv = document.getElementById("clients");
//         clientsDiv.innerHTML = "";

//         if (data.length > 0) {
//           data.forEach((client) => {
//             const clientDiv = document.createElement("div");
//             clientDiv.classList.add("card-client");
//             clientDiv.innerHTML = `
//               <div>${client.name} ${client.firstname}</div>
//               <p><a href="/clients/${client.id}">VOIR LE CLIENT</a></p>
//             `;
//             clientsDiv.appendChild(clientDiv);
//           });
//         } else {
//           clientsDiv.innerHTML = "<p>Aucune correspondance</p>";
//         }
//       })
//       .catch((error) => {
//         console.error("Error fetching clients:", error);
//         // Handle error if necessary
//       });
//   });
// });
