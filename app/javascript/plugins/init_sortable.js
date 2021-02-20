import Sortable from 'sortablejs'
import $ from 'jquery'

const initSortable = () => {
  const sortable = document.querySelector('.sortable')
  if (sortable) {
    [".todo-list", ".progress-list", ".done-list"].forEach((listName) => {
      const listElement = document.querySelector(listName)
      Sortable.create(listElement, {
          group: 'shared',
          animation: 150
      });
    })
  }
};

export default initSortable
