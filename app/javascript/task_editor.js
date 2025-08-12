const updateLayout = () => {
    const taskDetail = document.getElementById('task-detail');
    const taskEditWrapper = document.getElementById('task-edit-wrapper');
    const editFormFrame = document.getElementById('edit_task');
    const editButton = document.querySelector('[data-turbo-frame="edit_task"]');

    // すべての要素が存在することを確認
    if (!taskDetail || !taskEditWrapper || !editFormFrame || !editButton) {
        return;
    }

    // 編集フォームが表示されているかどうかを判断
    const isEditing = !editFormFrame.classList.contains('hidden');

    if (isEditing) {
        // 編集中（フォームが表示されている）のレイアウト
        taskDetail.classList.remove('w-full');
        taskDetail.classList.add('md:w-1/2');
        taskEditWrapper.classList.remove('flex-col');
        taskEditWrapper.classList.add('flex-row');
        editButton.classList.add('hidden');
    } else {
        // 編集フォームが非表示のレイアウト
        taskDetail.classList.remove('md:w-1/2');
        taskDetail.classList.add('w-full');
        taskEditWrapper.classList.remove('flex-row');
        taskEditWrapper.classList.add('flex-col');
        editButton.classList.remove('hidden');
    }
};

// 編集フォームが読み込まれた時に、フォームを表示し、レイアウトを更新
window.handleTurboFrameLoad = (event) => {
    const targetFrame = event.target;
    if (targetFrame.id === 'edit_task') {
        targetFrame.classList.remove('hidden');
        updateLayout();
    }
};

// キャンセルボタンクリック時のハンドラ
window.handleCancelClick = (event) => {
    if (event.target.id === 'cancelEditButton') {
        const editFormFrame = document.getElementById('edit_task');
        if (editFormFrame) {
            editFormFrame.classList.add('hidden');
            updateLayout();
        }
    }
};

// 各イベントリスナーを登録
// ページの初期読み込み時とTurbo StreamによるDOM更新後にレイアウトを再計算
document.addEventListener('turbo:load', updateLayout);
document.addEventListener('turbo:render', updateLayout);

// 編集フォームの読み込み完了時にレイアウトを調整
document.addEventListener('turbo:frame-load', window.handleTurboFrameLoad);

// キャンセルボタンクリック時にレイアウトを調整
document.addEventListener('click', window.handleCancelClick);