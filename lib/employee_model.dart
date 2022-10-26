class EmployeeModel {
   final String id;
   final String name;
   final String phone;
   final String email;
   final String adress;
   final String gender;
   final String birthday;
   final String prefix;

   EmployeeModel({
      required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.adress,
      required this.gender,
      required this.birthday,
      required this.prefix
   });

   factory EmployeeModel.fromJson(Map<String, dynamic> data) {
      return EmployeeModel(
         id: data['_id'],
         name: data['name'],
         phone: data['phone'],
         email: data['email'],
         adress: data['adress'],
         gender: data['gender'],
         birthday: data['birthday'],
         prefix: data['prefix']
      );
   }
}


















