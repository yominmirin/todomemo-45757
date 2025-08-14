let confirmEnabled = localStorage.getItem("confirmEnabled") !== "false"; // 初期値: true

const setupTaskSubmitConfirm = () => {
  const form = document.getElementById("task-form");
  const submitBtn = form?.querySelector('input[type="submit"][value="タスクを投稿"]');

  if (form && submitBtn && !submitBtn.dataset.confirmBound) {
    submitBtn.addEventListener("click", (event) => {
      if (confirmEnabled) {
        const confirmed = window.confirm("編集の必要はありませんか？");
        if (!confirmed) {
          event.preventDefault(); // 送信中止
        }
      }
    });

    submitBtn.dataset.confirmBound = "true";
  }
};

// ボタンのクリックをdocumentで監視（差し替えにも対応）
document.addEventListener("click", (event) => {
  if (event.target.id === "toggleConfirmBtn") {
    confirmEnabled = !confirmEnabled;
    localStorage.setItem("confirmEnabled", confirmEnabled);
    event.target.textContent = `確認ダイアログ: ${confirmEnabled ? "ON" : "OFF"}`;
  }
});

const updateToggleButtonLabel = () => {
  const toggleBtn = document.getElementById("toggleConfirmBtn");
  if (toggleBtn) {
    toggleBtn.textContent = `確認ダイアログ: ${confirmEnabled ? "ON" : "OFF"}`;
  }
};

document.addEventListener("turbo:load", () => {
  setupTaskSubmitConfirm();
  updateToggleButtonLabel();
});

document.addEventListener("turbo:render", () => {
  setupTaskSubmitConfirm();
  updateToggleButtonLabel();
});