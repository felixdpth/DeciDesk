import $ from 'jquery';

const initTooltip = () => {
  const tooltip = document.querySelector('[data-toggle="tooltip"]')
  if (tooltip) {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
  }
}

export default initTooltip;

