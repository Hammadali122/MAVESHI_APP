enum Sex { male, female }

class Animal {
  String name;
  String animalBreed;
  String image;
  String description;
  int age;
  Sex sex;
  double weight;
  String animalId;
  Animal(
      {required this.name,
      required this.animalId,
      required this.image,
      required this.age,
      required this.description,
      required this.animalBreed,
      required this.sex,
      required this.weight});
}
