// Define the strings and corresponding clues
const clues = {
    "from the heart": "grpuns",
    "naked pride": "ash",
    "down you slide": "het",
    "get one": "grpisn",
    "last chance to see": "star",
    "hearts to bear": "veha",
    "make it done": "urn"
};

// Function to handle the submission
document.getElementById("submit-btn").addEventListener("click", function() {
    const userInput = document.getElementById("input-field").value.trim().toLowerCase();
    const response = document.getElementById("goblin-response");
    const hint = document.getElementById("hint");

    if (clues[userInput]) {
        response.textContent = "The Goblin responds:";
        hint.textContent = clues[userInput];
        hint.style.color = "blue";
    } else {
        response.textContent = "The Goblin growls:";
        hint.textContent = "That is not the right phrase! Try again.";
        hint.style.color = "red";
    }

    // Clear the input field
    document.getElementById("input-field").value = "";
});
