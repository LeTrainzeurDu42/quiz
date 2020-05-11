String globalScreen; // variable permettant de connaître l'écran actuel //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
int level = 1 ; //niveau maximal disponible pour le joueur
int niveauEnCours;
int questionPosee;
int step = 1; // étape d'affichage pour les questions particulières (changement d'affichage...)
int life;
int[] answersOrderQCM = {0, 1, 2, 3}; // ordre des indexs de réponses aux QCM pour l'affichage
int[] positionXReponsesQCM = {47, 687};
int[] positionYReponsesQCM = {383, 590};
int largeurReponses = 546; // X
int hauteurReponses = 110; // Y

String pseudo;//faire déclaration des pseudo (variable "pseudo") avec random (faire tableau avec liste pseudo puis créer string pseudo pour en choisir un aléatoire (nom tableau[random(tableau.length)]))))
int nameLength = 0; // longueur du pseudo tapé dans l'écran du pseudo
PFont fontClavier; //police pour tout ce qui sera tapé

String alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789éèêëàùç-_@*¤ " ;

// images principales
PImage background; //fond d'écran
PImage principalScreen; // écran principal
PImage boutonJouer; // bouton Jouer de l'écran principal
PImage boutonJouerSurb; // bouton Jouer en surbrillance
PImage formNom; // écran où l'on rentre le pseudo
PImage boutonValiderSurb; // bouton valider de l'écran du pseudo
PImage bgLevels; // deuxième fond qui se superposera au premier dans l'écran des niveaux
PImage level1Presentation; // présentation du niveau 1 en rouge sur l'écran des niveaux
PImage level1PresentationSurb; // présentation du niveau 1 en rouge sur l'écran des niveaux en surbrillance
PImage level2Presentation; // présentation du niveau 2 en rouge sur l'écran des niveaux
PImage level2PresentationSurb; // présentation du niveau 2 en rouge sur l'écran des niveaux en surbrillance
PImage level3Presentation; // présentation du niveau 3 en rouge sur l'écran des niveaux
PImage level3PresentationSurb; // présentation du niveau 3 en rouge sur l'écran des niveaux en surbrillance
PImage noPresentation; // niveau non débloqué sur l'écran des niveaux
PImage screenPseudo; // écran pour commenter le pseudo non choisi par le joueur
PImage[][] questionsImages = new PImage[3][5]; // tableau de tableaux qui contiendra les images des questions
PImage[] questions2level1 = new PImage[2]; // tableau contenant les différents intitulés de la question 2, niveau 1 (hormis la première affichée)
PImage questionBackground; // arrière plan des questions par défaut
PImage reponseQCMBackground; // arrière plan des réponses aux QCM
PImage formQuestion; // case pour écrire les réponses au clavier
PImage[][][] reponsesQCM = new PImage[2][5][4];
PImage[][][] reponsesQCMsurb = new PImage[2][5][4];


import ddf.minim.*;
Minim minim;
AudioSnippet musiqueDeFond ;
AudioSnippet sonClic ;
AudioSnippet musiqueNiveau1 ;
AudioSnippet musiqueNiveau2 ;
AudioSnippet musiqueNiveau3 ;
AudioSnippet sonBonneReponse ;
AudioSnippet sonMauvaiseReponse ;
AudioSnippet winDuNiveau ;


int minXbonneReponse;
int maxXbonneReponse;
int minYbonneReponse;
int maxYbonneReponse;

String reponseEcrite = ""; // réponse écrite par le joueur
boolean reponseAEcrire; // true si la réponse est à écrire, false sinon



