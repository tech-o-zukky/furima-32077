function price(){

  const sellPrice = document.getElementById("item-price");

  sellPrice.addEventListener("input", () => {
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    const taxPrice = Math.floor(sellPrice.value * 0.1);
    const profitPrice = Math.floor(sellPrice.value - (sellPrice.value * 0.1));

    addTaxPrice.innerHTML = taxPrice.toLocaleString();
    profit.innerHTML = profitPrice.toLocaleString();
  });
};

window.addEventListener('load', price);