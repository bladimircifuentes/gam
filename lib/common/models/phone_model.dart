class PhoneModel {
    String phone;

    PhoneModel({
        required this.phone,
    });

    factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
    };
}