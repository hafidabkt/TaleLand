class notif {
  final String title;
  final String subtitle;
  notif({
    required this.title,
    required this.subtitle,
  });
}

List<notif> notifications = [
  notif(title: 'Reading Session', subtitle: 'Lost'),
  notif(title: 'Update', subtitle: 'This is Not a Goast Story'),
  notif(title: 'Update', subtitle: 'Butterfly kisses'),
  notif(title: 'Reading Session', subtitle: 'Stay the Night'),
];
