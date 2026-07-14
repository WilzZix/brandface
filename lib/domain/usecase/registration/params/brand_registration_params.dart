final class BrandRegistrationParams {
  final String brandName;

  BrandRegistrationParams({required this.brandName});

  Map<String, dynamic> toJson() => {'brand_name': brandName};
}
