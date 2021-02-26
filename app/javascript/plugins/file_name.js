const fileName = () => {
  const reportButton = document.querySelector("#report_csv_file")
  const fileInput = document.querySelector(".file-input");
  const fileNameDisplay = document.querySelector(".file-name");
  reportButton.addEventListener('change', () => {
    fileNameDisplay.innerHTML = reportButton.value.replace(/.{12}/,'');
  })
}
export default fileName;
