import React from "react";
import { createRoot } from "react-dom/client"; // Correct import for React 18+

const PeopleList = ({ people }) => {
  return (
    people?.length > 0 && (
      <div>
        {people.map((person, index) => (
          <div className="person" key={index}>
            <h2>Name: {person.name}</h2>
            <p>City: {person.city}</p>
          </div>
        ))}
      </div>
    )
  );
};

const initializeReactApp = () => {
  const rootElement = document.getElementById("people-list");

  // Ensure rootElement is not null
  if (rootElement) {
    const peopleDataString = rootElement.getAttribute("data-people");
    console.log("People Data String:", peopleDataString); // Log the data string

    try {
      const peopleData = JSON.parse(peopleDataString);
      console.log("Parsed People Data:", peopleData); // Log the parsed data

      // Check if root is already initialized
      if (!rootElement._reactRootContainer) {
        // Create a new root if it doesn't exist
        const root = createRoot(rootElement);
        root.render(<PeopleList people={peopleData} />);
        // Store the reference to the root container
        rootElement._reactRootContainer = root;
      } else {
        // If root is already initialized, use it to render
        rootElement._reactRootContainer.render(
          <PeopleList people={peopleData} />
        );
      }
    } catch (error) {
      console.error("Error parsing JSON:", error); // Log any parsing errors
    }
  } else {
    // console.error('Target container "people-list" not found in the DOM.');
  }
};

// Run initializeReactApp on DOMContentLoaded
document.addEventListener("DOMContentLoaded", initializeReactApp);

// Also run it immediately if the DOM is already loaded (in case the script runs after DOMContentLoaded has fired)
if (
  document.readyState === "complete" ||
  document.readyState === "interactive"
) {
  initializeReactApp();
}

export default PeopleList;
