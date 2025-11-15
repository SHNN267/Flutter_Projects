# -----------------------------------------------
# 🔹 PowerShell Script: Create Flutter Project with Clean Architecture
# -----------------------------------------------

# ----------- 1️⃣ طلب اسم المشروع -----------
$name = Read-Host "Enter your Flutter project name"
$projectPath = "$PWD\$name"

# ----------- 2️⃣ إنشاء مشروع Flutter كامل -----------
Write-Host "Creating Flutter project '$name'..."
flutter create $name

# ----------- 3️⃣ الانتقال لمجلد المشروع -----------
Set-Location $projectPath

# ----------- 4️⃣ طلب عدد الميزات (features) -----------
$featuresCount = Read-Host "How many features do you want?"
$features = @()
for ($i = 1; $i -le [int]$featuresCount; $i++) {
    $featureName = Read-Host "Enter name of feature #$i"
    $features += $featureName
}

# ----------- 5️⃣ إنشاء مجلدات core -----------
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

# ----------- 6️⃣ إنشاء مجلدات وملفات لكل feature -----------
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
Write-Host "✅ Flutter project '$name' with Clean Architecture structure created successfully!" -ForegroundColor Green
Write-Host "Project path: $projectPath"
