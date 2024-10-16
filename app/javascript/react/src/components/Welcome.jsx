import React from "react";
import ReactDOM from "react-dom/client"; // Import for React 18+

// Correcting the Welcome component to properly use props
const Welcome = ({ name = "Stéphane" }) => {
  return (
    <div className="container">
      <h1>HELLO WORLD FROM REACT {name}</h1>
      <p className="lead">first lecture</p>
    </div>
  );
};

// Function to render the Welcome component
const renderWelcomeComponent = () => {
  const rootElement = document.getElementById("welcome");

  // Check if the rootElement exists
  if (!rootElement) {
    // console.error('Target container "welcome" not found in the DOM.');
    return;
  }

  // Using React 18's createRoot for rendering
  const root = ReactDOM.createRoot(rootElement);
  root.render(<Welcome />);
};

// Using DOMContentLoaded to ensure the DOM is fully loaded before rendering
document.addEventListener("DOMContentLoaded", renderWelcomeComponent);

export default Welcome;
