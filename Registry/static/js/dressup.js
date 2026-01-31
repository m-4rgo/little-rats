document.addEventListener("DOMContentLoaded", () => {
    const userSelectDiv = document.querySelector(".select-user");
    const ratSelectDiv = document.querySelector(".select-rat");
    const itemsDiv = document.querySelector(".dressup-items");
    const dollImg = document.querySelector(".dressup-doll img");
    const stage = document.querySelector(".foreground-items");
    const placedCounts = {};   // {itemId: count}
    const inventoryLimits = {}; // {itemId: max}


    let currentUserId = null;

    // ---------- CREATE SEARCHABLE DROPDOWN ----------
    function createSearchSelect(container, placeholder, onSelect) {
        container.innerHTML = ""; // reset if reused

        const input = document.createElement("input");
        input.placeholder = placeholder;

        const list = document.createElement("div");
        list.className = "select-list";
        list.style.display = "none";

        container.appendChild(input);
        container.appendChild(list);

        // filter options while typing
        input.addEventListener("input", () => {
            const term = input.value.toLowerCase();
            list.style.display = "block";

            [...list.children].forEach(opt => {
                opt.style.display = opt.textContent.toLowerCase().includes(term)
                    ? "block"
                    : "none";
            });
        });

        // reopen list when user clicks back into box
        input.addEventListener("focus", () => {
            list.style.display = "block";
        });

        // close if clicking elsewhere
        document.addEventListener("click", e => {
            if (!container.contains(e.target)) {
                list.style.display = "none";
            }
        });

        return {
            setOptions(options) {
                list.innerHTML = "";

                options.forEach(opt => {
                    const div = document.createElement("div");
                    div.textContent = opt.name;

                    div.addEventListener("click", () => {
                        input.value = opt.name;
                        list.style.display = "none";
                        onSelect(opt);
                    });

                    list.appendChild(div);
                });
            }
        };
    }


    // ---------- LOAD USERS ----------
    fetch("/api/users")
        .then(r => r.json())
        .then(users => {
            const userSelect = createSearchSelect(
                userSelectDiv,
                "Select user...",
                user => {
                    currentUserId = user.id;

                    // reset everything tied to previous user
                    ratSelectDiv.innerHTML = "";
                    itemsDiv.innerHTML = "";
                    stage.innerHTML = "";
                    dollImg.src = "";

                    Object.keys(placedCounts).forEach(k => delete placedCounts[k]);
                    Object.keys(inventoryLimits).forEach(k => delete inventoryLimits[k]);

                    loadRats(user.id);
                    loadItems(user.id);
                }
            );

            userSelect.setOptions(users);
        });


    // ---------- LOAD RATS ----------
    function loadRats(userId) {
        fetch(`/api/user/${userId}/rats`)
            .then(r => r.json())
            .then(rats => {
                const ratSelect = createSearchSelect(ratSelectDiv, "Select rat...", rat => {
                    dollImg.src = `/static/${rat.image_path}`;
                });
                ratSelect.setOptions(rats);
            });
    }

    // ---------- LOAD ITEMS ----------
    // ---------- LOAD ITEMS ----------
    function loadItems(userId) {
        itemsDiv.innerHTML = "";
        Object.keys(placedCounts).forEach(k => delete placedCounts[k]);
        Object.keys(inventoryLimits).forEach(k => delete inventoryLimits[k]);

        fetch(`/api/user/${userId}/items`)
            .then(r => r.json())
            .then(items => {
                items.forEach(item => {
                    inventoryLimits[item.id] = item.quantity;
                    placedCounts[item.id] = 0;

                    const img = document.createElement("img");
                    img.src = `/static/${item.image_path}`;
                    img.className = "dressup-item";
                    img.title = `${item.name} (${item.quantity})`;
                    img.dataset.itemId = item.id; // store ID for reference

                    img.addEventListener("click", () => {
                        if (placedCounts[item.id] >= inventoryLimits[item.id]) return;
                        addItemToStage(item, img);
                    });

                    itemsDiv.appendChild(img);
                });
            });
    }

// ---------- ADD ITEM TO STAGE ----------
    function addItemToStage(item, inventoryImg) {
        placedCounts[item.id]++;

        // toggle empty state if max reached
        if (placedCounts[item.id] >= inventoryLimits[item.id]) {
            inventoryImg.classList.add("dressup-empty");
        }

        const img = document.createElement("img");
        img.src = `/static/${item.image_path}`;
        img.dataset.itemId = item.id;
        img.className = "stage-item";
        img.style.left = "40px";
        img.style.top = "40px";

        makeDraggable(img);

        // right-click removes item
        img.addEventListener("contextmenu", e => {
            e.preventDefault();
            placedCounts[item.id]--;
            img.remove();

            // remove empty state if below max
            if (placedCounts[item.id] < inventoryLimits[item.id]) {
                inventoryImg.classList.remove("dressup-empty");
            }
        });

        stage.appendChild(img);
    }



    // ---------- DRAG SYSTEM ----------
    function makeDraggable(elmnt) {
        const scene = stage; // your .foreground-items container
        const marginPercent = 0.3; // allow slight overflow

        let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

        elmnt.onmousedown = dragMouseDown;
        elmnt.ondragstart = () => false; // stop browser image ghost

        function dragMouseDown(e) {
            e.preventDefault();

            // bring to front when grabbed
            elmnt.style.zIndex = Date.now();

            pos3 = e.clientX;
            pos4 = e.clientY;

            document.onmouseup = stopDrag;
            document.onmousemove = drag;
        }

        function drag(e) {
            e.preventDefault();

            pos1 = pos3 - e.clientX;
            pos2 = pos4 - e.clientY;
            pos3 = e.clientX;
            pos4 = e.clientY;

            let newLeft = elmnt.offsetLeft - pos1;
            let newTop  = elmnt.offsetTop  - pos2;

            const sceneRect = scene.getBoundingClientRect();
            const elmRect   = elmnt.getBoundingClientRect();

            const marginX = elmRect.width * marginPercent;
            const marginY = elmRect.height * marginPercent;

            // X bounds
            if (newLeft < -marginX) newLeft = -marginX;
            if (newLeft + elmRect.width > sceneRect.width + marginX) {
                newLeft = sceneRect.width + marginX - elmRect.width;
            }

            // Y bounds
            if (newTop < -marginY) newTop = -marginY;
            if (newTop + elmRect.height > sceneRect.height + marginY) {
                newTop = sceneRect.height + marginY - elmRect.height;
            }

            elmnt.style.left = newLeft + "px";
            elmnt.style.top  = newTop  + "px";
        }

        function stopDrag() {
            document.onmouseup = null;
            document.onmousemove = null;
        }
    }



});
