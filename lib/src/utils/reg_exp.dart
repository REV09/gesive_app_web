RegExp alfanumericExpression = RegExp("[A-Za-z0-9]+");
RegExp specialCharacters = RegExp("/\(\)=!<>\?\{\}\[\]@&\|%@#\$%\^");
RegExp alfabeticCharacters = RegExp("([A-Za-z]+( [A-Za-z]+)+)");
RegExp dateValidator = RegExp("[0-9]{4}-[0-9]{2}-[0-9]{2}");
RegExp numberValidator = RegExp("[0-9]+");
RegExp phoneNumberValidator = RegExp(r"^(?:[+0]9)?[0-9]{10}$");
RegExp nameValidator = RegExp("[A-Za-z]+");
RegExp modelVehicleValidator = RegExp("[A-Za-z0-9]+(-[A-Za-z0-9]+)+");
RegExp licensePlatesValidator = RegExp("[A-Za-z0-9]+(-[A-Za-z0-9]+)+");
RegExp cardExtensionValidator = RegExp(r'^\d{16}$');
RegExp expirationDateValidator = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
RegExp cvvValidator = RegExp(r'^\d{3,4}$');

