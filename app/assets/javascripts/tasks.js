// タスク削除時のAjax処理
// document.addEventListener('turbolinks:load', function () {
//   document.querySelectorAll('.delete').forEach(function (a) {
//     a.addEventListener('ajax:success', function () {
//       let td = a.parentNode;
//       let tr = td.parentNode;
//       tr.style.display =  'none';
//     });
//   });
// });


// 一覧画面のtd要素の背景色をマウスオーバー時に変更する処理
document.addEventListener('turbolinks:load', function () {
  document.querySelectorAll('td').forEach(function(td) {
    td.addEventListener('mouseover', function (event) {
      event.currentTarget.style.backgroundColor = '#eff';
    });

    td.addEventListener('mouseout', function (event) {
      event.currentTarget.style.backgroundColor = '';
    });
  });
});

