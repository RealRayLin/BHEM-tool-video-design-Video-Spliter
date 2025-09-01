#!/bin/bash

# BHEM Video Splitter Tool
# Multi-language video splitting tool based on timestamps and rename lists
# Video splitting tool based on timestamps and rename lists

set -e

# Check bash version and set compatibility mode
if [[ ${BASH_VERSION%%.*} -ge 4 ]]; then
    declare -A TEXTS
    USE_ASSOCIATIVE_ARRAY=true
else
    USE_ASSOCIATIVE_ARRAY=false
fi

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Language settings
LANGUAGE=""


# Global success/failure counters
GLOBAL_SUCCESS_COUNT=0
GLOBAL_FAILED_COUNT=0

# Initialize multi-language texts
init_language_texts() {
    if [[ "$USE_ASSOCIATIVE_ARRAY" == "true" ]]; then
        # Use associative arrays (bash 4.0+)
        # English texts
        TEXTS["en_welcome"]="🎬 BHEM Video Splitter Tool"
        TEXTS["en_separator"]="========================================"
        TEXTS["en_select_language"]="Please select your language / Veuillez sélectionner votre langue / 請選擇您的語言:"
        TEXTS["en_language_option"]="1) English"
        TEXTS["en_language_invalid"]="Invalid selection. Please enter 1, 2, or 3."
        TEXTS["en_dependency_check"]="Checking dependencies..."
        TEXTS["en_ffmpeg_installed"]="FFmpeg is installed"
        TEXTS["en_ffmpeg_not_found"]="FFmpeg not found. Please install FFmpeg first:"
        TEXTS["en_auto_detected"]="Detected start point %s, automatically set cut count: %d"
        TEXTS["en_timestamp_distribution"]="Timestamp distribution:"
        TEXTS["en_start_point"]="Start point: %s"
        TEXTS["en_segment_end"]="Segment %d end: %s"
        TEXTS["en_enter_cut_count"]="Please enter cut count: "
        TEXTS["en_final_cut_count"]="Final cut count: %d"
        TEXTS["en_file_prep_reminder"]="⚠️  File Preparation Reminder"
        TEXTS["en_prep_instruction1"]="Please ensure you have prepared the following files:"
        TEXTS["en_prep_instruction2"]="1. CutTimestamp.txt - Contains start timestamps (N lines for N segments, back-to-back cutting)"
        TEXTS["en_prep_instruction3"]="2. CutRenameList.txt - Contains segment names (N lines for N segments)"
        TEXTS["en_prep_instruction4"]="3. 0.* - Your source video file"
        TEXTS["en_prep_note"]="Note: Back-to-back cutting - timestamp file and rename file have same number of lines"
        TEXTS["en_files_ready"]="Have you prepared all the required files? (y/n): "
        TEXTS["en_please_prepare"]="Please prepare the files first and run the script again."
        TEXTS["en_step"]="Step"
        TEXTS["en_check_dependency"]="Check dependencies"
        TEXTS["en_get_cut_count"]="Get cut count"
        TEXTS["en_validate_timestamp"]="Validate timestamp file"
        TEXTS["en_validate_rename"]="Validate rename file"
        TEXTS["en_find_input"]="Find input video"
        TEXTS["en_create_output"]="Create output directory"
        TEXTS["en_split_video"]="Split video"
        TEXTS["en_generate_summary"]="Generate summary"
        TEXTS["en_all_completed"]="🎉 All operations completed!"
        TEXTS["en_all_failed"]="❌ All segments failed to process. Please check the input file and try again."
        TEXTS["en_partial_success"]="⚠️ Process completed with %d successes and %d failures."
        TEXTS["en_segment_range"]="Segment %d: %s → %s"
        TEXTS["en_segment_to_end"]="Segment %d: %s → end of video"
        TEXTS["en_timestamp_validation_pass"]="Timestamp validation passed: %d time points, can cut %d segments, current cutting %d"
        TEXTS["en_timestamp_file_validated"]="Timestamp file validated"
        TEXTS["en_rename_count_error"]="Rename count error. Back-to-back cutting mode requires rename file lines equal to timestamp count. Expected %d lines, actual %d lines"
        TEXTS["en_cut_count_invalid"]="Cut count must be a positive integer"
        TEXTS["en_timestamp_file_missing"]="Timestamp file %s does not exist"
        TEXTS["en_timestamp_insufficient"]="Insufficient timestamps. Need at least 1 timestamp to cut 1 segment, but only found %d"
        TEXTS["en_cut_count_excessive"]="Too many cuts requested. File has %d timestamps, can cut at most %d segments, but you requested %d"
        TEXTS["en_invalid_time_format"]="Line %d time format error: %s (should be HH:MM:SS format)"
        TEXTS["en_timestamp_order_error"]="Timestamp order error. Line %d (%s) is earlier than previous line"
        TEXTS["en_rename_file_missing"]="Rename file %s does not exist"
        TEXTS["en_empty_rename_line"]="Line %d rename is empty"
        TEXTS["en_input_video_not_found"]="Input video file not found. Please rename your video file to 0.* and place it in current directory"
        TEXTS["en_supported_formats"]="Supported formats: %s"
        TEXTS["en_segment_split_failed"]="✗ Segment %d split failed"
        TEXTS["en_encoding_warning_timestamp"]="Timestamp file may not be UTF-8 encoded, recommend converting to UTF-8"
        TEXTS["en_encoding_warning_rename"]="Rename file may not be UTF-8 encoded, recommend converting to UTF-8"
        TEXTS["en_rename_validation_pass"]="Rename file validation passed"
        TEXTS["en_detected_timestamps"]="Detected %d timestamps, suggested cut count: %d"
        TEXTS["en_output_dir_exists"]="Output directory already exists, will clear existing content"
        TEXTS["en_output_dir_ready"]="Output directory ready: %s"
        TEXTS["en_start_splitting"]="Starting video splitting..."
        TEXTS["en_total_segments"]="Total segments to split: %d"
        TEXTS["en_segment_duration_zero"]="Segment %d duration is 0 or negative, skipping"
        TEXTS["en_segment_duration_short"]="Segment %d duration less than 2 seconds, may cause issues"
        TEXTS["en_split_to_end"]="Split: %s → end of video"
        TEXTS["en_processing"]="Processing..."
        TEXTS["en_segment_completed"]="✓ Segment %d split completed (time: %ds)"
        TEXTS["en_progress_stats"]="[Stats] Completed: %d, Failed: %d, Remaining: %d"
        TEXTS["en_final_progress"]="[Complete] All segments processed"
        TEXTS["en_split_summary"]="Split completed! Success: %d/%d, Failed: %d, Total time: %ds"
        TEXTS["en_result_summary"]="=== Split Results Summary ==="
        TEXTS["en_input_file"]="Input file: %s"
        TEXTS["en_cut_count"]="Cut count: %d"
        TEXTS["en_output_directory"]="Output directory: %s"
        TEXTS["en_generated_files"]="Generated files:"
        TEXTS["en_no_output_files"]="No files generated in output directory"
        TEXTS["en_progress_bar"]="[Progress]"
        TEXTS["en_processing_segment"]="Processing segment %d/%d"
        TEXTS["en_split_info"]="Split: %s → %s"
        TEXTS["en_output_info"]="Output: %s"
        TEXTS["en_input_video_found"]="Found input video"
        
        # French texts
        TEXTS["fr_welcome"]="🎬 Outil de Division Vidéo BHEM"
        TEXTS["fr_separator"]="========================================"
        TEXTS["fr_language_option"]="2) Français"
        TEXTS["fr_dependency_check"]="Vérification des dépendances..."
        TEXTS["fr_ffmpeg_installed"]="FFmpeg est installé"
        TEXTS["fr_ffmpeg_not_found"]="FFmpeg non trouvé. Veuillez installer FFmpeg d'abord:"
        TEXTS["fr_auto_detected"]="Point de départ %s détecté, nombre de découpes défini automatiquement: %d"
        TEXTS["fr_timestamp_distribution"]="Distribution des horodatages:"
        TEXTS["fr_start_point"]="Point de départ: %s"
        TEXTS["fr_segment_end"]="Fin du segment %d: %s"
        TEXTS["fr_enter_cut_count"]="Veuillez entrer le nombre de découpes: "
        TEXTS["fr_final_cut_count"]="Nombre final de découpes: %d"
        TEXTS["fr_file_prep_reminder"]="⚠️  Rappel de Préparation des Fichiers"
        TEXTS["fr_prep_instruction1"]="Veuillez vous assurer d'avoir préparé les fichiers suivants:"
        TEXTS["fr_prep_instruction2"]="1. CutTimestamp.txt - Contient les horodatages de début (N lignes pour N segments, découpe dos à dos)"
        TEXTS["fr_prep_instruction3"]="2. CutRenameList.txt - Contient les noms de segments (N lignes pour N segments)"
        TEXTS["fr_prep_instruction4"]="3. 0.* - Votre fichier vidéo source"
        TEXTS["fr_prep_note"]="Note: Découpe dos à dos - le fichier d'horodatage et le fichier de renommage ont le même nombre de lignes"
        TEXTS["fr_files_ready"]="Avez-vous préparé tous les fichiers requis? (o/n): "
        TEXTS["fr_please_prepare"]="Veuillez préparer les fichiers d'abord et relancer le script."
        TEXTS["fr_step"]="Étape"
        TEXTS["fr_check_dependency"]="Vérifier les dépendances"
        TEXTS["fr_get_cut_count"]="Obtenir le nombre de découpes"
        TEXTS["fr_validate_timestamp"]="Valider le fichier d'horodatage"
        TEXTS["fr_validate_rename"]="Valider le fichier de renommage"
        TEXTS["fr_find_input"]="Trouver la vidéo d'entrée"
        TEXTS["fr_create_output"]="Créer le répertoire de sortie"
        TEXTS["fr_split_video"]="Diviser la vidéo"
        TEXTS["fr_generate_summary"]="Générer le résumé"
        TEXTS["fr_all_completed"]="🎉 Toutes les opérations terminées!"
        TEXTS["fr_all_failed"]="❌ Tous les segments ont échoué. Veuillez vérifier le fichier d'entrée et réessayer."
        TEXTS["fr_partial_success"]="⚠️ Processus terminé avec %d succès et %d échecs."
        TEXTS["fr_segment_range"]="Segment %d: %s → %s"
        TEXTS["fr_segment_to_end"]="Segment %d: %s → fin de la vidéo"
        TEXTS["fr_timestamp_validation_pass"]="Validation des horodatages réussie: %d points temporels, peut découper %d segments, découpe actuelle %d"
        TEXTS["fr_timestamp_file_validated"]="Fichier d'horodatage validé"
        TEXTS["fr_rename_count_error"]="Erreur de comptage de renommage. Le mode découpe dos à dos nécessite que les lignes du fichier de renommage égalent le nombre d'horodatages. Attendu %d lignes, actuel %d lignes"
        TEXTS["fr_cut_count_invalid"]="Le nombre de découpes doit être un entier positif"
        TEXTS["fr_timestamp_file_missing"]="Le fichier d'horodatage %s n'existe pas"
        TEXTS["fr_timestamp_insufficient"]="Horodatages insuffisants. Il faut au moins 1 horodatage pour découper 1 segment, mais seulement %d trouvé"
        TEXTS["fr_cut_count_excessive"]="Trop de découpes demandées. Le fichier a %d horodatages, peut découper au maximum %d segments, mais vous en demandez %d"
        TEXTS["fr_invalid_time_format"]="Erreur de format temporel ligne %d: %s (devrait être au format HH:MM:SS)"
        TEXTS["fr_timestamp_order_error"]="Erreur d'ordre des horodatages. La ligne %d (%s) est antérieure à la ligne précédente"
        TEXTS["fr_rename_file_missing"]="Le fichier de renommage %s n'existe pas"
        TEXTS["fr_empty_rename_line"]="La ligne %d de renommage est vide"
        TEXTS["fr_input_video_not_found"]="Fichier vidéo d'entrée introuvable. Veuillez renommer votre fichier vidéo en 0.* et le placer dans le répertoire courant"
        TEXTS["fr_supported_formats"]="Formats supportés: %s"
        TEXTS["fr_segment_split_failed"]="✗ Échec de la division du segment %d"
        TEXTS["fr_encoding_warning_timestamp"]="Le fichier d'horodatage pourrait ne pas être encodé en UTF-8, recommandé de convertir en UTF-8"
        TEXTS["fr_encoding_warning_rename"]="Le fichier de renommage pourrait ne pas être encodé en UTF-8, recommandé de convertir en UTF-8"
        TEXTS["fr_rename_validation_pass"]="Validation du fichier de renommage réussie"
        TEXTS["fr_detected_timestamps"]="Détecté %d horodatages, nombre de découpes suggéré: %d"
        TEXTS["fr_output_dir_exists"]="Le répertoire de sortie existe déjà, va vider le contenu existant"
        TEXTS["fr_output_dir_ready"]="Répertoire de sortie prêt: %s"
        TEXTS["fr_start_splitting"]="Début de la division vidéo..."
        TEXTS["fr_total_segments"]="Total de segments à diviser: %d"
        TEXTS["fr_segment_duration_zero"]="La durée du segment %d est 0 ou négative, ignore"
        TEXTS["fr_segment_duration_short"]="La durée du segment %d est inférieure à 2 secondes, peut causer des problèmes"
        TEXTS["fr_split_to_end"]="Division: %s → fin de la vidéo"
        TEXTS["fr_processing"]="Traitement en cours..."
        TEXTS["fr_segment_completed"]="✓ Division du segment %d terminée (temps: %ds)"
        TEXTS["fr_progress_stats"]="[Stats] Terminé: %d, Échoué: %d, Restant: %d"
        TEXTS["fr_final_progress"]="[Terminé] Tous les segments traités"
        TEXTS["fr_split_summary"]="Division terminée! Succès: %d/%d, Échoué: %d, Temps total: %ds"
        TEXTS["fr_result_summary"]="=== Résumé des Résultats de Division ==="
        TEXTS["fr_input_file"]="Fichier d'entrée: %s"
        TEXTS["fr_cut_count"]="Nombre de découpes: %d"
        TEXTS["fr_output_directory"]="Répertoire de sortie: %s"
        TEXTS["fr_generated_files"]="Fichiers générés:"
        TEXTS["fr_no_output_files"]="Aucun fichier généré dans le répertoire de sortie"
        TEXTS["fr_progress_bar"]="[Progrès]"
        TEXTS["fr_processing_segment"]="Traitement du segment %d/%d"
        TEXTS["fr_split_info"]="Division: %s → %s"
        TEXTS["fr_output_info"]="Sortie: %s"
        TEXTS["fr_input_video_found"]="Vidéo d'entrée trouvée"
        
        # Traditional Chinese texts
        TEXTS["zh_welcome"]="🎬 BHEM 視頻分割工具"
        TEXTS["zh_separator"]="========================================"
        TEXTS["zh_language_option"]="3) 繁體中文"
        TEXTS["zh_dependency_check"]="檢查依賴項..."
        TEXTS["zh_ffmpeg_installed"]="FFmpeg 已安裝"
        TEXTS["zh_ffmpeg_not_found"]="找不到 FFmpeg。請先安裝 FFmpeg："
        TEXTS["zh_auto_detected"]="檢測到起始點 %s，自動設置分割數量：%d"
        TEXTS["zh_timestamp_distribution"]="時間戳分佈："
        TEXTS["zh_start_point"]="起始點：%s"
        TEXTS["zh_segment_end"]="片段 %d 結束：%s"
        TEXTS["zh_enter_cut_count"]="請輸入分割數量："
        TEXTS["zh_final_cut_count"]="最終分割數量：%d"
        TEXTS["zh_file_prep_reminder"]="⚠️  文件準備提醒"
        TEXTS["zh_prep_instruction1"]="請確保您已準備好以下文件："
        TEXTS["zh_prep_instruction2"]="1. CutTimestamp.txt - 包含開始時間戳（N 個片段需要 N 行，背對背切割）"
        TEXTS["zh_prep_instruction3"]="2. CutRenameList.txt - 包含片段名稱（N 個片段需要 N 行）"
        TEXTS["zh_prep_instruction4"]="3. 0.* - 您的源視頻文件"
        TEXTS["zh_prep_note"]="注意：背對背切割 - 時間戳文件和重命名文件行數相同"
        TEXTS["zh_files_ready"]="您是否已準備好所有必需的文件？(y/n)："
        TEXTS["zh_please_prepare"]="請先準備文件，然後重新運行腳本。"
        TEXTS["zh_step"]="步驟"
        TEXTS["zh_check_dependency"]="檢查依賴項"
        TEXTS["zh_get_cut_count"]="獲取分割數量"
        TEXTS["zh_validate_timestamp"]="驗證時間戳文件"
        TEXTS["zh_validate_rename"]="驗證重命名文件"
        TEXTS["zh_find_input"]="查找輸入視頻"
        TEXTS["zh_create_output"]="創建輸出目錄"
        TEXTS["zh_split_video"]="分割視頻"
        TEXTS["zh_generate_summary"]="生成摘要"
        TEXTS["zh_all_completed"]="🎉 所有操作完成！"
        TEXTS["zh_all_failed"]="❌ 所有片段都处理失败。请检查输入文件并重试。"
        TEXTS["zh_partial_success"]="⚠️ 处理完成，成功 %d 个，失败 %d 个。"
        TEXTS["zh_segment_range"]="片段 %d: %s → %s"
        TEXTS["zh_segment_to_end"]="片段 %d: %s → 視頻結束"
        TEXTS["zh_timestamp_validation_pass"]="時間戳驗證通過：%d 個時間點，可分割 %d 個片段，當前分割 %d 個"
        TEXTS["zh_timestamp_file_validated"]="時間戳檔案驗證通過"
        TEXTS["zh_rename_count_error"]="重命名數量錯誤。背對背切割模式下，重命名檔案行數應等於時間戳數量。期望 %d 行，實際 %d 行"
        TEXTS["zh_cut_count_invalid"]="分割數量必須是大於 0 的整數"
        TEXTS["zh_timestamp_file_missing"]="時間戳檔案 %s 不存在"
        TEXTS["zh_timestamp_insufficient"]="時間戳數量不足。至少需要 1 個時間戳才能分割出 1 個片段，實際只有 %d 個"
        TEXTS["zh_cut_count_excessive"]="分割數量過多。檔案中有 %d 個時間戳，最多可分割 %d 個片段，但您要求分割 %d 個"
        TEXTS["zh_invalid_time_format"]="第 %d 行時間格式錯誤: %s（應為 HH:MM:SS 格式）"
        TEXTS["zh_timestamp_order_error"]="時間戳順序錯誤。第 %d 行（%s）早於前一行"
        TEXTS["zh_rename_file_missing"]="重命名檔案 %s 不存在"
        TEXTS["zh_empty_rename_line"]="第 %d 行重命名為空"
        TEXTS["zh_input_video_not_found"]="未找到輸入視頻檔案。請將視頻檔案重命名為 0.* 並放在當前目錄"
        TEXTS["zh_supported_formats"]="支持的格式: %s"
        TEXTS["zh_segment_split_failed"]="✗ 片段 %d 分割失敗"
        TEXTS["zh_encoding_warning_timestamp"]="時間戳檔案可能不是 UTF-8 編碼，建議轉換為 UTF-8"
        TEXTS["zh_encoding_warning_rename"]="重命名檔案可能不是 UTF-8 編碼，建議轉換為 UTF-8"
        TEXTS["zh_rename_validation_pass"]="重命名檔案驗證通過"
        TEXTS["zh_detected_timestamps"]="檢測到 %d 個時間戳，建議分割數量: %d"
        TEXTS["zh_output_dir_exists"]="輸出目錄已存在，將清空現有內容"
        TEXTS["zh_output_dir_ready"]="輸出目錄準備完成: %s"
        TEXTS["zh_start_splitting"]="開始分割視頻..."
        TEXTS["zh_total_segments"]="總計需要分割 %d 個片段"
        TEXTS["zh_segment_duration_zero"]="片段 %d 時長為 0 或負數，跳過"
        TEXTS["zh_segment_duration_short"]="片段 %d 時長少於 2 秒，可能會出現問題"
        TEXTS["zh_split_to_end"]="分割: %s → 視頻結束"
        TEXTS["zh_processing"]="正在處理..."
        TEXTS["zh_segment_completed"]="✓ 片段 %d 分割完成（耗時: %ds）"
        TEXTS["zh_progress_stats"]="[統計] 已完成: %d，失敗: %d，剩餘: %d"
        TEXTS["zh_final_progress"]="[完成] 所有片段處理完畢"
        TEXTS["zh_split_summary"]="分割完成！成功: %d/%d，失敗: %d，總耗時: %ds"
        TEXTS["zh_result_summary"]="=== 分割結果摘要 ==="
        TEXTS["zh_input_file"]="輸入檔案: %s"
        TEXTS["zh_cut_count"]="分割數量: %d"
        TEXTS["zh_output_directory"]="輸出目錄: %s"
        TEXTS["zh_generated_files"]="生成的檔案:"
        TEXTS["zh_no_output_files"]="輸出目錄中沒有生成的檔案"
        TEXTS["zh_progress_bar"]="[進度]"
        TEXTS["zh_processing_segment"]="處理片段 %d/%d"
        TEXTS["zh_split_info"]="分割: %s → %s"
        TEXTS["zh_output_info"]="輸出: %s"
        TEXTS["zh_input_video_found"]="找到輸入視頻"
    fi
}

