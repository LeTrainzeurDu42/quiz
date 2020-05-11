String globalScreen; // variable permettant de connaître l'écran actuel //<>// //<>// //<>// //<>// //<>//
int level = 1 ; // niveau maximal disponible pour le joueur
int niveauEnCours; // niveau en cours mis à jour en temps réel
int questionPosee; // question posée, mise à jour en temps réel
int step = 1; // étape d'affichage pour les questions particulières (changement d'affichage...)
int life; // nombre de vies restantes

int[] answersOrderQCM = {0, 1, 2, 3}; // ordre des indexs de réponses aux QCM pour l'affichage
int[] positionXReponsesQCM = {47, 687}; // positions sur X des images de réponse
int[] positionYReponsesQCM = {383, 590}; // positions sur Y des images de réponse
int largeurReponses = 546; // largeur des images de réponse
int hauteurReponses = 110; // hauteur des images de réponse

String pseudo; // pseudo non choisi par le joueur
int nameLength = 0; // longueur du pseudo tapé dans l'écran du pseudo
PFont fontClavier; // police pour tout ce qui sera tapé

String alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789éèêëàùç-_@¤ " ; // pour vérifier que les touches tapées ne sont pas des touches hors alphabet

// images
PImage background; // fond d'écran
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
PImage[][][] reponsesQCM = new PImage[2][5][4]; // réponses aux QCM
PImage[][][] reponsesQCMsurb = new PImage[2][5][4]; // réponses aux QCM en surbrillance
PImage fioleViolette; // fiole violette pour la question 1 du niveau 3
PImage[][] mauvaisesReponses = new PImage[3][5]; // écrans pour les réponses où l'on a perdu
PImage[][] bonnesReponses = new PImage[3][5]; // écrans pour les bonnes réponses avant de passer à la question suivante
PImage[] numerosQuestions = new PImage[5]; // numéros de question


// coordonnées des zones à cliquer pour la bonne réponse (niveaux 2 & 3 + dernière question niveau 1)
int minXbonneReponse;
int maxXbonneReponse;
int minYbonneReponse;
int maxYbonneReponse;


import ddf.minim.*; // importation de la librairie minim pour les sons
Minim minim; // déclaration de la variable de la librairie minim
AudioSnippet musiqueDeFond ; // musique du début du jeu (jusqu'à l'écran des niveaux)
AudioSnippet sonClic ; // son au clic
AudioSnippet musiqueNiveau1 ; // musique du niveau 1
AudioSnippet musiqueNiveau2 ; // musique du niveau 2
AudioSnippet musiqueNiveau3 ; // musique du niveau 3
AudioSnippet sonBonneReponse ; // son en cas de bonne réponse
AudioSnippet sonMauvaiseReponse ; // son en cas de mauvaise réponse
AudioSnippet winDuNiveau ; // musique en cas de victoire du joueur

String reponseEcrite = ""; // réponse écrite par le joueur
boolean ecrireLaReponse; // true si la réponse est à écrire, false sinon



