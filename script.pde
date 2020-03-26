String globalScreen; // variable permettant de connaître l'écran actuel
String boutonClavierAppuye = null; // variable contenant la lettre/le chiffre du clavier appuyée si besoin
int level=0 ; //niveau du joueur
PImage background; //fond d'écran
String pseudo;//faire déclaration des pseudo (variable "pseudo") avec random (faire tableau avec liste pseudo puis créer string pseudo pour en choisir un aléatoire (nom tableau[random(tableau.length)]))))
int nameLength = 0; // longueur du pseudo tapé dans l'écran du pseudo
PFont fontClavier; //police pour tout ce qui sera tapé



// création d'un tableau pour générer un pseudo aléatire au joueur
String [] listePseudo = {"The Rock" , "Severus Rogue" , "Sylvain Liaboeuf" , "Chaise de bureau" , "Boîte d'anchois" , "Tractopelle" , "Jul" , "Stylo 4 couleurs" , "David Pujadas" , "XxDarkkillerdu42xX" , "Julien Le Perce" , "Calculatrice Casio" , "Pangolin" , "Sophie la Girafe" , "Rocky Sifredo" , "Barre espace" , "Camescope" , "Tente Quechua"} ;
int indexpseudo = int(random(listePseudo.length)) ;
pseudo = listePseudo[indexpseudo];



void setup() {
 size(1280, 800); // taille du jeu : 1280x800
 globalScreen="écran principal"; //initialisation de l'écran 
 background = loadImage("background_global.png"); // chargement du fond d'écran global
 fontClavier = loadFont("fontPourClavier.ttf"); // chargement de la police pour ce qui sera tapé au clavier
 
 
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




void mouseClicked() {     //fonction qui verifier le clic du bouton valider
   if (globalScreen == "écran principal") {
     int minXecranprincipal = 367 ;
     int maxXecranprincipal = 367+545 ;
     int minYecranprincipal = 549 ;
     int maxYecranprincipal = 549+110 ;
       if (mouseX>367 + mouseX<367+549 + mouseY>549 + mouseY<549+110) {
           globalScreen == "écran nom" ;
      }
   }
}     



void keyTyped () {
  String [] pseudochoisi = println ("typed" + int(key) + " " + keyCode) ;
     if (nameLength < listePseudo.length) {
       nameLength ++ 
        if (nameLength
  
  



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
