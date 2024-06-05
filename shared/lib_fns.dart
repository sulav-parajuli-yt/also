import 'dart:io';

typedef DynamicFunction = dynamic Function(List<dynamic>);


Map<String, DynamicFunction> functionMap = {
  "input": (arguments) {
    if (arguments.isNotEmpty) {
      throw Exception("Function input does not take arguments");
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
