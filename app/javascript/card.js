const pay = () => {
  const payjp = Payjp('pk_test_d722e1b308f7f932edb37b9d')// PAY.JPテスト公開鍵
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });
};

window.addEventListener("load", pay);