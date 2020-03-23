String globalScreen; // variable permettant de connaître l'écran actuel
String boutonClavierAppuye = null; // variable contenant la lettre/le chiffre du clavier appuyée si besoin
int level=0 ; //niveau du joueur
PImage background; //fond d'écran
String pseudo;//faire déclaration des pseudo (variable "pseudo") avec random (faire tableau avec liste pseudo puis créer string pseudo pour en choisir un aléatoire (nom tableau[random(tableau.length)]))))
int nameLength = 0; // longueur du pseudo tapé dans l'écran du pseudo
PFont fontClavier; //police pour tout ce qui sera tapé


// ON VA PEUT ETRE NE PAS UTILISER LES CLASSES FINALEMENT, TRES COMPLIQUE POUR PAS GRAND CHOSE AU FINAL...
class Level {  //classe pour les différents niveaux
    Question question1 ;
    Question question2 ;
    Question question3 ;
    Question question4 ;
    Question question5 ;
  void main(Question[] question) {
    question1 = question[0] ;
    question2 = question[1] ;
    question3 = question[2] ;
    question4 = question[3] ;
    question5 = question[4] ;
  }
}

// pour déclarer une question : Question question1 = new Question (loadImage ("Q1N1.png") , 1 , reponseQ1N1 , "QCM") ; (déclarer dans le setup)
class Question {  //classe pour les différentes questions
      PImage bonneReponseQCM ;
      PImage reponse2 ;
      PImage reponse3 ;
      PImage reponse4 ;
      String bonneReponseClavier ; 
      int bonneReponseClic[] ;
      String type ;
      PImage question ;
      int numero ;
  void main(PImage intituleQuestion , int numeroQuestion , String[] reponseQuestion , String typeQuestion) {
    if (type == "QCM") {
      bonneReponseQCM = reponse[0] ;
      reponse2 = reponse[1] ;
      reponse3 = reponse[2] ;
      reponse4 = reponse[3] ;
    } else if (type == "clavier") {
      bonneReponseClavier = reponse[0] ;
    } else if (type == "clicEcran") {
      bonneReponseClic[] = {reponse[0] , reponse[1]};
    }
  }
} 


void setup() {
 size(1280, 800); // taille du jeu : 1280x800
 globalScreen="écran principal"; //initialisation de l'écran 
 background = loadImage("background_global.png"); // chargement du fond d'écran global
 fontClavier = loadFont("fontPourClavier.ttf"); // chargement de la police pour ce qui sera tapé au clavier
 
 Level level1 = new Level(questionsLevel1) ;
 //déclaration des réponses "RéponseQuestionNiveau"
 String[] RQ1N2 = {"R1Q1N2.png" , "R2Q1N2.png" , "R3Q1N2.png" , "R4Q1N2.png"} ;
 String[] RQ2N2 = {"R1Q2N2.png" , "R2Q2N2.png" , "R3Q2N2.png" , "R4Q2N2.png"} ;
 String[] RQ3N2 = {"R1Q3N2.png" , "R2Q3N2.png" , "R3Q3N2.png" , "R4Q3N2.png"} ;
 String[] RQ4N2 = {"R1Q4N2.png" , "R2Q4N2.png" , "R3Q4N2.png" , "R4Q4N2.png"} ;
 String[] RQ5N2 = {"R1Q5N2.png" , "R2Q5N2.png" , "R3Q5N2.png" , "R4Q5N2.png"} ;
 String[] RQ2N3 = {"R1Q2N3.png" , "R2Q2N3.png" , "R3Q2N3.png" , "R4Q2N3.png"} ;
 String[] RQ3N3 = {"R1Q3N3.png" , "R2Q3N3.png" , "R3Q3N3.png" , "R4Q3N3.png"} ;
 
}


void draw(){
  frameRate(60);
  if (globalScreen == "écran principal") {
   ecranPrincipal() ; 
  } else if (globalScreen == "écran nom") {
    ecranNom();  
  } else if (globalScreen == "écran niveau") {
    ecranNiveau(level); 
  } 
}

void ecranPrincipal () {
   PImage principalScreen =  loadImage("background_home.png"); // charge le fond de l'écran principal 
   // coordonnées de la zone du bouton Jouer :
   int minX = 318;
   int maxX = 318+643;
   int minY = 396;
   int maxY = 396+165;
   PImage boutonJouer; // création de la variable boutonJouer
   if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Jouer
     boutonJouer = loadImage("bouton_jouer_surb.png"); //sélectionne le bouton en surbrillance
     cursor(HAND); // curseur en forme de main
     verifierClic(); // MELINA : CREER UNE FONCTION "verifierClic" DETECTANT LE CLIC ET QUI CHANGE LA VARIABLE "globalScreen" EN CONSEQUENCE
   } else {
     boutonJouer = loadImage("bouton_jouer.png"); // bouton normal
     cursor(ARROW); // curseur normal (flèche)
   }
   image(principalScreen, 0, 0); // affiche le fond d'écran menu
   image(boutonJouer, 0, 0); // affiche le bouton Jouer
}

void ecranNom() {
   PImage formNom = loadImage("name_screen.png");
   image(background, 0, 0);
   image(formNom, 0, 0);
   // coordonnées de la zone du bouton Valider :
   int minX = 367;
   int maxX = 367+545;
   int minY = 549;
   int maxY = 549+110;
   if (mouseX>minX && mouseX<maxX && mouseY >minY && mouseY <maxY) { // vérifie si la souris est dans la zone du bouton Valider
     image(loadImage("name_screen_green_button.png"), 0, 0); //affiche le bouton valider en surbrillance
   }
   if (nameLength>0) {
     textSize(130);
     textAlign(CENTER);
     text(pseudo.substring(0, nameLength), 1016, 435);
   }
   // (MELINA => UTILISER UNE FONCTION KEYTYPED QUI PERMET D'INCREMENTER LA VARIABLE "nameLength" 
   //  POUR POUVOIR AFFICHER LE NOM (ou décrémenter en effacant) = cf https://processing.org/reference/keyTyped_.html pour la doc sur la fonction keyTyped)
}
