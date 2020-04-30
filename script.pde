String globalScreen; // variable permettant de connaître l'écran actuel
int level = 1 ; //niveau maximal disponible pour le joueur
int niveauEnCours;
int questionPosee;
int step = 1; // étape d'affichage pour les questions particulières (changement d'affichage...)
int life;


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

int minXbonneReponse;
int maxXbonneReponse;
int minYbonneReponse;
int maxYbonneReponse;

String reponseEcrite; // réponse écrite par le joueur
boolean reponseAEcrire; // true si la réponse est à écrire, false sinon



void setup() {
 size(1280, 800); // taille du jeu : 1280x800
 globalScreen="écran niveaux"; //initialisation de l'écran 
 
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
     questionsImages[i-1][j-1] = loadImage("ImagesQR/P"+str(i-1)+"Q"+str(j-1));
   }
 }
 questions2level1[0] = loadImage("ImagesQR/P1Q2b.png");
 questions2level1[1] = loadImage("ImagesQR/P1Q2c.png");
 questionBackground = loadImage("question_default_background.png");
 reponseQCMBackground = loadImage("responses_default_backgrounds.png");
 
 fontClavier = createFont("fontPourClavier.ttf", 90); // chargement de la police pour ce qui sera tapé au clavier & pour l'affichage du pseudo
 
 // création d'un tableau pour générer un pseudo aléatire au joueur (déplacé dans le setup)
  String [] listePseudo = {"The Rock" , "Severus Rogue" , "Sylvain Liaboeuf" , "Chaise de bureau" , "Boîte d'anchois" , "Tractopelle" , "Jul" , "Stylo 4 couleurs" , "David Pujadas" , "XxDarkkillerdu42xX" , "Julien Le Perce" , "Calculatrice Casio" , "Pangolin" , "Sophie la Girafe" , "Rocky Sifredo" , "Barre d'espace" , "Caméscope" , "Tente Quechua"} ;
  int indexpseudo = int(random(listePseudo.length - 1)) ;
  pseudo = listePseudo[indexpseudo];
  
  // chargement de l'image pour l'écran de commentaire du pseudo
  if (indexpseudo <= 2) screenPseudo = loadImage("screen_after_nickname_2.png");
  else screenPseudo = loadImage("screen_after_nickname.png");
}


void draw(){
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
    bonneReponse(); 
  } else if (globalScreen == "mauvaise réponse") {
    mauvaiseReponse();
  } else if (globalScreen == "écran commentaire pseudo") {
    commentairePseudo();  
  }
}


void mouseClicked() {     // fonction qui verifie le clic du bouton valider
   if (globalScreen == "écran principal") {
       if (mouseX>367 && mouseX<367+545 && mouseY>549 && mouseY<549+110) { 
           globalScreen = "écran nom" ; 
      }
   }     
  if (globalScreen == "écran niveau") {
    if (mouseX> 40 && mouseX< 1220 && mouseY> 113 && mouseY< 290) {
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 1 ;
      life = 4 ;
    }
    if (mouseX> 40 && mouseX< 1220 && mouseY> 332 && mouseY< 509) {
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 2 ;
      life = 3 ;
    }
     if (mouseX> 40 && mouseX< 1220 && mouseY> 551 && mouseY< 728) {
      globalScreen = "question" ;
      questionPosee = 1 ;
      niveauEnCours = 3 ;
      life = 2 ;
    }
  }
  if (globalScreen == "question" && (niveauEnCours != 1 || questionPosee == 5 )) {
    if (mouseX > minXbonneReponse && mouseX < maxXbonneReponse && mouseY > minYbonneReponse && mouseY < maxYbonneReponse) {
      globalScreen = "bonne réponse" ;
    } else {
      life-- ;
      if (life == 0) {
        globalScreen = "mauvaise réponse" ;
      }
    }
  }
  if (globalScreen == "bonne réponse") {
    if (questionPosee == 5) {
      if (niveauEnCours == level) {
        level++ ;
      } 
      globalScreen = "écran niveau" ;
    } else { 
      globalScreen = "question" ;
      questionPosee++ ;
    }
  }
}
  
  



void keyTyped () { 
     if (globalScreen == "écran nom")  {
     if (nameLength < pseudo.length() && match(alphabet , str(key)) !=null ) { //fonction qui vérifie si le caractère taper est dans le tableau "alphabet"
       nameLength ++ ; 
     } 
     else if (nameLength>0 && key == RETURN) {
          nameLength -- ;
     } 
     else if (nameLength == pseudo.length() && key == ENTER) {
         globalScreen = "écran commentaire pseudo" ; 
        }
    }
    if (globalScreen == "question" && reponseAEcrire == true) {
      if (match(alphabet , str(key)) !=null ) {
        reponseEcrite = reponseEcrite + str(key) ;
      } else if (key == RETURN && reponseEcrite.length() != 0) {
        reponseEcrite = reponseEcrite.substring(0,reponseEcrite.length()-1) ;
      } else if (key == ENTER) {
        checkReponse() ;    
    }
  }
}
  

void checkReponse() {
  if ((questionPosee == 1 && reponseEcrite == "10*10") || (questionPosee == 2 && reponseEcrite == "2" && step == 4) || (questionPosee == 3 && reponseEcrite.toLowerCase() == pseudo.toLowerCase()) || (questionPosee == 4 && reponseEcrite == "4")) {
      globalScreen = "bonne réponse" ;
  } else {
    life-- ; 
      if (life == 0) {
        globalScreen = "mauvaise réponse" ;
     }
  }
}


void ecranPrincipal () {
   image(principalScreen, 0, 0); // affiche le fond d'écran menu
   // coordonnées de la zone du bouton Jouer :
   int minX = 318;
   int maxX = 318+643;
   int minY = 396;
   int maxY = 396+165;
   if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Jouer
     image(boutonJouerSurb, 0, 0); //sélectionne le bouton en surbrillance
     cursor(HAND); // curseur en forme de main
     // MELINA : CREER UNE FONCTION "verifierClic" DETECTANT LE CLIC ET QUI CHANGE LA VARIABLE "globalScreen" EN CONSEQUENCE
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
    image(questionsImages[niveauEnCours - 1][questionPosee - 1], 178,47); // affichage de l'intitulé : - 1 car la numérotation des questions/niveaux démarre à 1, celle des tableaux à 0
    
  } else { // cas particulier de la question 2
    if (step == 2) image(questions2level1[1], 178,47);
    else if (step == 3) image(questions2level1[2],178,47);
    else image(questionsImages[niveauEnCours - 1][questionPosee - 1],178,47);
  }
  
  // affichage des réponses 
  if (niveauEnCours == 2 || (niveauEnCours == 3 && questionPosee != 1)) propositionsQCM(); // affichage des propositions QCM normales
  else if (niveauEnCours == 1 && questionPosee != 5) reponseAEcrire(); // affichage de l'interface d'écriture
  else if (niveauEnCours == 1 && questionPosee == 5) question5niveau1(); // affichage du niveau concerné (numéro question)
  else if (niveauEnCours == 3 && questionPosee == 1) question1niveau3(); // (fiole violette)
}

void reponseAEcrire() {
  image(formNom, 0, 0); // on va reprendre le même écran pour écrire
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