# Get multi-language text
get_text() {
    local key="$1"
    local full_key="${LANGUAGE}_${key}"
    
    if [[ "$USE_ASSOCIATIVE_ARRAY" == "true" ]]; then
        echo "${TEXTS[$full_key]}"
    else
        # Compatibility mode: use case statements
        case "$full_key" in
            # English texts
            "en_welcome") echo "🎬 BHEM Video Splitter Tool" ;;
            "en_separator") echo "========================================" ;;
            "en_select_language") echo "Please select your language / Veuillez sélectionner votre langue / 請選擇您的語言:" ;;
            "en_language_option") echo "1) English" ;;
            "en_language_invalid") echo "Invalid selection. Please enter 1, 2, or 3." ;;
            "en_dependency_check") echo "Checking dependencies..." ;;
            "en_ffmpeg_installed") echo "FFmpeg is installed" ;;
            "en_ffmpeg_not_found") echo "FFmpeg not found. Please install FFmpeg first:" ;;
            "en_auto_detected") echo "Detected start point %s, automatically set cut count: %d" ;;
            "en_timestamp_distribution") echo "Timestamp distribution:" ;;
            "en_start_point") echo "Start point: %s" ;;
            "en_segment_end") echo "Segment %d end: %s" ;;
            "en_enter_cut_count") echo "Please enter cut count: " ;;
            "en_final_cut_count") echo "Final cut count: %d" ;;
            "en_file_prep_reminder") echo "⚠️  File Preparation Reminder" ;;
            "en_prep_instruction1") echo "Please ensure you have prepared the following files:" ;;
            "en_prep_instruction2") echo "1. CutTimestamp.txt - Contains start timestamps (N lines for N segments, back-to-back cutting)" ;;
            "en_prep_instruction3") echo "2. CutRenameList.txt - Contains segment names (N lines for N segments)" ;;
            "en_prep_instruction4") echo "3. 0.* - Your source video file" ;;
            "en_prep_note") echo "Note: Back-to-back cutting - timestamp file and rename file have same number of lines" ;;
            "en_segment_range") echo "Segment %d: %s → %s" ;;
            "en_segment_to_end") echo "Segment %d: %s → end of video" ;;
            "en_files_ready") echo "Have you prepared all the required files? (y/n): " ;;
            "en_please_prepare") echo "Please prepare the files first and run the script again." ;;
            "en_step") echo "Step" ;;
            "en_check_dependency") echo "Check dependencies" ;;
            "en_get_cut_count") echo "Get cut count" ;;
            "en_validate_timestamp") echo "Validate timestamp file" ;;
            "en_validate_rename") echo "Validate rename file" ;;
            "en_find_input") echo "Find input video" ;;
            "en_create_output") echo "Create output directory" ;;
            "en_split_video") echo "Split video" ;;
            "en_generate_summary") echo "Generate summary" ;;
            "en_all_completed") echo "🎉 All operations completed!" ;;
            "en_all_failed") echo "❌ All segments failed to process. Please check the input file and try again." ;;
            "en_partial_success") echo "⚠️ Process completed with %d successes and %d failures." ;;
            "en_timestamp_validation_pass") echo "Timestamp validation passed: %d time points, can cut %d segments, current cutting %d" ;;
            "en_timestamp_file_validated") echo "Timestamp file validated" ;;
            "en_rename_count_error") echo "Rename count error. Back-to-back cutting mode requires rename file lines equal to timestamp count. Expected %d lines, actual %d lines" ;;
            "en_cut_count_invalid") echo "Cut count must be a positive integer" ;;
            "en_timestamp_file_missing") echo "Timestamp file %s does not exist" ;;
            "en_timestamp_insufficient") echo "Insufficient timestamps. Need at least 1 timestamp to cut 1 segment, but only found %d" ;;
            "en_cut_count_excessive") echo "Too many cuts requested. File has %d timestamps, can cut at most %d segments, but you requested %d" ;;
            "en_invalid_time_format") echo "Line %d time format error: %s (should be HH:MM:SS format)" ;;
            "en_timestamp_order_error") echo "Timestamp order error. Line %d (%s) is earlier than previous line" ;;
            "en_rename_file_missing") echo "Rename file %s does not exist" ;;
            "en_empty_rename_line") echo "Line %d rename is empty" ;;
            "en_input_video_not_found") echo "Input video file not found. Please rename your video file to 0.* and place it in current directory" ;;
            "en_supported_formats") echo "Supported formats: %s" ;;
            "en_segment_split_failed") echo "✗ Segment %d split failed" ;;
            "en_encoding_warning_timestamp") echo "Timestamp file may not be UTF-8 encoded, recommend converting to UTF-8" ;;
            "en_encoding_warning_rename") echo "Rename file may not be UTF-8 encoded, recommend converting to UTF-8" ;;
            "en_rename_validation_pass") echo "Rename file validation passed" ;;
            "en_detected_timestamps") echo "Detected %d timestamps, suggested cut count: %d" ;;
            "en_output_dir_exists") echo "Output directory already exists, will clear existing content" ;;
            "en_output_dir_ready") echo "Output directory ready: %s" ;;
            "en_start_splitting") echo "Starting video splitting..." ;;
            "en_total_segments") echo "Total segments to split: %d" ;;
            "en_segment_duration_zero") echo "Segment %d duration is 0 or negative, skipping" ;;
            "en_segment_duration_short") echo "Segment %d duration less than 2 seconds, may cause issues" ;;
            "en_split_to_end") echo "Split: %s → end of video" ;;
            "en_processing") echo "Processing..." ;;
            "en_segment_completed") echo "✓ Segment %d split completed (time: %ds)" ;;
            "en_progress_stats") echo "[Stats] Completed: %d, Failed: %d, Remaining: %d" ;;
            "en_final_progress") echo "[Complete] All segments processed" ;;
            "en_split_summary") echo "Split completed! Success: %d/%d, Failed: %d, Total time: %ds" ;;
            "en_result_summary") echo "=== Split Results Summary ===" ;;
            "en_input_file") echo "Input file: %s" ;;
            "en_cut_count") echo "Cut count: %d" ;;
            "en_output_directory") echo "Output directory: %s" ;;
            "en_generated_files") echo "Generated files:" ;;
            "en_no_output_files") echo "No files generated in output directory" ;;
            "en_progress_bar") echo "[Progress]" ;;
            "en_processing_segment") echo "Processing segment %d/%d" ;;
            "en_split_info") echo "Split: %s → %s" ;;
            "en_output_info") echo "Output: %s" ;;
            "en_input_video_found") echo "Found input video" ;;
            
            # French texts
            "fr_welcome") echo "🎬 Outil de Division Vidéo BHEM" ;;
            "fr_separator") echo "========================================" ;;
            "fr_language_option") echo "2) Français" ;;
            "fr_dependency_check") echo "Vérification des dépendances..." ;;
            "fr_ffmpeg_installed") echo "FFmpeg est installé" ;;
            "fr_ffmpeg_not_found") echo "FFmpeg non trouvé. Veuillez installer FFmpeg d'abord:" ;;
            "fr_auto_detected") echo "Point de départ %s détecté, nombre de découpes défini automatiquement: %d" ;;
            "fr_timestamp_distribution") echo "Distribution des horodatages:" ;;
            "fr_start_point") echo "Point de départ: %s" ;;
            "fr_segment_end") echo "Fin du segment %d: %s" ;;
            "fr_enter_cut_count") echo "Veuillez entrer le nombre de découpes: " ;;
            "fr_final_cut_count") echo "Nombre final de découpes: %d" ;;
            "fr_file_prep_reminder") echo "⚠️  Rappel de Préparation des Fichiers" ;;
            "fr_prep_instruction1") echo "Veuillez vous assurer d'avoir préparé les fichiers suivants:" ;;
            "fr_prep_instruction2") echo "1. CutTimestamp.txt - Contient les horodatages de début (N lignes pour N segments, découpe dos à dos)" ;;
            "fr_prep_instruction3") echo "2. CutRenameList.txt - Contient les noms de segments (N lignes pour N segments)" ;;
            "fr_prep_instruction4") echo "3. 0.* - Votre fichier vidéo source" ;;
            "fr_prep_note") echo "Note: Découpe dos à dos - le fichier d'horodatage et le fichier de renommage ont le même nombre de lignes" ;;
            "fr_segment_range") echo "Segment %d: %s → %s" ;;
            "fr_segment_to_end") echo "Segment %d: %s → fin de la vidéo" ;;
            "fr_files_ready") echo "Avez-vous préparé tous les fichiers requis? (o/n): " ;;
            "fr_please_prepare") echo "Veuillez préparer les fichiers d'abord et relancer le script." ;;
            "fr_step") echo "Étape" ;;
            "fr_check_dependency") echo "Vérifier les dépendances" ;;
            "fr_get_cut_count") echo "Obtenir le nombre de découpes" ;;
            "fr_validate_timestamp") echo "Valider le fichier d'horodatage" ;;
            "fr_validate_rename") echo "Valider le fichier de renommage" ;;
            "fr_find_input") echo "Trouver la vidéo d'entrée" ;;
            "fr_create_output") echo "Créer le répertoire de sortie" ;;
            "fr_split_video") echo "Diviser la vidéo" ;;
            "fr_generate_summary") echo "Générer le résumé" ;;
            "fr_all_completed") echo "🎉 Toutes les opérations terminées!" ;;
            "fr_all_failed") echo "❌ Tous les segments ont échoué. Veuillez vérifier le fichier d'entrée et réessayer." ;;
            "fr_partial_success") echo "⚠️ Processus terminé avec %d succès et %d échecs." ;;
            "fr_timestamp_validation_pass") echo "Validation des horodatages réussie: %d points temporels, peut découper %d segments, découpe actuelle %d" ;;
            "fr_timestamp_file_validated") echo "Fichier d'horodatage validé" ;;
            "fr_rename_count_error") echo "Erreur de comptage de renommage. Le mode découpe dos à dos nécessite que les lignes du fichier de renommage égalent le nombre d'horodatages. Attendu %d lignes, actuel %d lignes" ;;
            "fr_cut_count_invalid") echo "Le nombre de découpes doit être un entier positif" ;;
            "fr_timestamp_file_missing") echo "Le fichier d'horodatage %s n'existe pas" ;;
            "fr_timestamp_insufficient") echo "Horodatages insuffisants. Il faut au moins 1 horodatage pour découper 1 segment, mais seulement %d trouvé" ;;
            "fr_cut_count_excessive") echo "Trop de découpes demandées. Le fichier a %d horodatages, peut découper au maximum %d segments, mais vous en demandez %d" ;;
            "fr_invalid_time_format") echo "Erreur de format temporel ligne %d: %s (devrait être au format HH:MM:SS)" ;;
            "fr_timestamp_order_error") echo "Erreur d'ordre des horodatages. La ligne %d (%s) est antérieure à la ligne précédente" ;;
            "fr_rename_file_missing") echo "Le fichier de renommage %s n'existe pas" ;;
            "fr_empty_rename_line") echo "La ligne %d de renommage est vide" ;;
            "fr_input_video_not_found") echo "Fichier vidéo d'entrée introuvable. Veuillez renommer votre fichier vidéo en 0.* et le placer dans le répertoire courant" ;;
            "fr_supported_formats") echo "Formats supportés: %s" ;;
            "fr_segment_split_failed") echo "✗ Échec de la division du segment %d" ;;
            "fr_encoding_warning_timestamp") echo "Le fichier d'horodatage pourrait ne pas être encodé en UTF-8, recommandé de convertir en UTF-8" ;;
            "fr_encoding_warning_rename") echo "Le fichier de renommage pourrait ne pas être encodé en UTF-8, recommandé de convertir en UTF-8" ;;
            "fr_rename_validation_pass") echo "Validation du fichier de renommage réussie" ;;
            "fr_detected_timestamps") echo "Détecté %d horodatages, nombre de découpes suggéré: %d" ;;
            "fr_output_dir_exists") echo "Le répertoire de sortie existe déjà, va vider le contenu existant" ;;
            "fr_output_dir_ready") echo "Répertoire de sortie prêt: %s" ;;
            "fr_start_splitting") echo "Début de la division vidéo..." ;;
            "fr_total_segments") echo "Total de segments à diviser: %d" ;;
            "fr_segment_duration_zero") echo "La durée du segment %d est 0 ou négative, ignore" ;;
            "fr_segment_duration_short") echo "La durée du segment %d est inférieure à 2 secondes, peut causer des problèmes" ;;
            "fr_split_to_end") echo "Division: %s → fin de la vidéo" ;;
            "fr_processing") echo "Traitement en cours..." ;;
            "fr_segment_completed") echo "✓ Division du segment %d terminée (temps: %ds)" ;;
            "fr_progress_stats") echo "[Stats] Terminé: %d, Échoué: %d, Restant: %d" ;;
            "fr_final_progress") echo "[Terminé] Tous les segments traités" ;;
            "fr_split_summary") echo "Division terminée! Succès: %d/%d, Échoué: %d, Temps total: %ds" ;;
            "fr_result_summary") echo "=== Résumé des Résultats de Division ===" ;;
            "fr_input_file") echo "Fichier d'entrée: %s" ;;
            "fr_cut_count") echo "Nombre de découpes: %d" ;;
            "fr_output_directory") echo "Répertoire de sortie: %s" ;;
            "fr_generated_files") echo "Fichiers générés:" ;;
            "fr_no_output_files") echo "Aucun fichier généré dans le répertoire de sortie" ;;
            "fr_progress_bar") echo "[Progrès]" ;;
            "fr_processing_segment") echo "Traitement du segment %d/%d" ;;
            "fr_split_info") echo "Division: %s → %s" ;;
            "fr_output_info") echo "Sortie: %s" ;;
            "fr_input_video_found") echo "Vidéo d'entrée trouvée" ;;
            
            # Traditional Chinese texts
            "zh_welcome") echo "🎬 BHEM 視頻分割工具" ;;
            "zh_separator") echo "========================================" ;;
            "zh_language_option") echo "3) 繁體中文" ;;
            "zh_dependency_check") echo "檢查依賴項..." ;;
            "zh_ffmpeg_installed") echo "FFmpeg 已安裝" ;;
            "zh_ffmpeg_not_found") echo "找不到 FFmpeg。請先安裝 FFmpeg：" ;;
            "zh_auto_detected") echo "檢測到起始點 %s，自動設置分割數量：%d" ;;
            "zh_timestamp_distribution") echo "時間戳分佈：" ;;
            "zh_start_point") echo "起始點：%s" ;;
            "zh_segment_end") echo "片段 %d 結束：%s" ;;
            "zh_enter_cut_count") echo "請輸入分割數量：" ;;
            "zh_final_cut_count") echo "最終分割數量：%d" ;;
            "zh_file_prep_reminder") echo "⚠️  文件準備提醒" ;;
            "zh_prep_instruction1") echo "請確保您已準備好以下文件：" ;;
            "zh_prep_instruction2") echo "1. CutTimestamp.txt - 包含開始時間戳（N 個片段需要 N 行，背對背切割）" ;;
            "zh_prep_instruction3") echo "2. CutRenameList.txt - 包含片段名稱（N 個片段需要 N 行）" ;;
            "zh_prep_instruction4") echo "3. 0.* - 您的源視頻文件" ;;
            "zh_prep_note") echo "注意：背對背切割 - 時間戳文件和重命名文件行數相同" ;;
            "zh_segment_range") echo "片段 %d: %s → %s" ;;
            "zh_segment_to_end") echo "片段 %d: %s → 視頻結束" ;;
            "zh_files_ready") echo "您是否已準備好所有必需的文件？(y/n)：" ;;
            "zh_please_prepare") echo "請先準備文件，然後重新運行腳本。" ;;
            "zh_step") echo "步驟" ;;
            "zh_check_dependency") echo "檢查依賴項" ;;
            "zh_get_cut_count") echo "獲取分割數量" ;;
            "zh_validate_timestamp") echo "驗證時間戳文件" ;;
            "zh_validate_rename") echo "驗證重命名文件" ;;
            "zh_find_input") echo "查找輸入視頻" ;;
            "zh_create_output") echo "創建輸出目錄" ;;
            "zh_split_video") echo "分割視頻" ;;
            "zh_generate_summary") echo "生成摘要" ;;
            "zh_all_completed") echo "🎉 所有操作完成！" ;;
            "zh_all_failed") echo "❌ 所有片段都处理失败。请检查输入文件并重试。" ;;
            "zh_partial_success") echo "⚠️ 处理完成，成功 %d 个，失败 %d 个。" ;;
            "zh_timestamp_validation_pass") echo "時間戳驗證通過：%d 個時間點，可分割 %d 個片段，當前分割 %d 個" ;;
            "zh_timestamp_file_validated") echo "時間戳檔案驗證通過" ;;
            "zh_rename_count_error") echo "重命名數量錯誤。背對背切割模式下，重命名檔案行數應等於時間戳數量。期望 %d 行，實際 %d 行" ;;
            "zh_cut_count_invalid") echo "分割數量必須是大於 0 的整數" ;;
            "zh_timestamp_file_missing") echo "時間戳檔案 %s 不存在" ;;
            "zh_timestamp_insufficient") echo "時間戳數量不足。至少需要 1 個時間戳才能分割出 1 個片段，實際只有 %d 個" ;;
            "zh_cut_count_excessive") echo "分割數量過多。檔案中有 %d 個時間戳，最多可分割 %d 個片段，但您要求分割 %d 個" ;;
            "zh_invalid_time_format") echo "第 %d 行時間格式錯誤: %s（應為 HH:MM:SS 格式）" ;;
            "zh_timestamp_order_error") echo "時間戳順序錯誤。第 %d 行（%s）早於前一行" ;;
            "zh_rename_file_missing") echo "重命名檔案 %s 不存在" ;;
            "zh_empty_rename_line") echo "第 %d 行重命名為空" ;;
            "zh_input_video_not_found") echo "未找到輸入視頻檔案。請將視頻檔案重命名為 0.* 並放在當前目錄" ;;
            "zh_supported_formats") echo "支持的格式: %s" ;;
            "zh_segment_split_failed") echo "✗ 片段 %d 分割失敗" ;;
            "zh_encoding_warning_timestamp") echo "時間戳檔案可能不是 UTF-8 編碼，建議轉換為 UTF-8" ;;
            "zh_encoding_warning_rename") echo "重命名檔案可能不是 UTF-8 編碼，建議轉換為 UTF-8" ;;
            "zh_rename_validation_pass") echo "重命名檔案驗證通過" ;;
            "zh_detected_timestamps") echo "檢測到 %d 個時間戳，建議分割數量: %d" ;;
            "zh_output_dir_exists") echo "輸出目錄已存在，將清空現有內容" ;;
            "zh_output_dir_ready") echo "輸出目錄準備完成: %s" ;;
            "zh_start_splitting") echo "開始分割視頻..." ;;
            "zh_total_segments") echo "總計需要分割 %d 個片段" ;;
            "zh_segment_duration_zero") echo "片段 %d 時長為 0 或負數，跳過" ;;
            "zh_segment_duration_short") echo "片段 %d 時長少於 2 秒，可能會出現問題" ;;
            "zh_split_to_end") echo "分割: %s → 視頻結束" ;;
            "zh_processing") echo "正在處理..." ;;
            "zh_segment_completed") echo "✓ 片段 %d 分割完成（耗時: %ds）" ;;
            "zh_progress_stats") echo "[統計] 已完成: %d，失敗: %d，剩餘: %d" ;;
            "zh_final_progress") echo "[完成] 所有片段處理完畢" ;;
            "zh_split_summary") echo "分割完成！成功: %d/%d，失敗: %d，總耗時: %ds" ;;
            "zh_result_summary") echo "=== 分割結果摘要 ===" ;;
            "zh_input_file") echo "輸入檔案: %s" ;;
            "zh_cut_count") echo "分割數量: %d" ;;
            "zh_output_directory") echo "輸出目錄: %s" ;;
            "zh_generated_files") echo "生成的檔案:" ;;
            "zh_no_output_files") echo "輸出目錄中沒有生成的檔案" ;;
            "zh_progress_bar") echo "[進度]" ;;
            "zh_processing_segment") echo "處理片段 %d/%d" ;;
            "zh_split_info") echo "分割: %s → %s" ;;
            "zh_output_info") echo "輸出: %s" ;;
            "zh_input_video_found") echo "找到輸入視頻" ;;
            
            *) echo "$key" ;;
        esac
    fi
}

