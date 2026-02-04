document.addEventListener("DOMContentLoaded", () => {
    const userSelectDiv = document.querySelector(".select-user");
    const ratSelectDiv = document.querySelector(".select-rat");
    const itemsDiv = document.querySelector(".dressup-items");
    const dollImg = document.querySelector(".dressup-doll img");
    const stage = document.querySelector(".foreground-items");
    // const wallpapersDiv = document.querySelector(".dressup-wallpapers");
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

                    const wallpapersDiv = document.querySelector(".dressup-wallpapers");
                    wallpapersDiv.innerHTML = "";  // clear previous wallpapers

                    const wallpaperDiv = document.querySelector(".dressup-wallpaper");
                    wallpaperDiv.style.backgroundImage = ""; // remove wallpaper from stage
                    delete wallpaperDiv.dataset.currentWallpaper;

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
    function loadItems(userId) {
        const itemsDiv = document.querySelector(".dressup-items");
        const wallpapersDiv = document.querySelector(".dressup-wallpapers");
        itemsDiv.innerHTML = "";
        wallpapersDiv.innerHTML = "";

        Object.keys(placedCounts).forEach(k => delete placedCounts[k]);
        Object.keys(inventoryLimits).forEach(k => delete inventoryLimits[k]);

        // 1️⃣ Load wallpapers/items from database first
        fetch(`/api/user/${userId}/items`)
            .then(r => r.json())
            .then(items => {
                items.forEach(item => {
                    if (item.item_type === "wallpaper") {
                        addWallpaperHotbar(item);  // user inventory wallpapers first
                    } else {
                        // normal items
                        inventoryLimits[item.id] = item.quantity;
                        placedCounts[item.id] = 0;

                        const img = document.createElement("img");
                        img.src = `/static/${item.image_path}`;
                        img.className = "dressup-item";
                        img.title = `${item.name} (${item.quantity})`;
                        img.dataset.itemId = item.id;

                        img.addEventListener("click", () => {
                            if (placedCounts[item.id] >= inventoryLimits[item.id]) return;
                            addItemToStage(item, img);
                        });

                        itemsDiv.appendChild(img);
                    }
                });

                // 2️⃣ Load default wallpapers AFTER user wallpapers
                const defaultWallpapers = [
                    // { name: "Default 1", image_path: "items/circus_hills_2026.png" },
                    { name: "Default 2", image_path: "wallpapers/default_wallpaper.png" },
                    { name: "Default 3", image_path: "wallpapers/hubble_wallpaper_1.png" },
                    { name: "Default 3", image_path: "wallpapers/hubble_wallpaper_2.png" },
                    { name: "Default 3", image_path: "wallpapers/hubble_wallpaper_3.png" },
                    { name: "Default 3", image_path: "wallpapers/hubble_wallpaper_4.png" },
                    { name: "Default 3", image_path: "wallpapers/hubble_wallpaper_5.png" }
                ];


                defaultWallpapers.forEach(wp => addWallpaperHotbar(wp));

                // 3️⃣ Add Remove Wallpaper button at the end
                const removeBtn = document.createElement("button");
                removeBtn.textContent = "Remove Wallpaper";
                // removeBtn.style.marginLeft = "1rem";
                removeBtn.addEventListener("click", () => {
                    const wallpaperDiv = document.querySelector(".dressup-wallpaper");
                    wallpaperDiv.style.backgroundImage = "";
                    delete wallpaperDiv.dataset.currentWallpaper;
                });
                wallpapersDiv.appendChild(removeBtn);
            });

        // 4️⃣ Function to add a wallpaper to hotbar
        function addWallpaperHotbar(wp) {
            const img = document.createElement("img");
            img.src = `/static/${wp.image_path}`;
            img.className = "wallpaper-item";
            img.title = wp.name;

            img.addEventListener("click", () => {
                const wallpaperDiv = document.querySelector(".dressup-wallpaper");
                wallpaperDiv.style.backgroundImage = `url(/static/${wp.image_path})`;
                wallpaperDiv.dataset.currentWallpaper = wp.image_path;
            });

            wallpapersDiv.appendChild(img);
        }
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

        // Apply scale if present
        if (item.item_scale) {
            const scaleFactor = item.item_scale / 100;
            img.style.transform = `scale(${scaleFactor})`;
            img.style.transformOrigin = "top left"; // keep positioning consistent
        }

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
