# 🇬🇧 🇫🇷 🇨🇳 BHEM - Black Heritage Experience Manitoba Video Splitter Tool

---

## 🇬🇧 English Intro

A powerful command-line tool for lossless video splitting based on custom timestamps and multilingual rename lists. Perfect for content creators, video editors, and developers who need precise video segmentation with Unicode filename support.

### 🎯 Features

- **Lossless Video Splitting**: Uses FFmpeg's copy mode for zero quality loss
- **Timestamp-Based Cutting**: Precise video segmentation using HH:MM:SS format
- **Multi-Language Interface**: Full support for English, French, and Traditional Chinese
- **Processing Mode**: Uses stream copy for fast, lossless video processing
- **Smart Auto-Detection**: Automatically detects any start point and calculates cut count
- **File Preparation Guidance**: Pre-execution reminder and validation of required files
- **Real-time Progress Display**: Visual progress bars, percentage, and time tracking for each segment
- **Intelligent Comment Support**: Ignores text after "/" in timestamp lines for annotations
- **Flexible Start Point Detection**: Supports any timestamp as start point (not limited to 00:00:00)
- **Enhanced Validation**: Content-based validation instead of line counting
- **Step-by-step Workflow**: Clear indication of current processing step in selected language
- **Multilingual Support**: Full Unicode support for Chinese, Japanese, Korean, and other languages
- **Batch Processing**: Split multiple segments in one operation
- **Smart Validation**: Comprehensive input validation and error handling
- **Multiple Format Support**: Works with MP4, AVI, MKV, MOV, WMV, FLV, WebM, M4V
- **Enhanced Progress Tracking**: Step-by-step workflow with colored output and detailed information
- **Safe File Naming**: Automatic handling of special characters in filenames

### 📋 Prerequisites

- **FFmpeg**: Required for video processing
  ```bash
  # macOS
  brew install ffmpeg
  
  # Ubuntu/Debian
  sudo apt install ffmpeg
  
  # CentOS/RHEL
  sudo yum install ffmpeg
  ```

### 🚀 Quick Start

1. **Clone or download** the tool to your project directory
2. **Prepare your files**:
   - Place your source video as `0.mp4` (or any supported format)
   - Edit `CutTimestamp.txt` with your desired start points (N lines for N segments, back-to-back cutting)
   - Edit `CutRenameList.txt` with output segment names (N lines for N segments)
3. **Run the tool**:
   ```bash
   chmod +x split_video.sh
   ./split_video.sh
   ```
4. **Select your language** when prompted:
   - 1) English
   - 2) Français  
   - 3) 繁體中文
5. **Confirm file preparation** when prompted
6. **Confirm processing mode**: Uses stream copy mode for fast, lossless processing
7. **Enjoy automated processing** with real-time progress display

### 📁 Project Structure

```
BHEM-tool-video-design-Video-Spliter/
├── split_video.sh              # Main executable script
├── CutTimestamp.txt           # Timestamp configuration file
├── CutRenameList.txt          # Rename list configuration file
├── 0.mp4                      # Source video (user provided)
├── Video-Spliter-Output/      # Generated video segments
│   ├── segment1.mp4
│   ├── segment2.mp4
│   └── ...
├── README.md                  # English documentation
├── README_fr.md               # Documentation française
└── README_zh.md               # Documentation chinoise
```

### ⚙️ Configuration Files

#### CutTimestamp.txt
Define your start points in HH:MM:SS format (back-to-back cutting):
```
00:00:00 / E2-1 - BHEM.ca Welcome & Love Notes Introduction - Ralph Bryant
00:03:12 / E2-2 - Black National Anthen - Lift Every Voice and Sing - Celina Clements
00:09:32 / E2-3 - Welcome from ACOMI - Maggie Yeboah
00:12:29 / E2-4 - Greetings from the Province - MLA Jamie Moses
00:16:55 / E2-5 - Golden - Asha Clements
00:22:03 / E2-6 - Welcome from Winnipeg Central Park Women's Resource Centre
```

