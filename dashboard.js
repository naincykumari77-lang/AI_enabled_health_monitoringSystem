window.onload = function () {

    // USER
    let user = localStorage.getItem("username");
    document.getElementById("welcome").innerText =
        user ? "Welcome " + user + " 👋" : "Welcome Guest";

    // HEALTH
    document.getElementById("hr").innerText =
        localStorage.getItem("hr") || "--";

    document.getElementById("bp").innerText =
        localStorage.getItem("bp") || "--";

    document.getElementById("steps").innerText =
        localStorage.getItem("steps") || "--";

    document.getElementById("cal").innerText =
        localStorage.getItem("cal") || "--";

    // DIET
    document.getElementById("diet").innerText =
        localStorage.getItem("diet") || "No Diet";

    // FITNESS
    document.getElementById("fitness").innerText =
        localStorage.getItem("fitnessSteps") || "No Data";

    // MEDICATION
    let med = localStorage.getItem("medicine");
    let time = localStorage.getItem("medTime");

    document.getElementById("medicine").innerText =
        med ? med + " at " + time : "No Medicine";

    // APPOINTMENT
    let doc = localStorage.getItem("appointment");
    let date = localStorage.getItem("appDate");

    document.getElementById("appointment").innerText =
        doc ? doc + " on " + date : "No Appointment";


    // CALENDAR
    let activeDays = JSON.parse(localStorage.getItem("activeDays")) || [];
    let today = new Date().getDate();

    if (!activeDays.includes(today)) {
        activeDays.push(today);
        localStorage.setItem("activeDays", JSON.stringify(activeDays));
    }

    let calDiv = document.getElementById("calendar");

    for (let i = 1; i <= 30; i++) {
        let d = document.createElement("div");
        d.className = "day";

        if (activeDays.includes(i)) d.classList.add("active");

        d.innerText = i;
        calDiv.appendChild(d);
    }
};