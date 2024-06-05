import 'dart:io';

typedef DynamicFunction = dynamic Function(List<dynamic>);

Map<String, DynamicFunction> functionMap = {
  "readFile": (arguments) {
    if (arguments.length != 1) {
      throw Exception("Function readFile takes exactly one argument");
    }
    String filePath = arguments[0].toString();
    return File(filePath).readAsStringSync();
  },
  "writeFile": (arguments) {
    if (arguments.length != 2) {
      throw Exception("Function writeFile takes exactly two arguments");
    }
    String filePath = arguments[0].toString();
    String content = arguments[1].toString().replaceAll(r"\n", "\n");
    File(filePath).writeAsStringSync(content);
    return null;
  },
  "appendFile": (arguments) {
    if (arguments.length != 2) {
      throw Exception("Function appendFile takes exactly two arguments");
    }
    String filePath = arguments[0].toString();
    String content = arguments[1].toString().replaceAll(r"\n", "\n");
    File(filePath).writeAsStringSync(content, mode: FileMode.append);
    return null;
  },
  "input": (arguments) {
    if (arguments.length == 1) {
      print(arguments[0]);
    } else if (arguments.length > 1) {
      throw Exception("Function input may have at most 1 argument");
    }
    return stdin.readLineSync();
  },
  "length": (arguments) {
    if (arguments.length != 1) {
      throw Exception("Function length takes exactly one argument");
    }
    return arguments[0].runtimeType == List
        ? arguments[0].length
        : arguments[0].toString().length;
  },
  "pos": (arguments) {
    if (arguments.length != 2) {
      throw Exception("Function pos takes exactly two argument");
    }
    return arguments[0][arguments[1]];
  },
  "substr": (arguments) {
    if (arguments.length != 3) {
      throw Exception("Function substr takes exactly three argument");
    }
    return arguments[0].toString().substring(arguments[1], arguments[2]);
  },
  "typeof": (arguments) {
    if (arguments.length != 1) {
      throw Exception("Function typeof takes exactly one argument");
    }
    return arguments[0].runtimeType;
  },
  "parseInt": (arguments) {
    if (arguments.length != 1) {
      throw Exception("Function parseInt takes exactly one argument");
    }
    return double.parse(arguments[0].toString()).toInt();
  },
  "parseFloat": (arguments) {
    if (arguments.length != 1) {
      throw Exception("Function parseFloat takes exactly one argument");
    }
    return double.parse(arguments[0].toString());
  }
};

dynamic callFunction(String functionName, List<dynamic> arguments) {
  if (!functionMap.containsKey(functionName)) {
    throw Exception("Function $functionName not defined");
  }
  return functionMap[functionName]!(arguments);
}
