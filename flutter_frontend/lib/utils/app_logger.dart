import 'package:logger/logger.dart';


final Logger appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // No method calls to be displayed for general logs
    errorMethodCount: 8, // Number of method calls if stacktrace is provided for errors
    lineLength: 120, // Width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: true, // Include a timestamp with each log message
  ),
);

