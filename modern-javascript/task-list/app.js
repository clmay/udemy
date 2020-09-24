const form = document.querySelector('#task-form');
const taskInput = document.querySelector('#task-input');
const taskList = document.querySelector('#task-list');
const filter = document.querySelector('#filter-tasks');
const clearBtn = document.querySelector('#clear-tasks');

addTask = (e) => {
  e.preventDefault();
  if (taskInput.value === '') {
    return;
  }
  taskList.appendChild(newTask(taskInput.value));
  taskInput.value = '';
};

newTask = (text) => {
  const li = document.createElement('li');
  li.className = 'collection-item';
  li.appendChild(document.createTextNode(text));
  li.appendChild(newDeleteBtn());
  return li;
};

newDeleteBtn = () => {
  const a = document.createElement('a');
  a.className = 'delete-task secondary-content';
  a.innerHTML = '<i class="fa fa-trash"></i>';
  return a;
};

removeTask = (e) => {
  if (e.target.parentElement.classList.contains('delete-task')) {
    if (confirm('Are you sure?')) {
      e.target.parentElement.parentElement.remove();
    }
  }
};

clearTasks = () => {
  while (taskList.firstChild) {
    taskList.remove(taskList.firstChild);
  }
};

(() => {
  form.addEventListener('submit', addTask);
  taskList.addEventListener('click', removeTask);
  clearBtn.addEventListener('click', clearTasks);
})();
