document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("task-form");
  const editingInput = document.getElementById("needs_editing");

  form.addEventListener("submit", (event) => {
    const clickedButton = document.activeElement;  // 押されたボタンを取得
    const editing = clickedButton.dataset.editing;

    // true/falseに応じて hidden の値を変更
    if (editingInput && editing !== undefined) {
      editingInput.value = editing === "true" ? "true" : "false";
    }
  });
});