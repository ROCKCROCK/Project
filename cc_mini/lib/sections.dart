class Sections {
  int? id;
  String? name;
  String? description;
  bool? isEditing;

  Sections({this.id, this.name, this.isEditing, this.description});

  static List<Sections> sectionList() {
    return [
      Sections(
          id: 1, name: 'Profile Summary', isEditing: false, description: ' A'),
      Sections(
          id: 2,
          name: 'Academic and  CoCurricular Achievements ',
          isEditing: false,
          description: 'B'),
      Sections(
          id: 3,
          name: 'Summer Internship Period',
          isEditing: false,
          description: 'C'),
      Sections(
          id: 4, name: 'Work Experience', isEditing: false, description: 'D'),
      Sections(id: 5, name: 'Projects', isEditing: false, description: 'E'),
      Sections(
          id: 6, name: 'Certifications', isEditing: false, description: 'F'),
      Sections(
          id: 7,
          name: 'Leadership Positions',
          isEditing: false,
          description: 'G'),
      Sections(
          id: 8, name: 'ExtraCurricular', isEditing: false, description: 'H'),
      Sections(id: 9, name: 'Education', isEditing: false, description: 'I'),
    ];
  }
}
