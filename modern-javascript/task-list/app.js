const form = document.querySelector('#task-form');
const taskInput = document.querySelector('#task-input');
const taskList = document.querySelector('#task-list');
const filter = document.querySelector('#filter-tasks');
const clearBtn = document.querySelector('#clear-tasks');

getTasks = () => {
  let tasks = tasksInLocalStorage();
  tasks.forEach((task) => {
    if (task === '') {
      return;
    }
    taskList.appendChild(newTask(task));
  });
};

tasksInLocalStorage = () => {
  let tasks;
  if (localStorage.getItem('tasks') === null) {
    tasks = [];
  } else {
    tasks = JSON.parse(localStorage.getItem('tasks'));
  }
  return tasks;
};

addTask = (e) => {
  e.preventDefault();
  task = taskInput.value;
  if (task === '') {
    return;
  }
  taskList.appendChild(newTask(task));
  addToLocalStorage(task);
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

addToLocalStorage = (task) => {
  let tasks = tasksInLocalStorage();
  tasks.push(task);
  localStorage.setItem('tasks', JSON.stringify(tasks));
};

removeTask = (e) => {
  if (e.target.parentElement.classList.contains('delete-task')) {
    if (confirm('Are you sure?')) {
      elem = e.target.parentElement.parentElement;
      elem.remove();
      removeFromLocalStorage(elem);
    }
  }
};

removeFromLocalStorage = (taskItem) => {
  let tasks = tasksInLocalStorage();
  tasks.forEach((task, index) => {
    if (taskItem.textContent === task) {
      tasks.splice(index, 1);
    }
  });
  localStorage.setItem('tasks', JSON.stringify(tasks));
};

clearTasks = () => {
  while (taskList.firstChild) {
    taskList.removeChild(taskList.firstChild);
  }
  localStorage.removeItem('tasks');
};

filterTasks = (e) => {
  const text = e.target.value.toLowerCase();
  document.querySelectorAll('.collection-item').forEach(
    (task) => {
      const item = task.firstChild.textContent;
      if (item.toLowerCase().indexOf(text) == -1) {
        task.style.display = 'none';
      } else {
        task.style.display = 'block';
      }
    }
  );
};

(() => {
  document.addEventListener('DOMContentLoaded', getTasks);
  form.addEventListener('submit', addTask);
  taskList.addEventListener('click', removeTask);
  clearBtn.addEventListener('click', clearTasks);
  filter.addEventListener('keyup', filterTasks);
})();