void setup() {
  // fullScreen(); // à n'activer que si votre résolution est optimale (1280x800) pour passer en plein écran
  size(1280, 800); // taille du jeu : 1280x800 en fenêtré
  globalScreen="écran principal"; //initialisation de l'écran 

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
  level2PresentationSurb = loadImage("LevelsMenu/P2_surb.png");
  level3PresentationSurb = loadImage("LevelsMenu/P3_surb.png");
  noPresentation = loadImage("LevelsMenu/non_debloque.png");
  for (int i = 1; i <=3; i++) {
    for (int j = 1; j <=5; j++) {
      questionsImages[i-1][j-1] = loadImage("ImagesQR/P"+str(i)+"Q"+str(j)+".png"); // chargement de la question
      bonnesReponses[i-1][j-1] = loadImage("AnswersGood/P"+str(i)+"Q"+str(j)+".png"); // chargement de l'écran de bonne réponse
      mauvaisesReponses[i-1][j-1] = loadImage("AnswersBad/P"+str(i)+"Q"+str(j)+".png"); // chargement de l'écran de mauvaise réponse
    }
  }
  questions2level1[0] = loadImage("ImagesQR/P1Q2b.png");
  questions2level1[1] = loadImage("ImagesQR/P1Q2c.png");
  questionBackground = loadImage("question_default_background.png");
  reponseQCMBackground = loadImage("responses_default_backgrounds.png");
  for (int i = 0; i < 2; i++) { // chargement des images réponses QCM
    for (int j = 0; j < 5; j++) {
      if (!(j == 0 && i == 1)) { // seule question des deux derniers niveaux sans QCM
        for (int k = 0; k < 4; k++) {
          reponsesQCM[i][j][k] = loadImage("ImagesQR/P"+str(i+2)+"Q"+str(j+1)+"R"+str(k+1)+".png"); // sans surbrillance
          reponsesQCMsurb[i][j][k] = loadImage("ImagesQR-survol/P"+str(i+2)+"Q"+str(j+1)+"R"+str(k+1)+".png"); // avec surbrillance
        }
      }
    }
  }
  for (int i = 0; i < 5; i++) {
    numerosQuestions[i] = loadImage("QuestionNumbers/"+str(i+1)+".png"); // chargement des numéros de question
  }
  formQuestion = loadImage("input_answer.png");
  fioleViolette = loadImage("fiole_violette.png");

  fontClavier = createFont("fontPourClavier.ttf", 90); // chargement de la police pour ce qui sera tapé au clavier & pour l'affichage du pseudo

  // création d'un tableau pour générer un pseudo aléatire au joueur
  String [] listePseudo = {"The Rock", "Severus Rogue", "Sylvain Liaboeuf", "Chaise de bureau", "Boîte d'anchois", "Tractopelle", "Jul", "Stylo 4 couleurs", "David Pujadas", "XxDarkkillerdu42xX", "Julien Le Perce", "Calculatrice Casio", "Pangolin", "Sophie la Girafe", "Rocky Sifredo", "Barre d'espace", "Caméscope", "Tente Quechua"} ;
  int indexpseudo = int(random(listePseudo.length - 1)) ;
  pseudo = listePseudo[indexpseudo];

  // chargement de l'image pour l'écran de commentaire du pseudo
  if (indexpseudo <= 2) screenPseudo = loadImage("screen_after_nickname_2.png");
  else screenPseudo = loadImage("screen_after_nickname.png");

  // chargement des musiques et sons
  minim = new Minim(this);
  musiqueDeFond = minim.loadSnippet("Bruitages/musique de fond accueil.mp3") ;  
  sonClic = minim.loadSnippet("Bruitages/son du clic.mp3") ;
  musiqueNiveau1 = minim.loadSnippet("Bruitages/musique de fond niveau 1.mp3") ;
  musiqueNiveau2 = minim.loadSnippet("Bruitages/hymne sri lanka niveau 2.mp3") ;
  musiqueNiveau3 = minim.loadSnippet("Bruitages/musique de fond niveau 3.mp3") ;
  sonBonneReponse = minim.loadSnippet("Bruitages/son si bonne réponse.mp3") ;
  sonMauvaiseReponse = minim.loadSnippet("Bruitages/son si mauvaise réponse.mp3") ;
  winDuNiveau = minim.loadSnippet("Bruitages/son de win de niveau.mp3") ;
  // lancement de la première musique
  musiqueDeFond.rewind() ; // remise à 0
  musiqueDeFond.loop() ; // pour que la musique tourne en boucle
  musiqueDeFond.play() ; // lancement de la musique
}


void draw() {
  frameRate(60); // 60 images par secondes
  image(background, 0, 0); // affichage du fond
  if (globalScreen.equals("écran principal")) {
    ecranPrincipal() ; // affichage de l'écran principal
  } else if (globalScreen.equals("écran nom")) {
    ecranNom(); // affichage de l'écran pour le "choix" du pseudo
  } else if (globalScreen.equals("écran niveau")) {
    ecranNiveau(); // affichage de la liste des niveaux
  } else if (globalScreen.equals("question")) {
    question(); // affichage de la question
  } else if (globalScreen.equals("bonne réponse")) {
    bonneReponse(); // affichage de la transition pour une bonne réponse
  } else if (globalScreen.equals("mauvaise réponse")) {
    mauvaiseReponse(); // affichage de la transition si on a 0 vie
  } else if (globalScreen.equals("écran commentaire pseudo")) {
    commentairePseudo(); // affichage de l'écran qui commente le pseudo ironiquement
  }
}