void setup() {
  size(1280, 800); // taille du jeu : 1280x800
  globalScreen="écran niveau"; //initialisation de l'écran 

  // Chargement des images
  background = loadImage("background_global.png"); 
  principalScreen =  loadImage("background_home.png"); 
  formNom = loadImage("name_screen.png");
  boutonJouer = loadImage("bouton_jouer.png");
  boutonJouerSurb = loadImage("bouton_jouer_surb.png");
  boutonValiderSurb = loadImage("name_screen_green_button.png");
  bgLevels = loadImage("level_screen_bg2.png");
  level1Presentation = loadImage("LevelsMenu/P1_red.png");
  level2Presentation = loadImage("LevelsMenu/P2_red.png");
  level3Presentation = loadImage("LevelsMenu/P3_red.png");
  level1PresentationSurb = loadImage("LevelsMenu/P1_surb.png");
  level2PresentationSurb = loadImage("LevelsMenu/P1_surb.png");
  level3PresentationSurb = loadImage("LevelsMenu/P1_surb.png");
  noPresentation = loadImage("LevelsMenu/non_debloque.png");
  for (int i = 1; i <=3; i++) {
    for (int j = 1; j <=5; j++) {
      questionsImages[i-1][j-1] = loadImage("ImagesQR/P"+str(i)+"Q"+str(j)+".png");
    }
  }
  questions2level1[0] = loadImage("ImagesQR/P1Q2b.png");
  questions2level1[1] = loadImage("ImagesQR/P1Q2c.png");
  questionBackground = loadImage("question_default_background.png");
  reponseQCMBackground = loadImage("responses_default_backgrounds.png");
  for (int i = 0; i < 2; i++) { // chargement des images réponses QCM
    for (int j = 0; j < 5; j++) {
      if (j != 0 && i != 1) { // seule question des deux derniers niveaux sans QCM
        for (int k = 0; k < 4; k++) {
          reponsesQCM[i][j][k] = loadImage("ImagesQR/P"+str(i+2)+"Q"+str(j+1)+"R"+str(k+1)+".png");
        }
      }
    }
  }
  for (int i = 0; i < 2; i++) { // chargement des images réponses QCM en surbrillance
    for (int j = 0; j < 5; j++) {
      if (j != 0 && i != 1) { // seule question des deux derniers niveaux sans QCM
        for (int k = 0; k < 4; k++) {
          reponsesQCMsurb[i][j][k] = loadImage("ImagesQR-survol/P"+str(i+2)+"Q"+str(j+1)+"R"+str(k+1)+".png");
        }
      }
    }
  }

  fontClavier = createFont("fontPourClavier.ttf", 90); // chargement de la police pour ce qui sera tapé au clavier & pour l'affichage du pseudo

  // création d'un tableau pour générer un pseudo aléatire au joueur (déplacé dans le setup)
  String [] listePseudo = {"The Rock", "Severus Rogue", "Sylvain Liaboeuf", "Chaise de bureau", "Boîte d'anchois", "Tractopelle", "Jul", "Stylo 4 couleurs", "David Pujadas", "XxDarkkillerdu42xX", "Julien Le Perce", "Calculatrice Casio", "Pangolin", "Sophie la Girafe", "Rocky Sifredo", "Barre d'espace", "Caméscope", "Tente Quechua"} ;
  int indexpseudo = int(random(listePseudo.length - 1)) ;
  pseudo = listePseudo[indexpseudo];

  // chargement de l'image pour l'écran de commentaire du pseudo
  if (indexpseudo <= 2) screenPseudo = loadImage("screen_after_nickname_2.png");
  else screenPseudo = loadImage("screen_after_nickname.png");
minim = new Minim(this);
musiqueDeFond = minim.loadSnippet("musique de fond accueil.mp3") ;  
sonClic = minim.loadSnippet("son du clic.mp3") ;
musiqueNiveau1 = minim.loadSnippet("musique de fond niveau 1.mp3") ;
musiqueNiveau2 = minim.loadSnippet("hymne sri lanka niveau 2.mp3") ;
musiqueNiveau3 = minim.loadSnippet("musique de fond niveau 3.mp3") ;
sonBonneReponse = minim.loadSnippet("son si bonne réponse.mp3") ;
sonMauvaiseReponse = minim.loadSnippet("son si mauvaise réponse.wav") ;
winDuNiveau = minim.loadSnippet("son de win de niveau.wav") ;
musiqueDeFond.rewind() ;
musiqueDeFond.loop() ;
musiqueDeFond.play() ;
}



void draw() {
  frameRate(60);
  image(background, 0, 0);
  if (globalScreen == "écran principal") {
    ecranPrincipal() ;
  } else if (globalScreen == "écran nom") {
    ecranNom();
  } else if (globalScreen == "écran niveau") {
    ecranNiveau();
  } else if (globalScreen == "question") {
    question();
  } else if (globalScreen == "bonne réponse") {
 //   bonneReponse();
  } else if (globalScreen == "mauvaise réponse") {
   // mauvaiseReponse();
  } else if (globalScreen == "écran commentaire pseudo") {
    commentairePseudo();
  }
}


