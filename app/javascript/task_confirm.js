const setupTaskSubmitConfirm = () => {
  const form = document.getElementById("task-form");
  const submitBtn = form?.querySelector('input[type="submit"][value="タスクを投稿"]');

  if (form && submitBtn && !submitBtn.dataset.confirmBound) {
    submitBtn.addEventListener("click", (event) => {
      const confirmed = window.confirm("編集の必要はありませんか？");
      if (!confirmed) {
        event.preventDefault(); // 送信中止
      }
    });

    // フラグをセット（同じ要素に二重登録しないため）
    submitBtn.dataset.confirmBound = "true";
  }
};

document.addEventListener("turbo:load", setupTaskSubmitConfirm);
document.addEventListener("turbo:render", setupTaskSubmitConfirm);