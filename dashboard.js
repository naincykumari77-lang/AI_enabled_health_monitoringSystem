window.onload = function () {

    // USER
    let user = localStorage.getItem("username");
    let welcome = document.getElementById("welcome");
    if (welcome) {
        welcome.innerText = user ? "Welcome " + user + " 👋" : "Welcome Guest";
    }

    // HEALTH
    let setVal = (id, key, def="--") => {
        let el = document.getElementById(id);
        if (el) el.innerText = localStorage.getItem(key) || def;
    };

    setVal("hr", "hr");
    setVal("bp", "bp");
    setVal("steps", "steps");
    setVal("cal", "cal");

    // DIET
    setVal("diet", "diet", "No Diet");

    // FITNESS
    setVal("fitness", "fitnessSteps", "No Data");

    // MEDICATION
    let med = localStorage.getItem("medicine");
    let time = localStorage.getItem("medTime");
    let medEl = document.getElementById("medicine");

    if (medEl) {
        medEl.innerText = med ? med + " at " + time : "No Medicine";
    }

    // APPOINTMENT
    let doc = localStorage.getItem("appointment");
    let date = localStorage.getItem("appDate");
    let appEl = document.getElementById("appointment");

    if (appEl) {
        appEl.innerText = doc ? doc + " on " + date : "No Appointment";
    }

    // ✅ CALENDAR FIX
    let calDiv = document.getElementById("calendar");

    if (!calDiv) return;

    calDiv.innerHTML = ""; // 🔥 CLEAR OLD DATA

    let activeDays = JSON.parse(localStorage.getItem("activeDays")) || [];

    let today = new Date().getDate();

    if (!activeDays.includes(today)) {
        activeDays.push(today);
        localStorage.setItem("activeDays", JSON.stringify(activeDays));
    }

    let totalDays = new Date().getDate(); // current day (simple view)

    for (let i = 1; i <= 30; i++) {
        let d = document.createElement("div");
        d.className = "day";

        if (activeDays.includes(i)) {
            d.classList.add("active");
        }

        d.innerText = i;
        calDiv.appendChild(d);
    }
};