void mouseClicked() {    
  if (globalScreen == "écran principal") {        // fonction qui vérifie le clic du bouton jouer
    if (mouseX> 318 && mouseX< 961 && mouseY> 396 && mouseY< 591) {
      globalScreen = "écran nom" ;
    }
  }
  if (globalScreen == "écran nom") {        //fonction qui vérifie le clic du bouton valider 
    if (mouseX>367 && mouseX<367+545 && mouseY>549 && mouseY<549+110) {
      globalScreen = "écran commentaire pseudo" ;
    }
  }
  if (globalScreen == "écran commentaire pseudo") {        //fonction qui permet le passage à l'écran niveau en claiquant n'importe ou sur l'écran commentaire pseudo
    globalScreen = "écran niveau" ;
  }
  if (globalScreen == "écran niveau") { 
    if (mouseX> 40 && mouseX< 1220 && mouseY> 113 && mouseY< 290) {       // fonction qui vérifie le clic pour lancer le niveau 1 
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 1 ;
      life = 4 ;
      pauseMusique() ;
      musiqueNiveau1.rewind() ;
      musiqueNiveau1.loop() ;
      musiqueNiveau1.play() ;
    }
    if (mouseX> 40 && mouseX< 1220 && mouseY> 332 && mouseY< 509) {        // fonction qui vérifie le clic pour lancer le niveau 2
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 2 ;
      life = 3 ;
      pauseMusique() ;
      musiqueNiveau2.rewind() ;
      musiqueNiveau2.loop() ;
      musiqueNiveau2.play() ;
    }
    if (mouseX> 40 && mouseX< 1220 && mouseY> 551 && mouseY< 728) {        // fonction qui vérifie le clic pour lancer le niveau 3
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 3 ;
      life = 2 ;
      pauseMusique() ;
      musiqueNiveau3.rewind() ;
      musiqueNiveau3.loop() ;
      musiqueNiveau3.play() ;
    }
  }
  if (globalScreen == "question" && (niveauEnCours != 1 || questionPosee == 5 )) {        // fonction qui vérifie si la réponse sur laquelle on clic est la bonne
    if (mouseX > minXbonneReponse && mouseX < maxXbonneReponse && mouseY > minYbonneReponse && mouseY < maxYbonneReponse) {
      sonBonneReponse.rewind() ;
      sonBonneReponse.play() ;
      globalScreen = "bonne réponse" ;
    } else {        // fonction qui permet de gérer le nombre de vie en cas de mauvaise réponse
      life-- ;
      if ((life == 0) || (questionPosee == 5 && niveauEnCours == 3)) {         //permet de faire perdre le joueur à une question éliminatoire même si il lui reste des vies
          sonMauvaiseReponse.rewind() ;
          sonMauvaiseReponse.play() ;
          globalScreen = "mauvaise réponse" ;
        }
      }
    }
  if (globalScreen == "question" && (niveauEnCours == 1 && questionPosee != 5)) {        // fonction qui vérifie le clic du bouton valider pour les réponses écrites
    if (mouseX>367 && mouseX<367+545 && mouseY>549 && mouseY<549+110) {
      checkReponse() ;
    }
  }
  if (globalScreen == "bonne réponse") {        // fonction qui gère le changement de question et de niveau en cas de bonne réponse 
    if (questionPosee == 5) {
      if (niveauEnCours == level) {
        pauseMusique() ;
        winDuNiveau.rewind() ;
        winDuNiveau.play() ;
        level++ ;
      } 
      globalScreen = "écran niveau" ;
      pauseMusique() ;
      musiqueDeFond.rewind() ;
      musiqueDeFond.loop() ;
      musiqueDeFond.play() ;
    } else { 
      globalScreen = "question" ;
      questionPosee++ ;
      answersOrderQCM = melanger(answersOrderQCM) ;
    }
  }
  if (globalScreen == "mauvaise réponse") {
      globalScreen = "écran niveau" ;
      pauseMusique() ;
      musiqueDeFond.rewind() ;
      musiqueDeFond.loop() ;
      musiqueDeFond.play() ;
    }
    sonClic.rewind() ;
    sonClic.play() ;
  }