**Back-to-Back Cutting Features:**
- **Simple Start Points Only**: Each timestamp defines the start of a new segment
- **Automatic End Points**: Each segment ends when the next one begins (last segment goes to video end)
- **Equal File Lines**: Timestamp file and rename file have the same number of lines
- **Comment Support**: Text after "/" is treated as comments and ignored during processing
- **Intelligent Validation**: Validates based on actual timestamp content, not line count

*Note: Cut count = total timestamps (N timestamps = N segments)*
*Note: Text after "/" on each line is treated as comments and will be ignored*
*Note: Timestamp file and rename file must have the same number of lines*

#### CutRenameList.txt
Specify output names for each segment:
```
Opening Segment
Main Content - Part 1
Conclusion Summary
```
*Note: Use UTF-8 encoding for special characters*

### 🛠️ Usage Examples

#### Multi-Language Smart Auto Mode (Recommended)
```bash
./split_video.sh

# Language Selection:
Please select your language / Veuillez sélectionner votre langue / 請選擇您的語言:
1) English
2) Français
3) 繁體中文
Enter your choice (1-3): 1

# File Preparation Reminder:
⚠️  File Preparation Reminder
Please ensure you have prepared the following files:
1. CutTimestamp.txt - Contains timestamps (N+1 lines for N segments)
2. CutRenameList.txt - Contains segment names (N lines for N segments)
3. 0.* - Your source video file
Note: Timestamp file has one extra line (start time) compared to rename file
Have you prepared all the required files? (y/n): y

# Auto Detection:
[Step 2/8] Get cut count
[INFO] Detected start point 00:03:12, automatically set cut count: 13
[INFO] Timestamp distribution:
  Start point: 00:03:12
  Segment 1 end: 00:09:32
  Segment 2 end: 00:12:29
  ...
```

#### French Language Example
```bash
./split_video.sh
# Choose: 2) French
# Processing with standard mode (stream copy)
# Output:
# Video Splitter Tool BHEM
# [Step 2/8] Get cut count
# [INFO] Start point 00:03:12 detected, cut count set automatically: 13
```

#### Traditional Chinese Example
```bash
./split_video.sh
# Choose: 3) Traditional Chinese
# Processing with standard mode (stream copy)
# Output:
# BHEM Video Splitter Tool
# [Step 2/8] Get cut count
# [INFO] Start point 00:03:12 detected, cut count set automatically: 13
```

#### Environment Variable Mode
```bash
CUT_COUNT=3 ./split_video.sh
```

### 🎨 Technical Features

#### **Multi-Language Interface System**
- **Three-language support**: English, French, Traditional Chinese
- **Interactive language selection**: Choose language at startup
- **Localized user experience**: All messages, prompts, and progress indicators in selected language
- **Cultural adaptation**: Appropriate formatting and conventions for each language

#### **Smart Auto-Detection System**
- **Flexible start point recognition**: Any timestamp can be the start point (not limited to `00:00:00`)
- **Intelligent cut count calculation**: Based on timestamp content, not line counting
- **Comment parsing**: Ignores text after "/" in timestamp lines
- **Content-based validation**: Smart validation instead of rigid line counting

#### **File Preparation Guidance**
- **Pre-execution validation**: Confirms all required files are prepared
- **Clear file relationship**: Explains timestamp file has one extra line
- **User-friendly prompts**: Guides users through preparation process
- **Error prevention**: Catches missing files before processing begins

#### ** Processing Mode**
- **Standard Mode (Stream Copy)**: Fast processing using direct stream copying for lossless video splitting
- **Automatic Parameter Optimization**: Optimized FFmpeg parameters for reliable processing

#### **Enhanced Progress Display**
- **Step-by-step workflow**: Shows current step (e.g., "[步骤 3/8] 验证时间戳文件")
- **Visual progress bars**: Real-time progress with `█░` characters
- **Percentage tracking**: Shows completion percentage for each segment
- **Time tracking**: Displays processing time for each segment and total duration
- **Live statistics**: Shows completed, failed, and remaining segments

#### **Smart Validation System**
- Timestamp format validation (HH:MM:SS)
- Sequential timestamp verification
- File encoding detection (UTF-8 recommended)
- Input/output file existence checks
- Intelligent timestamp count validation

