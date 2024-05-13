class AIData {
  bool loading;
  bool dataReceived;
  String? summarizeText;

  AIData({
    required this.loading,
    required this.dataReceived,
    required this.summarizeText,
  });


  void setLoading(bool value) {
    loading = value;
  }
  void setDataReceived(bool value) {
    dataReceived = value;
  }
  void setSummarizeText(String? value) {
    summarizeText = value;
  }
}