void keyTyped () { 
  if (globalScreen == "écran nom") {
    if (nameLength < pseudo.length() && match(alphabet, str(key)) !=null ) { //fonction qui vérifie si le caractère taper est dans le tableau "alphabet"
      nameLength ++ ;
    } else if (nameLength>0 && key == RETURN) {
      nameLength -- ;
    } else if (nameLength == pseudo.length() && key == ENTER) {
      globalScreen = "écran commentaire pseudo" ;
    }
  }
  if (globalScreen == "question" && reponseAEcrire == true) {        // fonction qui gère l'écriture des réponses
    if (match(alphabet, str(key)) !=null ) {
      reponseEcrite = reponseEcrite + str(key) ;
    } else if (key == RETURN && reponseEcrite.length() != 0) {
      reponseEcrite = reponseEcrite.substring(0, reponseEcrite.length()-1) ;
    } else if (key == ENTER) {
      checkReponse() ;
    }
  }
}


void checkReponse() {      // fonction qui verifie si les réponses écrites sont juste pour passer à la suivante 
  if ((questionPosee == 1 && reponseEcrite == "10*10") || (questionPosee == 2 && reponseEcrite == "2" && step == 4) || (questionPosee == 3 && reponseEcrite.toLowerCase() == pseudo.toLowerCase()) || (questionPosee == 4 && reponseEcrite == "4")) {
    globalScreen = "bonne réponse" ;
    sonBonneReponse.rewind() ;
    sonBonneReponse.play() ;
  } else {      // fonction qui fait perdre une vie si la réponse écrite est fausse et perdre le niveau si le joueur n'a plus de vie
    life-- ; 
    if (life == 0) {
      globalScreen = "mauvaise réponse" ;
      sonMauvaiseReponse.rewind() ;
      sonMauvaiseReponse.play () ;
    }
  }
}


void ecranPrincipal () {
  image(principalScreen, 0, 0); // affiche le fond d'écran menu
  // coordonnées de la zone du bouton Jouer :
  int minX = 318;
  int maxX = 961;
  int minY = 396;
  int maxY = 591;
  if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Jouer
    image(boutonJouerSurb, 0, 0); //sélectionne le bouton en surbrillance
    cursor(HAND); // curseur en forme de main
  } else {
    image(boutonJouer, 0, 0); // bouton normal
    cursor(ARROW); // curseur normal (flèche)
  }
}

void ecranNom() {
  image(formNom, 0, 0);
  // coordonnées de la zone du bouton Valider :
  int minX = 367;
  int maxX = 367+545;
  int minY = 549;
  int maxY = 549+110;
  if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Valider
    image(boutonValiderSurb, 0, 0); //affiche le bouton valider en surbrillance
  }
  if (nameLength>0) {
    textSize(90);
    textAlign(CENTER);
    fill(#000000);
    text(pseudo.substring(0, nameLength), 640, 465);
  }
  // (MELINA => UTILISER UNE FONCTION KEYTYPED QUI PERMET D'INCREMENTER LA VARIABLE "nameLength" 
  //  POUR POUVOIR AFFICHER LE NOM (ou décrémenter en effacant) = cf https://processing.org/reference/keyTyped_.html pour la doc sur la fonction keyTyped) (en cours)
}



void ecranNiveau() {
  image(bgLevels, 0, 0);
  if (mouseX > 40 && mouseX < 1220 && mouseY > 113 && mouseY < 290) {
    image(level1PresentationSurb, 0, 92);
  } else {
    image(level1Presentation, 0, 92);
  }

  if (level < 2) {
    image(noPresentation, 0, 311);
  } else if (mouseX > 40 && mouseX < 1220 && mouseY > 332 && mouseY < 509) {
    image(level2PresentationSurb, 0, 311);
  } else {
    image(level2Presentation, 0, 311);
  }

  if (level < 3) {
    image(noPresentation, 0, 530);
  } else if (mouseX > 40 && mouseX < 1220 && mouseY > 551 && mouseY < 728) {
    image(level3PresentationSurb, 0, 530);
  } else {
    image(level3Presentation, 0, 530);
  }
}