#### **Error Handling**
- Comprehensive error messages with colored output
- Graceful handling of edge cases
- Progress tracking with success/failure counts
- Automatic cleanup of failed operations
- Smart recommendations for cut count adjustments

#### **Video Processing**
- Uses FFmpeg's `-c copy` for lossless processing
- Supports multiple input formats
- Automatic output directory management
- Safe filename sanitization

### 🌈 Output Features

- **Enhanced Colored Console Output**: 
  - 🔵 Blue for information and progress updates
  - 🟢 Green for success and completion status
  - 🟡 Yellow for warnings and step indicators
  - 🔴 Red for errors and failures

- **Real-time Progress Display**:
  ```
  [Progress] [██████░░░░░░░░░░░░░░] 30% - Processing segment 4/12
  [INFO] Splitting: 00:16:55 → 00:22:03
  [INFO] Output: Video-Spliter-Output/E2-4 - Greetings from the Province.mp4
  [INFO] Processing...
  ✓ Segment 4 completed (Time: 3s)
  [Stats] Completed: 4, Failed: 0, Remaining: 8
  ```

- **Intelligent Summary Report**: 
  - Processing time for each segment
  - Total processing duration
  - Success/failure statistics
  - Detailed results with file sizes and locations

### ⚠️ Important Notes

1. **File Relationship**: Timestamp file and rename file must have **same number of lines** (back-to-back cutting)
2. **File Encoding**: Ensure `CutTimestamp.txt` and `CutRenameList.txt` are saved in UTF-8 encoding
3. **Timestamp Order**: Timestamps must be in chronological order
4. **Flexible Start Point**: First timestamp can be any time (e.g., 00:03:12, 01:15:30, etc.)
5. **Minimum Duration**: Segments shorter than 2 seconds may cause issues
6. **File Naming**: Special characters in filenames are automatically sanitized
7. **Dependencies**: FFmpeg must be installed and accessible in PATH
8. **Language Selection**: Choose your preferred language at startup for the best user experience

### 🔧 Troubleshooting

#### Common Issues

**FFmpeg not found**
```bash
# Install FFmpeg first
brew install ffmpeg  # macOS
sudo apt install ffmpeg  # Ubuntu
```

**Encoding issues**
- Save configuration files as UTF-8 without BOM
- Use a text editor that supports Unicode

**Permission denied**
```bash
chmod +x split_video.sh
```

**Invalid timestamps**
- Ensure format is exactly HH:MM:SS
- Check that timestamps are in ascending order


### 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### 📞 Support

For issues and feature requests, please open an issue on the project repository.

---

## 🇫🇷 Intro Français

Un outil puissant en ligne de commande pour la division vidéo sans perte basée sur des horodatages personnalisés et des listes de renommage multilingues. Parfait pour les créateurs de contenu, les éditeurs vidéo et les développeurs qui ont besoin d'une segmentation vidéo précise avec support des noms de fichiers Unicode.

### 🎯 Fonctionnalités

- **Division Vidéo Sans Perte**: Utilise le mode copie de FFmpeg pour une qualité zéro perte
- **Découpe Basée sur l'Horodatage**: Segmentation vidéo précise utilisant le format HH:MM:SS
- **Interface Multilingue**: Support complet pour l'anglais, le français et le chinois traditionnel
- **Détection Automatique Intelligente**: Détecte automatiquement tout point de départ et calcule le nombre de découpes
- **Guidance de Préparation des Fichiers**: Rappel et validation pré-exécution des fichiers requis
- **Affichage de Progression en Temps Réel**: Barres de progression visuelles, pourcentages et suivi temporel pour chaque segment
- **Support Intelligent des Commentaires**: Ignore le texte après "/" dans les lignes d'horodatage pour les annotations
- **Support Multilingue**: Support Unicode complet pour le chinois, japonais, coréen et autres langues
- **Traitement par Lot**: Division de plusieurs segments en une seule opération
- **Validation Intelligente**: Validation d'entrée complète et gestion d'erreurs
- **Support de Multiples Formats**: Fonctionne avec MP4, AVI, MKV, MOV, WMV, FLV, WebM, M4V
- **Suivi de Progression Amélioré**: Flux de travail étape par étape avec sortie colorée et informations détaillées
- **Nommage de Fichier Sécurisé**: Gestion automatique des caractères spéciaux dans les noms de fichiers

