import { dbank_backend } from "../../declarations/dbank_backend";

window.addEventListener("load", async function() {
  console.log("Finished loading");
  update();
});

async function update() {
  const currentAmount = await dbank_backend.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
};

document.querySelector("form").addEventListener("submit", async function(event) {
  // prevents page reload, or amount enter in form refresh, until transaction finishes and display new balace
  event.preventDefault();
  console.log("query Submitted.");

  const button = event.target.querySelector("#submit-btn");

  // coverts to Float, because all the function variables are in Float values
  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  // disable the button until transaction is finished
  button.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) {
    await dbank_backend.deposit_pub(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await dbank_backend.withdrawl_pub(outputAmount);
  }

  await dbank_backend.compound();

  // updates the balance, call function
  update()

  // reset the value of the form after the transaction and the balanced is updated
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled");

});

