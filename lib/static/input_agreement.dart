class InputAgreement {
  String title;
  String topic;
  List<String> signers;
  String country;
  String company;

  InputAgreement(
      {required this.country,
      required this.signers,
      required this.title,
      required this.topic,
      this.company = ""});

  String formatSignees(List<String> signees) {
    // transform the list of signees into a string
    // example: "signee1, signee2 ... and signeeN"
    String formattedSignees = "";
    for (int i = 0; i < signees.length; i++) {
      if (i == signees.length - 1) {
        formattedSignees += "and ${signees[i]}";
      } else {
        formattedSignees += "${signees[i]}, ";
      }
    }
    return formattedSignees;
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    return formattedDate;
  }

  String generatePrompt() {
    String signees = formatSignees(signers);
    String currentDate = getCurrentDate();
    String prompt =
        "This is an agreement contract between $signees following the regulations of $country. The signees request the following:\n";
    prompt += "The contract is titled $title and is about \"$topic\".\n";
    prompt += "The signees are: $signees\n";
    if (company != "") {
      prompt += "The company in cause is: $company\n";
    }
    prompt += "Date of signature: $currentDate\n";
    prompt +=
        "The contract should be written following the rules of $country in a formal descriptive manner. At the end, it should include space for the signees to sign. \n";
    prompt +=
        "Add more information if necessary. Make it long and exclude any information we do not have.\n";

    return prompt;
  }
}