### 📋 Prérequis

- **FFmpeg**: Requis pour le traitement vidéo
  ```bash
  # macOS
  brew install ffmpeg
  
  # Ubuntu/Debian
  sudo apt install ffmpeg
  
  # CentOS/RHEL
  sudo yum install ffmpeg
  ```

### 🚀 Démarrage Rapide

1. **Clonez ou téléchargez** l'outil dans votre répertoire de projet
2. **Préparez vos fichiers**:
   - Placez votre vidéo source comme `0.mp4` (ou tout format supporté)
   - Éditez `CutTimestamp.txt` avec vos points de départ désirés (N lignes pour N segments, découpe dos à dos)
   - Éditez `CutRenameList.txt` avec les noms des segments de sortie (N lignes pour N segments)
3. **Exécutez l'outil**:
   ```bash
   chmod +x split_video.sh
   ./split_video.sh
   ```
4. **Sélectionnez votre langue** quand demandé:
   - 1) English
   - 2) Français  
   - 3) 繁體中文
5. **Confirmez la préparation des fichiers** quand demandé
6. **Traitement en mode **: Utilise la copie de flux pour un traitement rapide et sans perte
7. **Profitez du traitement automatisé** avec affichage de progression en temps réel

### 📁 Structure du Projet

```
BHEM-tool-video-design-Video-Spliter/
├── split_video.sh              # Script exécutable principal
├── CutTimestamp.txt           # Fichier de configuration d'horodatage
├── CutRenameList.txt          # Fichier de configuration de liste de renommage
├── 0.mp4                      # Vidéo source (fournie par l'utilisateur)
├── Video-Spliter-Output/      # Segments vidéo générés
│   ├── segment1.mp4
│   ├── segment2.mp4
│   └── ...
└── README.md                  # Documentation française
```

### ⚙️ Fichiers de Configuration

#### CutTimestamp.txt
Définissez vos points de départ au format HH:MM:SS (découpe dos à dos):
```
00:00:00 / E2-1 - BHEM.ca Welcome & Love Notes Introduction - Ralph Bryant
00:03:12 / E2-2 - Black National Anthen - Lift Every Voice and Sing - Celina Clements
00:09:32 / E2-3 - Welcome from ACOMI - Maggie Yeboah
00:12:29 / E2-4 - Greetings from the Province - MLA Jamie Moses
00:16:55 / E2-5 - Golden - Asha Clements
00:22:03 / E2-6 - Welcome from Winnipeg Central Park Women's Resource Centre
```

**Fonctionnalités de Détection Automatique Intelligente:**
- **Comptage Automatique des Découpes**: Quand la première ligne est `00:00:00`, l'outil calcule automatiquement le nombre de découpes
- **Support des Commentaires**: Le texte après "/" est traité comme commentaire et ignoré pendant le traitement
- **Validation Intelligente**: Valide basé sur le contenu réel des horodatages, pas le nombre de lignes

*Note: Si le premier horodatage est `00:00:00`, nombre de découpes = total horodatages - 1*
*Note: Le texte après "/" sur chaque ligne est traité comme commentaire et sera ignoré*

#### CutRenameList.txt
Spécifiez les noms de sortie pour chaque segment:
```
Segment d'Ouverture
Contenu Principal - Partie 1
Résumé de Conclusion
```
*Note: Utilisez l'encodage UTF-8 pour les caractères spéciaux*

### 🛠️ Exemples d'Utilisation

#### Mode Auto Intelligent (Recommandé)
```bash
./split_video.sh
# Quand CutTimestamp.txt commence par 00:00:00, le nombre de coupes est automatiquement détecté
# Exemple de sortie :
# [INFO] Détection du point de départ 00:00:00, définition automatique du nombre de découpes : 13
# [INFO] Distribution des horodatages :
#   Point de départ : 00:00:00
#   Fin du segment 1 : 00:03:12
#   Fin du segment 2 : 00:09:32
#   ...
```

