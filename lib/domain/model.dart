class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contact {
  String email;
  String phone;
  String link;
  Contact(this.email, this.link, this.phone);
}

class Authentication {
  Customer? customer;
  Contact? contact;
  Authentication(this.customer, this.contact);
}
