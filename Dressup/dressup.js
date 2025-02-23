
// for setting the backdrops
// Get all the backdrop elements
const backdrops = document.querySelectorAll('.backdrop');

// get all item elements
const items = document.querySelectorAll('.item');

// Get the character box element
const characterBox = document.getElementById('character-box');

// Add event listeners to each backdrop
backdrops.forEach(backdrop => {
    backdrop.addEventListener('click', function() {
        // Get the image source of the clicked backdrop
        const backdropImage = this.querySelector('img').src;

        // Change the background image of the character box
        characterBox.style.backgroundImage = `url(${backdropImage})`;
    });
});

// Add event listeners to each item
items.forEach(item => {
    item.addEventListener('click', function () {
        //get the image source of the clicked item
        const itemImage = this.querySelector('img').src;

        //create new image element for the item
        const newItem = document.createElement('img');
        newItem.src = itemImage;
        newItem.classList.add('stacked-item');

        //add the item to the character box
        characterBox.appendChild(newItem);
    })
})

// Listen for clicks on the entire character box
document.getElementById('character-box').addEventListener('click', function(event) {
    // Check if the clicked element is an image (item)
    if (event.target.tagName === 'IMG' && event.target.classList.contains('stacked-item')) {
        // Remove the clicked item from the character box
        event.target.remove();
    }
});

//code to replace the rat image with the user uploaded image
// get the rat upload button
const ratUpload = document.getElementById('upload-button');
// get the user input url from the rat upload button
const newRat = document.getElementById('rat-url-input');
//get the rat image spot
const ratSpot = document.getElementById('rat');
// Replace the rat image with the new rat image when the upload button is clicked
ratUpload.onclick = function() {
    // Get the URL entered by the user
    const newRatURL = newRat.value;

    // Check if the URL is valid
    if (newRatURL) {
        // Set the rat image's src to the new URL
        ratSpot.src = newRatURL;
    } else {
        alert("Please enter a valid URL for the rat image.");
    }
};




// old js

//  // Make the DIV element draggable:
//     dragElement(document.getElementById("item"));
//
//  // document.addEventListener("DOMContentLoaded", () => {
//  //     document.querySelectorAll(".item").forEach((item) => {
//  //         dragElement(item);
//  //     });
//  // });
//
//     function dragElement(elmnt) {
//         var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
//
//         // Ensure the element has absolute positioning
//         elmnt.style.position = "absolute";
//
//         if (document.getElementById(elmnt.id + "-drag")) {
//         // if present, the header is where you move the DIV from:
//         document.getElementById(elmnt.id + "-drag").onmousedown = dragMouseDown;
//     } else {
//         // otherwise, move the DIV from anywhere inside the DIV:
//         elmnt.onmousedown = dragMouseDown;
//     }
//
//     function dragMouseDown(e) {
//         e = e || window.event;
//         e.preventDefault();
//         // get the mouse cursor position at startup:
//         pos3 = e.clientX;
//         pos4 = e.clientY;
//         document.onmouseup = closeDragElement;
//         // call a function whenever the cursor moves:
//         document.onmousemove = elementDrag;
//     }
//
//     function elementDrag(e) {
//     e = e || window.event;
//     e.preventDefault();
//     // calculate the new cursor position:
//     pos1 = pos3 - e.clientX;
//     pos2 = pos4 - e.clientY;
//     pos3 = e.clientX;
//     pos4 = e.clientY;
//     // set the element's new position:
//     elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
//     elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
// }
//
//     function closeDragElement() {
//     // stop moving when mouse button is released:
//     document.onmouseup = null;
//     document.onmousemove = null;
// }
// }



// // backdrop show/hide
//  // Aaand this is the code for the BGs
//  var backdrops = document.querySelectorAll('.backdrop');
//
//  for(var i = 0; i < backdrops.length; i++) {
//      backdrops[i].addEventListener('click', backdropSwitch(i));
//  }
//
//  function backdropSwitch() {
//      return function() {
//          var backdropImage = event.target.src;
//          var character = document.getElementById('rat');
//
//          // If the clicked BG is equipped, remove it; otherwise, apply the BG
//          if(character.style.backgroundImage == 'url("' + backdropImage + '")') {
//              character.style.backgroundImage = '';
//          } else {
//              character.style.backgroundImage = 'url("' + backdropImage + '")';
//          }
//
//
//      };
//  }