#### Mode Interactif
```bash
./split_video.sh
# Le script demandera le nombre de coupes si la détection automatique n'est pas disponible
```

#### Mode Variable d'Environnement
```bash
CUT_COUNT=3 ./split_video.sh
```

### 🎨 Fonctionnalités Techniques

#### **Système de Détection Automatique Intelligente**
- Reconnaissance automatique de `00:00:00` comme point de départ
- Calcul intelligent du nombre de découpes basé sur le contenu des horodatages
- Analyse des commentaires (ignore le texte après "/" dans les lignes d'horodatage)
- Validation basée sur le contenu au lieu du comptage rigide des lignes

#### **Affichage de Progression Amélioré**
- **Flux de travail étape par étape** : Affiche l'étape actuelle (ex: "[Étape 3/8] Validation du fichier d'horodatage")
- **Barres de progression visuelles** : Progression en temps réel avec caractères `█░`
- **Suivi de pourcentage** : Affiche le pourcentage d'achèvement pour chaque segment
- **Suivi temporel** : Affiche le temps de traitement pour chaque segment et la durée totale
- **Statistiques en direct** : Affiche les segments terminés, échoués et restants

#### **Système de Validation Intelligent**
- Validation du format d'horodatage (HH:MM:SS)
- Vérification séquentielle des horodatages
- Détection d'encodage de fichier (UTF-8 recommandé)
- Vérifications d'existence des fichiers d'entrée/sortie
- Validation intelligente du nombre d'horodatages

#### **Gestion d'Erreurs**
- Messages d'erreur complets avec sortie colorée
- Gestion élégante des cas limites
- Suivi de progression avec compteurs de succès/échec
- Nettoyage automatique des opérations échouées
- Recommandations intelligentes pour l'ajustement du nombre de découpes

#### **Traitement Vidéo**
- Utilise `-c copy` de FFmpeg pour un traitement sans perte
- Support de multiples formats d'entrée
- Gestion automatique du répertoire de sortie
- Assainissement sécurisé des noms de fichiers

### 🌈 Fonctionnalités de Sortie

- **Sortie Console Colorée**: 
  - 🔵 Bleu pour l'information
  - 🟢 Vert pour le succès
  - 🟡 Jaune pour les avertissements
  - 🔴 Rouge pour les erreurs

- **Affichage de Progression en Temps Réel**:
  ```
  [Progrès] [██████░░░░░░░░░░░░░░] 30% - Traitement segment 4/12
  [INFO] Division: 00:16:55 → 00:22:03
  [INFO] Sortie: Video-Spliter-Output/E2-4 - Greetings from the Province.mp4
  [INFO] Traitement en cours...
  ✓ Segment 4 terminé (Durée: 3s)
  [Stats] Terminés: 4, Échecs: 0, Restants: 8
  ```

- **Rapport de Résumé**: Résultats détaillés avec tailles et emplacements de fichiers

### ⚠️ Notes Importantes

1. **Encodage de Fichier**: Assurez-vous que `CutTimestamp.txt` et `CutRenameList.txt` sont sauvegardés en encodage UTF-8
2. **Ordre des Horodatages**: Les horodatages doivent être en ordre chronologique
3. **Durée Minimale**: Les segments de moins de 2 secondes peuvent causer des problèmes
4. **Nommage de Fichier**: Les caractères spéciaux dans les noms de fichiers sont automatiquement assainis
5. **Dépendances**: FFmpeg doit être installé et accessible dans le PATH

### 🔧 Dépannage

#### Problèmes Courants

**FFmpeg non trouvé**
```bash
# Installez FFmpeg d'abord
brew install ffmpeg  # macOS
sudo apt install ffmpeg  # Ubuntu
```

**Problèmes d'encodage**
- Sauvegardez les fichiers de configuration en UTF-8 sans BOM
- Utilisez un éditeur de texte qui supporte Unicode

**Permission refusée**
```bash
chmod +x split_video.sh
```


---

## 🇨🇳 中文 Intro

一個強大的命令列工具，基於自定義時間戳和多語言重命名列表進行無損視頻分割。非常適合內容創作者、視頻編輯師和需要精確視頻分段且支持 Unicode 檔案名的開發人員。

### 🎯 功能特色

- **無損視頻分割**: 使用 FFmpeg 的複製模式實現零品質損失
- **基於時間戳的切割**: 使用 HH:MM:SS 格式進行精確視頻分段
- **多語言介面**: 完全支持英文、法文和繁體中文
- **智能自動識別**: 自動識別任意起始點並計算分割數量
- **檔案準備指導**: 執行前提醒和驗證所需檔案
- **實時進度顯示**: 可視化進度條、百分比和每個片段的時間追蹤
- **智能備註支持**: 忽略時間戳行中"/"後的文本作為註釋
- **多語言支援**: 完全支援中文、日語、韓語等 Unicode 字元
- **批量處理**: 一次操作分割多個片段
- **智能驗證**: 全面的輸入驗證和錯誤處理
- **多格式支援**: 支援 MP4、AVI、MKV、MOV、WMV、FLV、WebM、M4V
- **增強的進度追蹤**: 逐步工作流程，帶有彩色輸出和詳細信息
- **安全檔案命名**: 自動處理檔案名中的特殊字符

### 📋 系統要求

- **FFmpeg**: 視頻處理必需
  ```bash
  # 蘋果系統
  brew install ffmpeg
  
  # 烏班圖/德煩
  sudo apt install ffmpeg
  
  # 紅帽系統
  sudo yum install ffmpeg
  ```

### 🚀 快速開始

1. **克隆或下載** 工具到您的項目目錄
2. **準備檔案**:
   - 將源視頻檔案命名為 `0.mp4`（或任何支持的格式）
   - 編輯 `CutTimestamp.txt` 設置您想要的開始點（N 個片段需要 N 行，背對背切割）
   - 編輯 `CutRenameList.txt` 設置輸出片段名稱（N 個片段需要 N 行）
3. **執行工具**:
   ```bash
   chmod +x split_video.sh
   ./split_video.sh
   ```
4. **選擇您的語言** 當提示時:
   - 1) English
   - 2) Français  
   - 3) 繁體中文