void commentairePseudo() {
  image(screenPseudo, 0, 0); 
  textSize(90);
  textAlign(CENTER);
  fill(#000000);
  text(pseudo, 640, 340);
}

void question() {
  image(questionBackground, 0, 0);

  // !! affichage numéros de question !!

  // affichage de la question
  if (questionPosee != 2 || niveauEnCours != 1 || step == 1) {
    image(questionsImages[niveauEnCours - 1][questionPosee - 1], 178, 47); // affichage de l'intitulé : - 1 car la numérotation des questions/niveaux démarre à 1, celle des tableaux à 0
  } else { // cas particulier de la question 2
    if (step == 2) image(questions2level1[1], 178, 47);
    else if (step == 3) image(questions2level1[2], 178, 47);
    else image(questionsImages[niveauEnCours - 1][questionPosee - 1], 178, 47);
  }

  // affichage des réponses 
  if (niveauEnCours == 2 || (niveauEnCours == 3 && questionPosee != 1)) propositionsQCM(); // affichage des propositions QCM normales
  else if (niveauEnCours == 1 && questionPosee != 5) reponseAEcrire(); // affichage de l'interface d'écriture
  else if (niveauEnCours == 1 && questionPosee == 5) question5niveau1(); // affichage du niveau concerné (numéro question)
 // else if (niveauEnCours == 3 && questionPosee == 1) question1niveau3(); // (fiole violette)
}

void reponseAEcrire() { // pour toutes les questions du niveau 1 (sauf 5)
  image(formQuestion, 0, 0); // écran pour écrire
  // coordonnées de la zone du bouton Valider :
  int minX = 367;
  int maxX = 367+545;
  int minY = 549;
  int maxY = 549+110;
  if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Valider
    image(boutonValiderSurb, 0, 0); //affiche le bouton valider en surbrillance
  }
  if (reponseEcrite.length()>0) {
    textSize(90);
    textAlign(CENTER);
    fill(#000000);
    text(reponseEcrite, 640, 465);
  }
}

void propositionsQCM() {
  for (int i = 0; i < 4; i++) {
    if (mouseX > positionXReponsesQCM[i < 1 ? i : i - 2] && mouseX < positionXReponsesQCM[i < 1 ? i : i - 2] + largeurReponses && mouseY > positionYReponsesQCM[i < 1 ? i : i - 2] && mouseY < positionYReponsesQCM[i < 1 ? i : i - 2] + hauteurReponses) {
      image(reponsesQCMsurb[niveauEnCours-2][questionPosee-1][answersOrderQCM[i]], positionXReponsesQCM[i < 1 ? i : i - 2], positionYReponsesQCM[i < 1 ? i : i - 2]);
      cursor(HAND);
    } else {
      image(reponsesQCM[niveauEnCours-2][questionPosee-1][answersOrderQCM[i]], positionXReponsesQCM[i < 1 ? i : i - 2], positionYReponsesQCM[i < 1 ? i : i - 2]);
      cursor(ARROW);
    }
    if (answersOrderQCM[i] == 0) {
      minXbonneReponse = positionXReponsesQCM[i < 1 ? i : i - 2];
      maxXbonneReponse = positionXReponsesQCM[i < 1 ? i : i - 2] + largeurReponses;
      minYbonneReponse = positionYReponsesQCM[i < 1 ? i : i - 2];
      maxYbonneReponse = positionYReponsesQCM[i < 1 ? i : i - 2] + hauteurReponses;
    }
  }
}


int[] melanger(int[]arr) { // mélange un array d'entiers
        int valeurARemplacer;
        int index;
        for (int i = 0; i < arr.length; i++) {
          index  = (int)random(arr.length); // prendre un nouvel index au hasard
          valeurARemplacer = arr[i]; // stocke l'ancienne valeur à échanger
          arr[i] = arr[index]; // échange les 2 valeurs
          arr[index] = valeurARemplacer;
        }
        return arr;
      }

void question5niveau1() {
  image(formQuestion, 0, 0); // écran pour écrire mais non utilisable
  // coordonnées de la zone du bouton Valider :
  int minX = 367;
  int maxX = 367+545;
  int minY = 549;
  int maxY = 549+110;

  minXbonneReponse = 70;
  maxXbonneReponse = 100;
  minYbonneReponse = 80;
  maxYbonneReponse = 140;
  if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Valider
    image(boutonValiderSurb, 0, 0); //affiche le bouton valider en surbrillance
    cursor(HAND);
  } else if (mouseX>minXbonneReponse && mouseX<maxXbonneReponse && mouseY >minYbonneReponse && mouseY <maxYbonneReponse) { // vérifie si la souris pointe bien sur la question
    cursor(HAND);
  } else cursor(ARROW);
}

void pauseMusique() {
  if (musiqueDeFond.isPlaying()) musiqueDeFond.pause() ;
  if (musiqueNiveau1.isPlaying()) musiqueNiveau1.pause() ;
  if (musiqueNiveau2.isPlaying()) musiqueNiveau2.pause() ;
  if (musiqueNiveau3.isPlaying()) musiqueNiveau3.pause() ;
  if (winDuNiveau.isPlaying()) winDuNiveau.pause() ;
}
