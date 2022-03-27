import 'package:flutter/material.dart';

String genderText(int val) {
  //print("GenderTextSwitch val: " + val.toString());
  switch (val) {
    case 1:
      return "Male";
      break;
    case 2:
      return "Female";
      break;
    default:
      return "Unisex";
      break;
  }
}

String occupiedText(bool val) {
  //print("occupiedText val: " + val.toString());
  if (val) {
    return "Occupied";
  } else {
    return "Unoccupied";
  }
}

String smellText(int val) {
  //print("smellText val: " + val.toString());
  if (val < 0) {
    return "Not logs registerd yet";
  }
  if (val >= 0 && val <= 2) {
    return "No lingering smell";
  }
  if (val >= 3 && val <= 8) {
    return "Small lingering smell";
  }
  return "Heavy lingering smell";
}

Widget occupiedIconWidget(bool val, int gender) {
  //print(gender);
  if (val) {
    switch (gender) {
      case 0:
        return Image(
            image: AssetImage('assets/icons/details/Occupied_Both.png'));
        break;
      case 1:
        return Image(
            image: AssetImage('assets/icons/details/Occupied_Male.png'));
        break;
      case 2:
        return Image(
            image: AssetImage('assets/icons/details/Occupied_Female.png'));
        break;
    }
  }
  switch (gender) {
    case 0:
      return Image(
          image: AssetImage('assets/icons/details/Unoccupied_Both.png'),
          height: 45,
          width: 50);
      break;
    case 1:
      return Image(
          image: AssetImage('assets/icons/details/Unoccupied_Male.png'),
          height: 45,
          width: 50);
      break;
    case 2:
      return Image(
          image: AssetImage('assets/icons/details/Unoccupied_Female.png'),
          height: 45,
          width: 50);
      break;
  }

  // Default return so compiler does not complain :3
  return Image(
      image: AssetImage('assets/icons/details/Occupied_Both.png'),
      height: 45,
      width: 50);
}

Widget liquidIconWidget(int val) {
  //print("Liquid val: " + val.toString());
  if (val >= 0 && val <= 10) {
    return Image(
        image: AssetImage('assets/icons/details/Liquid_0%.png'),
        height: 45,
        width: 50);
  } else if (val >= 11 && val <= 35) {
    return Image(
        image: AssetImage('assets/icons/details/Liquid_25%.png'),
        height: 45,
        width: 50);
  } else if (val >= 36 && val <= 65) {
    return Image(
        image: AssetImage('assets/icons/details/Liquid_75%.png'),
        height: 45,
        width: 50);
  }
  return Image(
      image: AssetImage('assets/icons/details/Liquid_100%.png'),
      height: 45,
      width: 50);
}

Widget airQualityIconWidget(int val) {
  //print("airQuality val: " + val.toString());
  if (val >= 0 && val <= 2) {
    return Image(
        image: AssetImage('assets/icons/details/Air_Quality_100%.png'),
        height: 45,
        width: 50);
  } else if (val >= 3 && val <= 8) {
    return Image(
        image: AssetImage('assets/icons/details/Air_Quality_50%.png'),
        height: 45,
        width: 50);
  }
  return Image(
      image: AssetImage('assets/icons/details/Air_Quality_0%.png'),
      height: 45,
      width: 50);
}

Widget batteryIconWidget(int val) {
  //print("Battery val: " + val.toString());

  if (val > 0 && val < 10) {
    return Image(
        image: AssetImage("assets/icons/details/Battery_0%.png"),
        height: 45,
        width: 50);
  } else if (val > 10 && val < 35) {
    return Image(
        image: AssetImage("assets/icons/details/Battery_25%.png"),
        height: 45,
        width: 50);
  } else if (val > 45 && val < 65) {
    return Image(
        image: AssetImage("assets/icons/details/Battery_50%.png"),
        height: 45,
        width: 50);
  } else if (val > 65 && val < 85) {
    return Image(
        image: AssetImage("assets/icons/details/Battery_75%.png"),
        height: 45,
        width: 50);
  }

  return Image(
      image: AssetImage("assets/icons/details/Battery_100%.png"),
      height: 45,
      width: 50);
}

Widget tempIconWidget(int val) {
  if (val < 15) {
    return Image(
        image: AssetImage("assets/icons/details/Temp_Low.png"),
        height: 45,
        width: 50);
  }
  if (val > 15 && val < 26) {
    return Image(
        image: AssetImage("assets/icons/details/Temp_Medium.png"),
        height: 45,
        width: 50);
  }
  return Image(
      image: AssetImage("assets/icons/details/Temp_High.png"),
      height: 45,
      width: 50);
}

Widget humIconWidget(int val) {
  if (val < 30) {
    return Image(
        image: AssetImage("assets/icons/details/Humidity_Low.png"),
        height: 45,
        width: 50);
  }
  if (val > 39 && val < 51) {
    return Image(
        image: AssetImage("assets/icons/details/Humidity_Medium.png"),
        height: 45,
        width: 50);
  }
  return Image(
      image: AssetImage("assets/icons/details/Humidity_High.png"),
      height: 45,
      width: 50);
}