5. **確認檔案準備** 當提示時
6. **標準模式處理**: 使用流複製進行快速無損處理
7. **享受自動化處理** 和實時進度顯示

### 📁 專案結構

```
BHEM-tool-video-design-Video-Spliter/
├── split_video.sh              # 主執行腦本
├── CutTimestamp.txt           # 時間戳配置檔案
├── CutRenameList.txt          # 重命名列表配置檔案
├── 0.mp4                      # 源視頻檔案（用戶提供）
├── Video-Spliter-Output/      # 生成的視頻片段
│   ├── 開場片段.mp4
│   ├── 第二部分-講述.mp4
│   └── ...
└── README.md                  # 專案文檔
```

### ⚙️ 配置檔案

#### CutTimestamp.txt
以 HH:MM:SS 格式定義開始點（背對背切割）：
```
00:00:00 / E2-1 - BHEM.ca Welcome & Love Notes Introduction - Ralph Bryant
00:03:12 / E2-2 - Black National Anthen - Lift Every Voice and Sing - Celina Clements
00:09:32 / E2-3 - Welcome from ACOMI - Maggie Yeboah
00:12:29 / E2-4 - Greetings from the Province - MLA Jamie Moses
00:16:55 / E2-5 - Golden - Asha Clements
00:22:03 / E2-6 - Welcome from Winnipeg Central Park Women's Resource Centre
```

**智能自動識別功能：**
- **靈活起始點**: 第一行可以是任意時間戳（不限於 `00:00:00`）
- **自動分割計數**: 工具自動計算分割數量 = 總時間戳數 - 1
- **備註支持**: "/"後的文本被視為註釋，在處理過程中被忽略
- **智能驗證**: 基於實際時間戳內容進行驗證，而非依賴行數

*注意：分割數量 = 總時間戳數 - 1（第一行總是起始點）*
*注意：每行中"/"後面的文本會被視為註釋並忽略*
*注意：時間戳檔案必須比重命名檔案多一行*

