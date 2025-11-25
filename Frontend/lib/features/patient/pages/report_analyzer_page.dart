import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chronocancer_ai/health_score_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
// import 'package:pdf_google_fonts/pdf_google_fonts.dart';


class ReportHistory {
  static List<Map<String, dynamic>> history = [];

  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString("saved_reports");
    if (saved != null) {
      history = List<Map<String, dynamic>>.from(jsonDecode(saved));
    }
  }

  static Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("saved_reports", jsonEncode(history));
  }

  static Future<void> addReport(
      String filename, String aiText, String timestamp) async {
    history.add({
      "file": filename,
      "time": timestamp,
      "analysis": aiText,
    });
    await save();
  }

  static Future<void> deleteReport(int index) async {
    history.removeAt(index);
    await save();
  }
}

// =======================================================================

class ReportAnalyzerPage extends StatefulWidget {
  const ReportAnalyzerPage({super.key});

  @override
  State<ReportAnalyzerPage> createState() => _ReportAnalyzerPageState();
}

class _ReportAnalyzerPageState extends State<ReportAnalyzerPage> {
  File? selectedFile;
  String? aiResult;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ReportHistory.load();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      type: FileType.custom,
    );
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        aiResult = null;
      });
    }
  }

  void deleteFile() {
    setState(() {
      selectedFile = null;
      aiResult = null;
    });
  }

  Future<void> analyzeWithAI(File file) async {
    setState(() => isLoading = true);

    try {
      final uri = Uri.parse("http://192.168.7.8:8000/analyze");

      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      setState(() {
        aiResult = data["analysis"];
      });

      if (data["health_score"] != null) {
        HealthScoreStore.score = data["health_score"];
      }

      String filename = file.path.split('/').last;
      String timestamp = DateFormat("dd/MM/yyyy  HH:mm").format(DateTime.now());

      await ReportHistory.addReport(filename, aiResult!, timestamp);

    } catch (e) {
      setState(() {
        aiResult = "⚠️ Error contacting AI server\n$e";
      });
    }

    setState(() => isLoading = false);
  }

  // ===================================================================
  // 📄 EXPORT REPORT TO PDF
Future<void> generatePdf(String filename, String content) async {
  try {
    final fontData = await rootBundle.load("assets/fonts/NotoSans-Regular.ttf");
    final emojiFont = pw.Font.ttf(fontData.buffer.asByteData());

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Paragraph(
            text: content,
            style: pw.TextStyle(
              font: emojiFont,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$filename.pdf");
    await file.writeAsBytes(await pdf.save());

    print("PDF saved at: ${file.path}");
    OpenFilex.open(file.path);
  } catch (e) {
    print("❗ ERROR EXPORTING PDF: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error generating PDF: $e")),
    );
  }
}



  // ===================================================================
  // 🔗 SHARE REPORT THROUGH WHATSAPP / EMAIL
  Future<void> shareReport(String text) async {
    Share.share(text);
  }

  // ===================================================================

  Widget buildFilePreview() {
    if (selectedFile == null) return const SizedBox();

    String path = selectedFile!.path.toLowerCase();

    if (path.endsWith(".png") ||
        path.endsWith(".jpg") ||
        path.endsWith(".jpeg")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(selectedFile!, height: 220, fit: BoxFit.cover),
      );
    }

    return OutlinedButton.icon(
      onPressed: () => OpenFilex.open(selectedFile!.path),
      icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
      label: const Text("Open PDF"),
    );
  }

  // ===================================================================
  // 📜 HISTORY UI
  // ===================================================================
  Widget buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        const Text("📜 Report History",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),

        SizedBox(
          height: 350,
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: ReportHistory.history.length,
              itemBuilder: (ctx, index) {
                int i = ReportHistory.history.length - 1 - index;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "📄 ${ReportHistory.history[i]["file"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),

                          // DELETE
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await ReportHistory.deleteReport(i);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Text("⏳ ${ReportHistory.history[i]["time"]}",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 13)),
                      const SizedBox(height: 6),
                      Text(
                        "${ReportHistory.history[i]["analysis"]}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // VIEW FULL
                          TextButton(
                            child: const Text("View Full"),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(ReportHistory.history[i]["file"]),
                                content: SingleChildScrollView(
                                  child:
                                      Text(ReportHistory.history[i]["analysis"]),
                                ),
                                actions: [
                                  TextButton(
                                      child: const Text("Close"),
                                      onPressed: () =>
                                          Navigator.pop(context))
                                ],
                              ),
                            ),
                          ),

                          // SHARE
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.blue),
                            onPressed: () =>
                                shareReport(ReportHistory.history[i]["analysis"]),
                          ),

                          // EXPORT PDF
                          IconButton(
                            icon:
                                const Icon(Icons.picture_as_pdf, color: Colors.purple),
                            onPressed: () => generatePdf(
                                ReportHistory.history[i]["file"],
                                ReportHistory.history[i]["analysis"]),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ===================================================================
  // UI BUILD
  // ===================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xff6A0DAD),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "AI Report Analyzer",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 15),

              // ================ UPLOAD UI ===================
              Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      
      // ---------------- HEADER ----------------
      Text(
        "Upload Medical Report",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Color(0xff5F11C6),
        ),
      ),

      const SizedBox(height: 10),

      Text(
        "Supported formats: PDF, PNG, JPG",
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
      ),

      const SizedBox(height: 20),

      // ---------------- PREVIEW ----------------
      if (selectedFile != null)
        buildFilePreview()
      else
  GestureDetector(
    onTap: pickFile,
    child: Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF4EEFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xffC9B5FF)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload,
                size: 42, color: Color(0xff7A25D0)),
            const SizedBox(height: 10),
            Text(
              "Tap to upload report",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff6C00FF),
              ),
            ),
            Text(
              "PDF / PNG / JPG",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    ),
  ),


      const SizedBox(height: 20),

      // ---------------- BUTTONS ----------------
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff6C00FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    selectedFile == null ? "Select File" : "Change File",
                    style:
                        TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          if (selectedFile != null)
            const SizedBox(width: 10),

          if (selectedFile != null)
            ElevatedButton(
              onPressed: deleteFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(55, 48),
              ),
              child: Icon(Icons.delete_forever, color: Colors.white),
            ),
        ],
      ),

      const SizedBox(height: 20),

      // ---------------- ANALYZE BTN ----------------
      ElevatedButton(
        onPressed: selectedFile != null && !isLoading
            ? () => analyzeWithAI(selectedFile!)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff9C27B0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: Size(double.infinity, 55),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            else
              Icon(Icons.auto_awesome, color: Colors.white),

            SizedBox(width: 10),
            Text(
              isLoading ? "Analyzing..." : "Analyze Report with AI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

              const SizedBox(height: 20),

              // ========= SHOW RESULT + PDF + SHARE ==========
              if (aiResult != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xffF3E5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(aiResult!),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SHARE NOW
                          ElevatedButton.icon(
                            onPressed: () => shareReport(aiResult!),
                            icon: const Icon(Icons.share),
                            label: const Text("Share"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () => generatePdf("current_report", aiResult!),
                            icon: const Icon(Icons.picture_as_pdf),
                            label: const Text("Export PDF"),
                          )
                        ],
                      )
                    ],
                  ),
                ),

              buildHistorySection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
