void main() {
  var fruits = ['orange', 'banana', 'watermelon', 'pineapple'];

  // print(fruits.contains('banana'));

  // var mappedFruits = fruits.map((fruit) => 'I like $fruit');

  // print(mappedFruits);

  List<Map<String, dynamic>> persons = [
    {'name': 'Jhon', 'age': 16},
    {'name': 'Peter', 'age': 40},
    {'name': 'Jane', 'age': 31},
    {'name': 'Mary', 'age': 23},
    {'name': 'Ineza', 'age': 25},
    {'name': 'Audry', 'age': 63},
  ];

  // var result = persons.every((person) => person['age'] <= 60);
  // var result = persons.where((person) => person['age'] == 16);

  // var result = persons.followedBy([
  //   {'name': 'nadia', 'age': 28},
  // ]);

  //persons.add({'name': 'Nadia', 'age': 28});

  // persons.forEach((person) => print(person['name']));

  // var result = persons.map<dynamic>((e) => e['age']).reduce((a, b) => a + b);
  // print(result);

  var numbers = [1, 3, 2, 5, 4];

  numbers.sort((num1, num2) => num1 - num2);

  // print(numbers.reversed);

  numbers.clear();
  print(numbers);
}