#### CutRenameList.txt
為每個片段指定輸出名稱：
```
開場片段
第二部分-講述
第三部分-結尾總結
```
*注意：請使用 UTF-8 編碼保存特殊字元*

### 🛠️ 使用示例

#### 智能自動模式（推薦）
```bash
./split_video.sh
# 當 CutTimestamp.txt 以 00:00:00 開始時，分割數量會自動識別
# 輸出示例：
# [INFO] 檢測到起始點 00:00:00，自動設置分割數量: 13
# [INFO] 時間戳分布:
#   起始點: 00:00:00
#   片段 1 結束: 00:03:12
#   片段 2 結束: 00:09:32
#   ...
```

#### 交互模式
```bash
./split_video.sh
# 如果自動識別不可用，腳本會提示輸入切割數量
```

#### 環境變數模式
```bash
CUT_COUNT=3 ./split_video.sh
```

### 🎨 技術特性

#### **智能自動識別系統**
- 自動識別 `00:00:00` 為起始點
- 基於時間戳內容的智能分割數量計算
- 注釋解析（忽略時間戳行中"/"後的文本）
- 基於內容的驗證而非嚴格的行數計數

#### **增強的進度顯示**
- **逐步工作流程**：顯示當前步驟（如："【步驟 3/8】 驗證時間戳文件"）
- **可視化進度條**：使用 `█░` 字符實時顯示進度
- **百分比跟蹤**：顯示每個片段的完成百分比
- **時間跟蹤**：顯示每個片段的處理時間和總時長
- **實時統計**：顯示已完成、失敗和剩餘的片段

#### **智能驗證系統**
- 時間戳格式驗證（HH:MM:SS）
- 時間戳順序驗證
- 文件編碼檢測（推薦 UTF-8）
- 輸入/輸出文件存在性檢查
- 智能時間戳數量驗證

#### **錯誤處理**
- 帶彩色輸出的全面錯誤消息
- 優雅處理邊緣情況
- 帶成功/失敗計數的進度跟蹤
- 失敗操作的自動清理
- 分割數量調整的智能建議

#### **視頻處理**
- 使用 FFmpeg 的 `-c copy` 進行無損處理
- 支持多種輸入格式
- 自動輸出目錄管理
- 安全的文件名清理

### 🌈 輸出特性

- **彩色控制台輸出**: 
  - 🔵 藍色表示信息
  - 🟢 綠色表示成功
  - 🟡 黃色表示警告
  - 🔴 紅色表示錯誤

- **實時進度顯示**:
  ```
  [進度] [██████░░░░░░░░░░░░░░] 30% - 處理片段 4/12
  [INFO] 分割: 00:16:55 → 00:22:03
  [INFO] 輸出: Video-Spliter-Output/E2-4 - Greetings from the Province.mp4
  [INFO] 正在處理...
  ✓ 片段 4 分割完成 (耗時: 3s)
  [統計] 已完成: 4, 失敗: 0, 剩餘: 8
  ```

- **摘要報告**: 包含文件大小和位置的詳細結果

### ⚠️ 重要說明

1. **文件編碼**: 確保 `CutTimestamp.txt` 和 `CutRenameList.txt` 以 UTF-8 編碼保存
2. **時間戳順序**: 時間戳必須按時間順序排列
3. **最小時長**: 短於 2 秒的片段可能會出現問題
4. **文件命名**: 文件名中的特殊字符會自動清理
5. **依賴項**: FFmpeg 必須已安裝並在 PATH 中可訪問

### 🔧 故障排除

#### 常見問題

**找不到 FFmpeg**
```bash
# 首先安裝 FFmpeg
brew install ffmpeg  # macOS
sudo apt install ffmpeg  # Ubuntu
```

**編碼問題**
- 將配置文件保存為不帶 BOM 的 UTF-8 格式
- 使用支持 Unicode 的文本編輯器

**權限被拒絕**
```bash
chmod +x split_video.sh
```


---

### 📄 許可證

本項目採用 MIT 許可證。

### 🤝 貢獻

歡迎貢獻！請隨時提交 Pull Request。

### 📞 支持

如有問題和功能請求，請在項目倉庫中開啟 issue。