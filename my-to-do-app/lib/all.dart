class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
   required this.id,
    required this.todoText,
    this.isDone = false,
});

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Bath', isDone: true),
      ToDo(id: '03', todoText: 'Cook',),
      ToDo(id: '04', todoText: 'Eat',),
      ToDo(id: '05', todoText: 'Work On Mobile App For At Least 2 Hours',),
      ToDo(id: '06', todoText: 'Dinner Date',),
    ];
  }
}