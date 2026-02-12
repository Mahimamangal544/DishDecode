function addRow(button) {

    // जिस row पर Add क्लिक किया गया
    let currentRow = button.closest(".ingredient-row");

    // उसी category का लेबल
    let typeLabel = currentRow.querySelector("label").innerText.trim();

    // उसी category की सभी rows ढूँढो
    let allRows = document.querySelectorAll(".ingredient-row");

    // उसी category के आखिरी row को ढूँढने के लिए
    let lastRowOfCategory = null;

    allRows.forEach(row => {
        let label = row.querySelector("label").innerText.trim();
        if (label === typeLabel) {
            lastRowOfCategory = row;
        }
    });

    // Template clone करना
    let newRow = currentRow.cloneNode(true);

    // Select और input fields empty करना
    newRow.querySelectorAll("select").forEach(sel => sel.selectedIndex = 0);
    newRow.querySelectorAll("input").forEach(inp => inp.value = "");

    // नया row: उसी category के आखिरी row के नीचे add हो
    lastRowOfCategory.insertAdjacentElement("afterend", newRow);
}


function removeRow(button) {

    let row = button.closest(".ingredient-row");

    let typeLabel = row.querySelector("label").innerText.trim();

    // count how many rows exist for this category
    let rows = document.querySelectorAll(".ingredient-row");
    let sameCategoryCount = 0;

    rows.forEach(r => {
        let label = r.querySelector("label").innerText.trim();
        if (label === typeLabel) sameCategoryCount++;
    });

    if (sameCategoryCount <= 1) {
        alert("minimum one row is nessary");
        return;
    }

    row.remove();
}
