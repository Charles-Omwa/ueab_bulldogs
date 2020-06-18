class PlayerPost {
  String playerimage, description, date, time;
  String playerpostKey;
  PlayerPost(this.playerimage, this.description, this.date, this.time, this.playerpostKey);

  toJson() {
    return {
      'picture': playerimage,
      'description': description,
      'date': date,
      'time': time,
    };
  }
}