# Language selection function
select_language() {
    echo
    echo "Please select your language / Veuillez sélectionner votre langue / 請選擇您的語言:"
    echo "1) English"
    echo "2) Français"
    echo "3) 繁體中文"
    echo
    while true; do
        read -p "Enter your choice (1-3): " choice
        case $choice in
            1) LANGUAGE="en"; break;;
            2) LANGUAGE="fr"; break;;
            3) LANGUAGE="zh"; break;;
            *) echo "Invalid selection. Please enter 1, 2, or 3.";;
        esac
    done
    clear
}


# Simple FFmpeg execution without detailed progress
execute_ffmpeg_with_progress() {
    local ffmpeg_cmd="$1"
    local segment_num="$2"
    local total_segments="$3"
    
    # Execute directly without progress monitoring
    eval "$ffmpeg_cmd -v error" </dev/null 2>/dev/null
    return $?
}

# File preparation confirmation function
check_file_preparation() {
    echo -e "${YELLOW}$(get_text "file_prep_reminder")${NC}"
    echo
    echo "$(get_text "prep_instruction1")"
    echo "$(get_text "prep_instruction2")"
    echo "$(get_text "prep_instruction3")"
    echo "$(get_text "prep_instruction4")"
    echo
    echo -e "${BLUE}$(get_text "prep_note")${NC}"
    echo
    
    while true; do
        read -p "$(get_text "files_ready")" ready
        case $ready in
            [Yy]|[Oo]) break;;
            [Nn]) 
                echo "$(get_text "please_prepare")"
                exit 1
                ;;
            *) echo "Please answer y/n (or o/n for French)";;
        esac
    done
}

