# -----------------------------------------------
# 🔹 PowerShell Script: Create Flutter Project with Clean Architecture
# -----------------------------------------------

# ----------- 1️⃣ Ask for project name -----------
$name = Read-Host "Enter your Flutter project name"
$projectPath = "$PWD\$name"

# ----------- 2️⃣ Create Flutter project -----------
Write-Host "Creating Flutter project '$name'..."
flutter create $name

# ----------- 3️⃣ Move inside project folder -----------
Set-Location $projectPath

# ----------- 4️⃣ Ask for number of features -----------
$featuresCount = Read-Host "How many features do you want?"
$features = @()
for ($i = 1; $i -le [int]$featuresCount; $i++) {
    $featureName = Read-Host "Enter name of feature #$i"
    $features += $featureName
}

# ----------- 5️⃣ Create core folder structure -----------
$coreFolders = @(
    "lib/core/connection",
    "lib/core/database/api",
    "lib/core/database/cache",
    "lib/core/errors",
    "lib/core/parameters"
)
foreach ($folder in $coreFolders) {
    New-Item -ItemType Directory -Force -Path "$PWD/$folder" | Out-Null
}

# ----------- 6️⃣ Create core dart files -----------
$coreFiles = @(
    "lib/core/connection/network_info.dart",
    "lib/core/database/api/api_consumer.dart",
    "lib/core/database/api/dio_consumer.dart",
    "lib/core/database/api/endpoints.dart",
    "lib/core/database/cache/cache_helper.dart",
    "lib/core/errors/error_model.dart",
    "lib/core/errors/exceptions.dart",
    "lib/core/errors/failure.dart",
    "lib/core/parameters/user_parameters.dart"
)
foreach ($file in $coreFiles) {
    New-Item -ItemType File -Force -Path "$PWD/$file" | Out-Null
}

# ----------- 7️⃣ Insert your predefined Dart code -----------

# --- Network Info ---
Set-Content -Path "lib/core/connection/network_info.dart" -Value @"
import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
"@

# --- Api Consumer ---
Set-Content -Path "lib/core/database/api/api_consumer.dart" -Value @"
abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
}
"@

# --- Cache Helper ---
Set-Content -Path "lib/core/database/cache/cache_helper.dart" -Value @"
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  Future<dynamic> put({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }
}
"@

# --- Error Model ---
Set-Content -Path "lib/core/errors/error_model.dart" -Value @"
class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map jsonData) {
    return ErrorModel(
      errorMessage: jsonData["Message"],
      status: jsonData["status"],
    );
  }
}
"@

# --- Failure ---
Set-Content -Path "lib/core/errors/failure.dart" -Value @"
class Failure {
  final String errMessage;
  Failure({required this.errMessage});
}
"@

# --- Exceptions ---
Set-Content -Path "lib/core/errors/exceptions.dart" -Value @"
import 'package:dio/dio.dart';
import 'package:happytech_clean_architecture/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.badCertificate:
      throw BadCertificateException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw BadResponseException(ErrorModel.fromJson(e.response!.data));
        case 401:
          throw UnauthorizedException(ErrorModel.fromJson(e.response!.data));
        case 403:
          throw ForbiddenException(ErrorModel.fromJson(e.response!.data));
        case 404:
          throw NotFoundException(ErrorModel.fromJson(e.response!.data));
        case 409:
          throw CofficientException(ErrorModel.fromJson(e.response!.data));
        case 504:
          throw BadResponseException(
            ErrorModel(status: 504, errorMessage: e.response!.data),
          );
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );

    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
  }
}
"@

# ----------- 8️⃣ Create folder structure for every feature -----------
foreach ($feature in $features) {
    $featurePath = "lib/features/$feature"
    $featureFolders = @(
        "data/datasources",
        "data/models",
        "data/repositories",
        "domain/entities",
        "domain/repositories",
        "domain/usecases",
        "presentation/bloc",
        "presentation/screens",
        "presentation/widgets"
    )
    foreach ($folder in $featureFolders) {
        New-Item -ItemType Directory -Force -Path "$featurePath/$folder" | Out-Null
    }

    $featureFiles = @(
        "data/datasources/${feature}_local_datasource.dart",
        "data/datasources/${feature}_remote_datasource.dart",
        "data/repositories/${feature}_repository_impl.dart",
        "domain/repositories/${feature}_repository.dart",
        "domain/usecases/get_${feature}_usecase.dart",
        "presentation/bloc/${feature}_cubit.dart",
        "presentation/bloc/${feature}_state.dart",
        "presentation/screens/${feature}_screen.dart",
        "presentation/widgets/${feature}_card.dart"
    )
    foreach ($file in $featureFiles) {
        New-Item -ItemType File -Force -Path "$featurePath/$file" | Out-Null
    }
}

Write-Host ""
Write-Host "✅ Flutter project '$name' created with Clean Architecture successfully!" -ForegroundColor Green
Write-Host "📁 Project path: $projectPath"
