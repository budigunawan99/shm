enum ActionPage {
  add,
  edit;

  bool get isEdit => this == ActionPage.edit;
}