void mouseClicked() {    // Cette fonction se déclenche au clic
  if (globalScreen.equals("écran principal")) {        // fonction qui vérifie le clic du bouton jouer
    if (mouseX> 318 && mouseX< 961 && mouseY> 396 && mouseY< 591) {
      globalScreen = "écran nom" ; // changement d'écran
    }
  } else if (globalScreen.equals("écran nom")) {        // fonction qui vérifie le clic du bouton valider 
    if (mouseX>367 && mouseX<367+545 && mouseY>549 && mouseY<549+110 && nameLength == pseudo.length()) {
      globalScreen = "écran commentaire pseudo" ;
    }
  } else if (globalScreen.equals("écran commentaire pseudo")) { // fonction qui permet le passage à l'écran niveau en cliquant n'importe où sur l'écran commentaire pseudo
    globalScreen = "écran niveau" ;
  } else if (globalScreen.equals("écran niveau")) { 
    if (mouseX> 40 && mouseX< 1220 && mouseY> 113 && mouseY< 290) {       // fonction qui vérifie le clic pour lancer le niveau 1 
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 1 ;
      life = 4 ;
      step = 1;
      pauseMusique() ; // Pause toutes les musiques de fond pouvant être en cours
      // lancement de la musique du niveau 1
      musiqueNiveau1.rewind() ;
      musiqueNiveau1.loop() ;
      musiqueNiveau1.play() ;
    }
    if (mouseX> 40 && mouseX< 1220 && mouseY> 332 && mouseY< 509 && level >= 2) {        // fonction qui vérifie le clic pour lancer le niveau 2
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 2 ;
      life = 3 ;
      pauseMusique() ; // Pause toutes les musiques de fond pouvant être en cours
      // lancement de la musique du niveau 2
      musiqueNiveau2.rewind() ;
      musiqueNiveau2.loop() ;
      musiqueNiveau2.play() ;
    }
    if (mouseX> 40 && mouseX< 1220 && mouseY> 551 && mouseY< 728 && level >= 3) {        // fonction qui vérifie le clic pour lancer le niveau 3
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 3 ;
      life = 2 ;
      pauseMusique() ; // Pause toutes les musiques de fond pouvant être en cours
      // lancement de la musique du niveau 3
      musiqueNiveau3.rewind() ;
      musiqueNiveau3.loop() ;
      musiqueNiveau3.play() ;
    }
  } else if (globalScreen.equals("question") && (niveauEnCours != 1 || questionPosee == 5 )) {        // fonction qui vérifie si la réponse sur laquelle on clic est la bonne
    if (mouseX > minXbonneReponse && mouseX < maxXbonneReponse && mouseY > minYbonneReponse && mouseY < maxYbonneReponse) {
      sonBonneReponse.rewind() ;
      sonBonneReponse.play() ;
      globalScreen = "bonne réponse" ;
      if (questionPosee == 5 && niveauEnCours == level) {
        pauseMusique() ; // Pause toutes les musiques de fond pouvant être en cours
        // lancement de la musique d'applaudissements
        winDuNiveau.rewind() ;
        winDuNiveau.play() ;
      }
    } else { // fonction qui permet de gérer le nombre de vies en cas de mauvaise réponse
      life-- ;
      // lancement du son de mauvaise réponse
      sonMauvaiseReponse.rewind() ;
      sonMauvaiseReponse.play () ;
      if ((life == 0) || (questionPosee == 5 && niveauEnCours == 3)) {  // permet de faire perdre le joueur à une question éliminatoire (la toute dernière) même si il lui reste des vies
        globalScreen = "mauvaise réponse" ;
      }
    }
  } else if (globalScreen.equals("question") && (niveauEnCours == 1 && questionPosee != 5)) { // fonction qui vérifie le clic du bouton valider pour les réponses écrites //<>//
    if (mouseX>367 && mouseX<367+545 && mouseY>549 && mouseY<549+110) { //<>//
      checkReponse() ; // vérifier si la réponse écrite est bonne
    }
  } else if (globalScreen.equals("bonne réponse")) {        // fonction qui gère le changement de question et de niveau en cas de bonne réponse 
    if (questionPosee == 5) {
      if (niveauEnCours == level) {
        level++ ; // incrémente le niveau maximal si ce dernier était celui en cours
      } 
      globalScreen = "écran niveau" ;
      pauseMusique() ; // Pause toutes les musiques de fond pouvant être en cours
      // lancement de la musique de l'écran principal
      musiqueDeFond.rewind() ;
      musiqueDeFond.loop() ;
      musiqueDeFond.play() ;
    } else { 
      globalScreen = "question" ;
      questionPosee++ ;
      answersOrderQCM = melanger(answersOrderQCM) ; // mélange l'ordre des réponses du QCM
    }
  } else if (globalScreen.equals("mauvaise réponse")) {
    globalScreen = "écran niveau" ;
    pauseMusique() ; // Pause toutes les musiques de fond pouvant être en cours
    // lancement de la musique de l'écran principal
    musiqueDeFond.rewind() ;
    musiqueDeFond.loop() ;
    musiqueDeFond.play() ;
  }
  // lancement du son de clic
  sonClic.rewind() ;
  sonClic.play() ;
}


