class Agreement {
  String country;
  String date;
  String idDropbox;
  List<String> signers;
  String status;
  String title;
  String topic;
  String url;

  Agreement({
    required this.country,
    required this.date,
    required this.idDropbox,
    required this.signers,
    required this.status,
    required this.title,
    required this.topic,
    required this.url,
  });

  factory Agreement.fromJson(Map<String, dynamic> json) {
    return Agreement(
      country: json['country'],
      date: json['date'],
      idDropbox: json['id_dropbox'],
      signers: json['signers'].split(','),
      status: json['status'],
      title: json['title'],
      topic: json['topic'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['date'] = this.date;
    data['id_dropbox'] = this.idDropbox;
    data['signers'] = this.signers.join(',');
    data['status'] = this.status;
    data['title'] = this.title;
    data['topic'] = this.topic;
    data['url'] = this.url;
    return data;
  }
}
