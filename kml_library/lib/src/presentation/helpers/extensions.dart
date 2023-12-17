extension ExtendedString on String {
  String cleanUp() {
    return replaceAll("<![CDATA[", "").replaceAll("]]>", "");
  }
}
