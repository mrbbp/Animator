/*
  v3 :  - selection du fichier à produire
        - enregistre les images dans un dossier au nom du fichier

*/

JSONObject json;
int speed, nLargeur,nHauteur,largeur,hauteur;
JSONArray datas;
JSONArray imgEncours;
int indexBlocImgEncours;
int numImg = 0;
int[] aImgEncours;
Boolean flag = false;
String[] nomFichier;
String nomDossier;

void fileSelected(File selection) {
  if (selection == null) {
    println("La fenêtre a été fermée ou l'utilisateur a abandonné.");
    exit();
    println("FINI");
  } else {
    println("User selected " + selection.getAbsolutePath());
    
    nomFichier = split(selection.getAbsolutePath(), '/');
    nomDossier = split(nomFichier[nomFichier.length-1],'.')[0];
    // fichier à charger
    json = loadJSONObject(selection.getAbsolutePath());
    
    //speed = json.getInt("speed");
    JSONArray dim = json.getJSONArray("dim");
    nLargeur = dim.getInt(0);
    nHauteur = dim.getInt(1);
    largeur = width/nLargeur;
    hauteur = height/nHauteur;
    datas = json.getJSONArray("datas");
    //println("datas:"+datas);
    //frameRate(speed);
    flag = true;
    //draw();
  }
}
void setup() {
  pixelDensity(2);
  //size(1080, 1920);
  size(540,960);
  selectInput("Choisissez un fichier d'anim:", "fileSelected");
}

void draw() {
  if (flag) {
    noStroke();
    background(255);
    imgEncours = new JSONArray();    //blocs = new JSONArray();
    int numBlocEncours = 0;    //println("numImg: "+numImg);
    try {
      imgEncours = datas.getJSONArray(numImg);
      aImgEncours = imgEncours.getIntArray();
      int indexBlocEncours = 0;
      for (int item:aImgEncours) {        //println(item);
        int y = int((item-1)/nLargeur);
        int x = (item-1)%nLargeur;        //println(x,y);
        fill(0);
        rect(x*largeur, y*hauteur, largeur, hauteur);
      }
      save(nomDossier+"/img-"+nf(numImg, 3)+".png");
      numImg++;
      println("sauvegarde de l'image N°"+nf(numImg, 3));
    } 
    catch (java.lang.RuntimeException e) {      //e.printStackTrace();
      exit();
      println("FINI");
    }
  }
}