// fonction appelée à chaque fois qu'une touche du clavier est appuyée
void keyTyped () { 
  if (globalScreen.equals("écran nom")) {
    if (nameLength < pseudo.length() && match(alphabet, str(key)) !=null ) { //fonction qui vérifie si le caractère taper est dans le tableau "alphabet"
      nameLength ++ ; // incrémente la longueur du pseudo affichée
    } else if (nameLength>0 && key == BACKSPACE) {
      nameLength -- ; // décrémente la longueur du pseudo affichée
    } else if (nameLength == pseudo.length() && key == ENTER) {
      globalScreen = "écran commentaire pseudo" ; // écran suivant
    }
  } else if (globalScreen.equals("question") && ecrireLaReponse == true) {     // fonction qui gère l'écriture des réponses
    if (match(alphabet, str(key)) !=null ) {
      reponseEcrite = reponseEcrite + str(key) ; // ajoute la lettre tapée à la fin
      if (questionPosee == 2) {
        // incrémente l'étape en cours si on est à la question 2 de la première partie
        if ((reponseEcrite.equals("2") && step == 1) || (reponseEcrite.equals("3") && step == 2) || (reponseEcrite.equals("4") && step == 3)) step++;
      }
    } else if (key == BACKSPACE && reponseEcrite.length() != 0) {
      reponseEcrite = reponseEcrite.substring(0, reponseEcrite.length()-1) ;
    } else if (key == ENTER) {
      checkReponse() ; // vérifie si la réponse écrite est bonne
    }
  }
}


void checkReponse() {      // fonction qui verifie si les réponses écrites sont juste pour passer à la suivante 
  if ((questionPosee == 1 && reponseEcrite.toLowerCase().equals("10x10")) || (questionPosee == 2 && reponseEcrite.toLowerCase().equals("2") && step == 4) || (questionPosee == 3 && reponseEcrite.toLowerCase().toLowerCase().equals(pseudo.toLowerCase())) || (questionPosee == 4 && reponseEcrite.toLowerCase().equals("4"))) {
    globalScreen = "bonne réponse" ;
    // lance le son de bonne réponse
    sonBonneReponse.rewind() ;
    sonBonneReponse.play() ;
  } else {      // fonction qui fait perdre une vie si la réponse écrite est fausse et perdre le niveau si le joueur n'a plus de vie
    life-- ; // décrémente le nombre de vies
    // lance le son de mauvaise réponse
    sonMauvaiseReponse.rewind() ;
    sonMauvaiseReponse.play () ;
    if (life == 0) {
      globalScreen = "mauvaise réponse" ;
    }
  }
  reponseEcrite = "";
}


