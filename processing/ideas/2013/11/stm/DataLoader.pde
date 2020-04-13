class DataLoader {
  File[] files;
  
  DataLoader() {
    File dir = new File(sketchPath(""));
    files = dir.listFiles(new FilenameFilter() {
      public boolean accept(File dir, String name) {
        name = name.toLowerCase();
        return name.startsWith("im") && name.endsWith(".txt");
      }
    }
    );  
  }
  void load(int which) {
    data = new Data(files[which]);   
    rendered = false;
  }
}
