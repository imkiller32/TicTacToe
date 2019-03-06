class Module {

  bool botEnabled;
  bool soundEnabled;

  Module(this.botEnabled,this.soundEnabled);

  void setBot(botEnabled){
    this.botEnabled=botEnabled;
  }
  void setSound(soundEnabled){
    this.soundEnabled=soundEnabled;
  }

  bool getBot(){
    return this.botEnabled;
  }
  bool getSound(){
    return this.soundEnabled;
  }
}

Module module =Module(false, false);