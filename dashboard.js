window.onload = function () {

    let today = new Date().getDate();

    let activeDays = JSON.parse(localStorage.getItem("activeDays")) || [];

    if (!activeDays.includes(today)) {
        activeDays.push(today);
        localStorage.setItem("activeDays", JSON.stringify(activeDays));
    }

    let cal = document.getElementById("calendar");
cal.innerHTML = "";

for (let i = 1; i <= 30; i++) {
    let d = document.createElement("div");
    d.className = "day";

    if (activeDays.includes(i)) {
        d.classList.add("active");
    }

    d.innerText = i;
    cal.appendChild(d);
}
};
