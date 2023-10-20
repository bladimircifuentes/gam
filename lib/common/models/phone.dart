class Phone {
    String phone;

    Phone({
        required this.phone,
    });

    factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
    };
}