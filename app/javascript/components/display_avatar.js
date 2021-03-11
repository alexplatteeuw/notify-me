const readUrl = (input) => {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = (event) =>
      (document.querySelector("#avatar-container img").src =
        event.target.result);
    reader.readAsDataURL(input.files[0]); // convert to base64 string
  }
};

const displayAvatar = () => {
  const input = document.getElementById("user_avatar");
  if (input) {
    input.addEventListener("change", (event) => readUrl(event.target));
  }
};

export { displayAvatar };