void ecranPrincipal () { // fonction qui affiche l'écran principal
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

void ecranNom() { // fonction qui affiche l'écran de choix du pseudo
  image(formNom, 0, 0); // affiche le formulaire de "choix" du pseudo
  // coordonnées de la zone du bouton Valider :
  int minX = 367;
  int maxX = 367+545;
  int minY = 549;
  int maxY = 549+110;
  if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Valider
    image(boutonValiderSurb, 0, 0); //affiche le bouton valider en surbrillance
    cursor(HAND); // curseur en forme de main
  } else cursor(ARROW); // curseur en flèche
  if (nameLength>0) { // afficher le texte
    textSize(90); // taille du texte
    textAlign(CENTER); // alignement centré
    fill(#000000); // couleur noire
    text(pseudo.substring(0, nameLength), 640, 465); // affichage du pseudo
  }
}

void ecranNiveau() { // affiche l'écran avec la liste des niveaux
  image(bgLevels, 0, 0); // arrière plan
  boolean mouseOnALevel = false; // initialisation de la variable pour savoir si la souris est en forme de main ou pas

  if (mouseX > 40 && mouseX < 1220 && mouseY > 113 && mouseY < 290) {
    image(level1PresentationSurb, 0, 92); // image en surbrillance
    mouseOnALevel = true; // va passer la souris en main
  } else {
    image(level1Presentation, 0, 92); // image normale
  }

  if (level < 2) {
    image(noPresentation, 0, 311);
  } else if (mouseX > 40 && mouseX < 1220 && mouseY > 332 && mouseY < 509) {
    image(level2PresentationSurb, 0, 311);
    mouseOnALevel = true;
  } else {
    image(level2Presentation, 0, 311);
  }

  if (level < 3) {
    image(noPresentation, 0, 530);
  } else if (mouseX > 40 && mouseX < 1220 && mouseY > 551 && mouseY < 728) {
    image(level3PresentationSurb, 0, 530);
    mouseOnALevel = true;
  } else {
    image(level3Presentation, 0, 530);
  }
  if (mouseOnALevel == true) cursor(HAND);
  else cursor(ARROW);
}

void commentairePseudo() { // affiche le commentaire sur le pseudo "choisi"
  image(screenPseudo, 0, 0); // commentaire
  // affichage du pseudo
  textSize(90);
  textAlign(CENTER);
  fill(#000000);
  text(pseudo, 640, 340);
}

void question() { // affiche l'écran d'affichage de la question
  image(questionBackground, 0, 0); // arrière plan intitulé question

  if (!(niveauEnCours == 1 && questionPosee == 4)) image(numerosQuestions[questionPosee-1], 0, 0); // affichage numéro question (sauf Q4 niveau 1)

  // affichage des réponses 
  if (niveauEnCours == 2 || (niveauEnCours == 3 && questionPosee != 1)) propositionsQCM(); // affichage des propositions QCM normales
  else if (niveauEnCours == 1 && questionPosee != 5) reponseAEcrire(); // affichage de l'interface d'écritur
  else if (niveauEnCours == 1 && questionPosee == 5) question5niveau1(); // affichage du niveau concerné (numéro question)
  else if (niveauEnCours == 3 && questionPosee == 1) question1niveau3(); // (fiole violette)

  // affichage de la question
  if (questionPosee != 2 || niveauEnCours != 1 || step == 1) {
    image(questionsImages[niveauEnCours - 1][questionPosee - 1], 178, 47); // affichage de l'intitulé : - 1 car la numérotation des questions/niveaux démarre à 1, celle des tableaux à 0
  } else { // cas particulier de la question 2
    if (step == 2) image(questions2level1[0], 178, 47);
    else if (step == 3) image(questions2level1[1], 178, 47);
    else image(questionsImages[niveauEnCours - 1][questionPosee - 1], 178, 47);
  }
}

void reponseAEcrire() { // pour toutes les questions du niveau 1 (sauf 5)
  ecrireLaReponse = true;
  image(formQuestion, 0, 0); // écran pour écrire
  // coordonnées de la zone du bouton Valider :
  int minX = 367;
  int maxX = 367+545;
  int minY = 549;
  int maxY = 549+110;
  if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Valider
    image(boutonValiderSurb, 0, 0); //affiche le bouton valider en surbrillance
    cursor(HAND);
  } else cursor(ARROW);
  if (reponseEcrite.length()>0) {
    // affichage de la réponse écrite
    textSize(90);
    textAlign(CENTER);
    fill(#000000);
    text(reponseEcrite, 640, 465);
  }
}

void propositionsQCM() { // affichage des propositions du QCM
  image(reponseQCMBackground, 0, 0); // arrière plan pour les réponses
  boolean mouseOnAChoice = false;
  for (int i = 0; i < 4; i++) { // affichage des réponses
    if (mouseX > positionXReponsesQCM[i <= 1 ? 0 : 1] && mouseX < positionXReponsesQCM[i <= 1 ? 0 : 1] + largeurReponses && mouseY > positionYReponsesQCM[i <= 1 ? i : i - 2] && mouseY < positionYReponsesQCM[i <= 1 ? i : i - 2] + hauteurReponses) {
      image(reponsesQCMsurb[niveauEnCours-2][questionPosee-1][answersOrderQCM[i]], positionXReponsesQCM[i <= 1 ? 0 : 1], positionYReponsesQCM[i <= 1 ? i : i - 2]);
      mouseOnAChoice = true;
    } else {
      image(reponsesQCM[niveauEnCours-2][questionPosee-1][answersOrderQCM[i]], positionXReponsesQCM[i <= 1 ? 0 : 1], positionYReponsesQCM[i <= 1 ? i : i - 2]);
    }
    if (answersOrderQCM[i] == 0) {
      minXbonneReponse = positionXReponsesQCM[i <= 1 ? 0 : 1];
      maxXbonneReponse = positionXReponsesQCM[i <= 1 ? 0 : 1] + largeurReponses;
      minYbonneReponse = positionYReponsesQCM[i <= 1 ? i : i - 2];
      maxYbonneReponse = positionYReponsesQCM[i <= 1 ? i : i - 2] + hauteurReponses;
    }
  }
  if (mouseOnAChoice == true) cursor(HAND);
  else cursor(ARROW);
}


int[] melanger(int[]arr) { // mélange un tableau d'entiers
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


void question5niveau1() { // pour la question 5 du niveau 1
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

void question1niveau3() { // pour afficher la question 1 du niveau 3
  image(fioleViolette, 665, 536); // affiche la fiole violette

  // attribue les coordonnées de la zone de bonne réponse
  minXbonneReponse = 665;
  maxXbonneReponse = 761;
  minYbonneReponse = 536;
  maxYbonneReponse = 630;

  if (mouseX>minXbonneReponse && mouseX<maxXbonneReponse && mouseY >minYbonneReponse && mouseY <maxYbonneReponse) { // vérifie si la souris pointe bien sur la fiole
    cursor(HAND); // curseur en forme de main
  }
}

void bonneReponse() { // affiche l'écran de bonne réponse
  image(bonnesReponses[niveauEnCours - 1][questionPosee - 1], 0, 0);
  cursor(HAND);
}

void mauvaiseReponse() { // affiche l'écran de mauvaise réponse
  image(mauvaisesReponses[niveauEnCours - 1][questionPosee - 1], 0, 0);
  cursor(HAND);
}

void pauseMusique() { // pour mettre en pause la musique
  // pour chaque musique de fond on regarde si elle est en train de se jouer et on la met en pause
  if (musiqueDeFond.isPlaying()) musiqueDeFond.pause() ;
  if (musiqueNiveau1.isPlaying()) musiqueNiveau1.pause() ;
  if (musiqueNiveau2.isPlaying()) musiqueNiveau2.pause() ;
  if (musiqueNiveau3.isPlaying()) musiqueNiveau3.pause() ;
  if (winDuNiveau.isPlaying()) winDuNiveau.pause() ;
}