# Print colored messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check necessary dependencies
check_dependencies() {
    print_info "$(get_text "dependency_check")"
    
    if ! command -v ffmpeg &> /dev/null; then
        print_error "$(get_text "ffmpeg_not_found")"
        echo "macOS: brew install ffmpeg"
        echo "Ubuntu: sudo apt install ffmpeg"
        exit 1
    fi
    
    print_success "$(get_text "ffmpeg_installed")"
}

# Validate time format (HH:MM:SS)
validate_time_format() {
    local time_str="$1"
    if [[ ! $time_str =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
        return 1
    fi
    return 0
}

# Convert time to seconds
time_to_seconds() {
    local time_str="$1"
    local hours=$(echo "$time_str" | cut -d: -f1)
    local minutes=$(echo "$time_str" | cut -d: -f2)
    local seconds=$(echo "$time_str" | cut -d: -f3)
    echo $((10#$hours * 3600 + 10#$minutes * 60 + 10#$seconds))
}

# Get cut count
get_cut_count() {
    if [ -z "$CUT_COUNT" ]; then
        # Intelligently analyze timestamp file to automatically calculate cut count
        if [ -f "CutTimestamp.txt" ]; then
            local preview_timestamps=()
            while IFS= read -r line; do
                preview_timestamps+=("$line")
            done < <(grep -v '^[[:space:]]*$' "CutTimestamp.txt" | sed 's/[[:space:]]*\/.*$//' | grep -v '^[[:space:]]*$')
            
            # Check if there are enough timestamps for automatic detection
            if [ ${#preview_timestamps[@]} -gt 0 ]; then
                # Back-to-back cutting: timestamp count = segment count
                CUT_COUNT=${#preview_timestamps[@]}
                printf "$(get_text "auto_detected")\n" "${preview_timestamps[0]}" "$CUT_COUNT"
                print_info "$(get_text "timestamp_distribution")"
                for ((i=0; i<${#preview_timestamps[@]}; i++)); do
                    local segment_num=$((i+1))
                    if [ $i -eq $((${#preview_timestamps[@]} - 1)) ]; then
                        printf "  $(get_text "segment_to_end")\n" "$segment_num" "${preview_timestamps[$i]}"
                    else
                        local next_time="${preview_timestamps[$((i+1))]}"
                        printf "  $(get_text "segment_range")\n" "$segment_num" "${preview_timestamps[$i]}" "$next_time"
                    fi
                done
            else
                local max_cuts=${#preview_timestamps[@]}
                local detected_msg=$(printf "$(get_text "detected_timestamps")" "${#preview_timestamps[@]}" "$max_cuts")
                print_info "$detected_msg"
                read -p "$(get_text "enter_cut_count")" CUT_COUNT
            fi
        else
            read -p "$(get_text "enter_cut_count")" CUT_COUNT
        fi
    fi
    
    if ! [[ "$CUT_COUNT" =~ ^[0-9]+$ ]] || [ "$CUT_COUNT" -lt 1 ]; then
        print_error "$(get_text "cut_count_invalid")"
        exit 1
    fi
    
    printf "$(get_text "final_cut_count")\n" "$CUT_COUNT"
}

# Validate and read timestamp file
validate_timestamp_file() {
    local timestamp_file="CutTimestamp.txt"
    
    if [ ! -f "$timestamp_file" ]; then
        local error_msg=$(printf "$(get_text "timestamp_file_missing")" "$timestamp_file")
        print_error "$error_msg"
        exit 1
    fi
    
    # Check file encoding
    if ! file "$timestamp_file" | grep -q "UTF-8\|ASCII"; then
        print_warning "$(get_text "encoding_warning_timestamp")"
    fi
    
    # Read timestamps to array, ignore empty lines, and extract timestamp part before "/"
    timestamps=()
    while IFS= read -r line; do
        timestamps+=("$line")
    done < <(grep -v '^[[:space:]]*$' "$timestamp_file" | sed 's/[[:space:]]*\/.*$//' | grep -v '^[[:space:]]*$')
    
    # Validate timestamp count - back-to-back cutting mode
    local timestamp_count=${#timestamps[@]}
    
    if [ $timestamp_count -lt 1 ]; then
        local error_msg=$(printf "$(get_text "timestamp_insufficient")" "$timestamp_count")
        print_error "$error_msg"
        exit 1
    fi
    
    if [ $CUT_COUNT -gt $timestamp_count ]; then
        local error_msg=$(printf "$(get_text "cut_count_excessive")" "$timestamp_count" "$timestamp_count" "$CUT_COUNT")
        print_error "$error_msg"
        local suggestion_msg=$(printf "$(get_text "detected_timestamps")" "$timestamp_count" "$timestamp_count")
        print_info "$suggestion_msg"
        exit 1
    fi
    
    local validation_msg=$(printf "$(get_text "timestamp_validation_pass")" "$timestamp_count" "$timestamp_count" "$CUT_COUNT")
    print_success "$validation_msg"
    
    # Validate time format and sequence
    local prev_seconds=0
    for i in "${!timestamps[@]}"; do
        local timestamp="${timestamps[$i]}"
        if ! validate_time_format "$timestamp"; then
            local error_msg=$(printf "$(get_text "invalid_time_format")" "$((i+1))" "$timestamp")
            print_error "$error_msg"
            exit 1
        fi
        
        local current_seconds=$(time_to_seconds "$timestamp")
        if [ $current_seconds -lt $prev_seconds ]; then
            local error_msg=$(printf "$(get_text "timestamp_order_error")" "$((i+1))" "$timestamp")
            print_error "$error_msg"
            exit 1
        fi
        prev_seconds=$current_seconds
    done
    
    print_success "$(get_text "timestamp_file_validated")"
}

# Validate and read rename file
validate_rename_file() {
    local rename_file="CutRenameList.txt"
    
    if [ ! -f "$rename_file" ]; then
        local error_msg=$(printf "$(get_text "rename_file_missing")" "$rename_file")
        print_error "$error_msg"
        exit 1
    fi
    
    # Check file encoding
    if ! file "$rename_file" | grep -q "UTF-8\|ASCII"; then
        print_warning "$(get_text "encoding_warning_rename")"
    fi
    
    # Read rename list to array
    rename_list=()
    while IFS= read -r line; do
        rename_list+=("$line")
    done < <(grep -v '^[[:space:]]*$' "$rename_file")
    
    # Validate rename count - back-to-back cutting mode: timestamp count = rename count
    if [ ${#rename_list[@]} -ne $CUT_COUNT ]; then
        local error_msg=$(printf "$(get_text "rename_count_error")" "$CUT_COUNT" "${#rename_list[@]}")
        print_error "$error_msg"
        exit 1
    fi
    
    # Check empty lines
    for i in "${!rename_list[@]}"; do
        if [ -z "${rename_list[$i]// }" ]; then
            local error_msg=$(printf "$(get_text "empty_rename_line")" "$((i+1))")
            print_error "$error_msg"
            exit 1
        fi
    done
    
    print_success "$(get_text "rename_validation_pass")"
}

# Find input video file
find_input_video() {
    # Supported video formats
    local video_extensions=("mp4" "avi" "mkv" "mov" "wmv" "flv" "webm" "m4v" "ts")
    
    input_video=""
    for ext in "${video_extensions[@]}"; do
        if [ -f "0.$ext" ]; then
            input_video="0.$ext"
            break
        fi
    done
    
    if [ -z "$input_video" ]; then
        print_error "$(get_text "input_video_not_found")"
        local formats_msg=$(printf "$(get_text "supported_formats")" "${video_extensions[*]}")
        print_info "$formats_msg"
        exit 1
    fi
    
    print_success "$(get_text "input_video_found"): $input_video"
}

# Create output directory
create_output_dir() {
    local output_dir="Video-Spliter-Output"
    
    if [ -d "$output_dir" ]; then
        print_warning "$(get_text "output_dir_exists")"
        rm -rf "$output_dir"/*
    else
        mkdir -p "$output_dir"
    fi
    
    local ready_msg=$(printf "$(get_text "output_dir_ready")" "$output_dir")
    print_success "$ready_msg"
}

# Execute video splitting
split_video() {
    print_info "$(get_text "start_splitting")"
    local total_msg=$(printf "$(get_text "total_segments")" "$CUT_COUNT")
    print_info "$total_msg"
    
    
    local total_cuts=$CUT_COUNT
    local success_count=0
    local failed_count=0
    local start_time_total=$(date +%s)
    
    for ((i=0; i<CUT_COUNT; i++)); do
        local start_time="${timestamps[$i]}"
        local end_time=""
        if [ $i -lt $((CUT_COUNT - 1)) ]; then
            # Not the last segment, use next timestamp as end time
            end_time="${timestamps[$((i+1))]}"
        fi
        local output_name="${rename_list[$i]}"
        
        # Clean special characters in filename for shell safety
        local safe_name=$(echo "$output_name" | tr "<>:\"/\\|?*'" "_")
        local output_file="Video-Spliter-Output/${safe_name}.mp4"
        
        # Calculate percentage
        local percentage=$(( (i * 100) / total_cuts ))
        local progress_bar=""
        local bar_length=20
        local filled=$(( (i * bar_length) / total_cuts ))
        
        # Generate progress bar
        for ((j=0; j<bar_length; j++)); do
            if [ $j -lt $filled ]; then
                progress_bar+="█"
            else
                progress_bar+="░"
            fi
        done
        
        local progress_text=$(get_text "progress_bar")
        local processing_text=$(printf "$(get_text "processing_segment")" "$((i+1))" "$total_cuts")
        echo -e "${BLUE}$progress_text${NC} [$progress_bar] ${percentage}% - $processing_text"
        if [ -n "$end_time" ]; then
            local split_msg=$(printf "$(get_text "split_info")" "$start_time" "$end_time")
            print_info "$split_msg"
            # Calculate duration check
            local start_seconds=$(time_to_seconds "$start_time")
            local end_seconds=$(time_to_seconds "$end_time")
            local duration=$((end_seconds - start_seconds))
            
            if [ $duration -le 0 ]; then
                local warning_msg=$(printf "$(get_text "segment_duration_zero")" "$((i+1))")
                print_warning "$warning_msg"
                continue
            fi
            
            if [ $duration -lt 2 ]; then
                local warning_msg=$(printf "$(get_text "segment_duration_short")" "$((i+1))")
                print_warning "$warning_msg"
            fi
        else
            local split_msg=$(printf "$(get_text "split_to_end")" "$start_time")
            print_info "$split_msg"
        fi
        local output_msg=$(printf "$(get_text "output_info")" "$output_file")
        print_info "$output_msg"
        
        # Record start time
        local segment_start_time=$(date +%s)
        
        # Execute FFmpeg splitting using standard mode (stream copy)
        local ffmpeg_cmd
        if [ -n "$end_time" ]; then
            local start_seconds=$(time_to_seconds "$start_time")
            local end_seconds=$(time_to_seconds "$end_time")
            local duration_seconds=$((end_seconds - start_seconds))
            local duration_time=$(printf "%02d:%02d:%02d" $((duration_seconds/3600)) $(((duration_seconds%3600)/60)) $((duration_seconds%60)))
            # Standard mode: Stream copy with reset_timestamps
            ffmpeg_cmd="ffmpeg -nostdin -ss '$start_time' -i '$input_video' -t '$duration_time' -c copy -reset_timestamps 1 -avoid_negative_ts make_zero '$output_file' -y"
        else
            ffmpeg_cmd="ffmpeg -nostdin -ss '$start_time' -i '$input_video' -c copy -reset_timestamps 1 -avoid_negative_ts make_zero '$output_file' -y"
        fi
        
        if execute_ffmpeg_with_progress "$ffmpeg_cmd" "$((i+1))" "$total_cuts"; then
            local segment_end_time=$(date +%s)
            local segment_duration=$((segment_end_time - segment_start_time))
            local success_msg=$(printf "$(get_text "segment_completed")" "$((i+1))" "$segment_duration")
            print_success "$success_msg"
            ((success_count++))
            ((GLOBAL_SUCCESS_COUNT++))
        else
            local error_msg=$(printf "$(get_text "segment_split_failed")" "$((i+1))")
            print_error "$error_msg"
            ((failed_count++))
            ((GLOBAL_FAILED_COUNT++))
        fi
        
        # Display current progress statistics
        local stats_msg=$(printf "$(get_text "progress_stats")" "$success_count" "$failed_count" "$((total_cuts - i - 1))")
        echo -e "${GREEN}$stats_msg${NC}"
        echo
    done
    
    # Display final progress bar
    local final_progress_bar=""
    for ((j=0; j<20; j++)); do
        final_progress_bar+="█"
    done
    echo -e "${GREEN}$(get_text "final_progress")${NC} [$final_progress_bar] 100%"
    
    local end_time_total=$(date +%s)
    local total_duration=$((end_time_total - start_time_total))
    
    local summary_msg=$(printf "$(get_text "split_summary")" "$success_count" "$total_cuts" "$failed_count" "$total_duration")
    print_success "$summary_msg"
}

# Display result summary
show_summary() {
    print_info "$(get_text "result_summary")"
    local input_msg=$(printf "$(get_text "input_file")" "$input_video")
    echo "$input_msg"
    local count_msg=$(printf "$(get_text "cut_count")" "$CUT_COUNT")
    echo "$count_msg"
    local dir_msg=$(printf "$(get_text "output_directory")" "Video-Spliter-Output/")
    echo "$dir_msg"
    echo
    print_info "$(get_text "generated_files")"
    
    if [ -d "Video-Spliter-Output" ]; then
        local file_count=0
        for file in Video-Spliter-Output/*.mp4; do
            if [ -f "$file" ]; then
                local filesize=$(du -h "$file" | cut -f1)
                echo "  $(basename "$file") ($filesize)"
                ((file_count++))
            fi
        done
        
        if [ $file_count -eq 0 ]; then
            print_warning "$(get_text "no_output_files")"
        fi
    fi
}

# Main function
main() {
    # Initialize language texts
    init_language_texts
    
    # Language selection
    select_language
    
    # Display welcome information
    echo "$(get_text "welcome")"
    echo "$(get_text "separator")"
    
    # File preparation confirmation
    check_file_preparation
    
    
    local total_steps=8
    local current_step=0
    
    # Step 1: Check dependencies
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "check_dependency")"
    check_dependencies
    
    # Step 2: Get cut count
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "get_cut_count")"
    get_cut_count
    
    # Step 3: Validate timestamp file
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "validate_timestamp")"
    validate_timestamp_file
    
    # Step 4: Validate rename file
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "validate_rename")"
    validate_rename_file
    
    # Step 5: Find input video
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "find_input")"
    find_input_video
    
    # Step 6: Create output directory
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "create_output")"
    create_output_dir
    
    # Step 7: Split video
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "split_video")"
    split_video
    
    # Step 8: Generate summary
    ((current_step++))
    echo -e "${YELLOW}[$(get_text "step") $current_step/$total_steps]${NC} $(get_text "generate_summary")"
    show_summary
    
    echo
    # Show appropriate final message based on results
    if [ $GLOBAL_SUCCESS_COUNT -eq 0 ] && [ $GLOBAL_FAILED_COUNT -gt 0 ]; then
        print_error "$(get_text "all_failed")"
        exit 1
    elif [ $GLOBAL_FAILED_COUNT -gt 0 ]; then
        local partial_msg=$(printf "$(get_text "partial_success")" "$GLOBAL_SUCCESS_COUNT" "$GLOBAL_FAILED_COUNT")
        print_warning "$partial_msg"
    else
        print_success "$(get_text "all_completed")"
    fi
}

# Run main function
main "$@"