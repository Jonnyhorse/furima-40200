const pay = () => {
  const form = document.getElementById('button')
  form.addEventListener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });

window.addEventListener("turbo:load", pay);
