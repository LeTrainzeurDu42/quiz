String globalScreen ;
int level=0 ;
//faire déclaration des pseudo avec random (faire tableau avec liste pseudo puis créer string pseudo pour en choisir un aléatoire (nom tableau[random(tableau.length)]))))

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


void setup() {
 globalScreen="écran principal" ; 
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
  if (globalScreen == "écran principal") {
   ecranPrincipal() ; 
  } else if (globalScreen == "écran nom") {
    ecranNom() ;  
  } else if (globalScreen == "écran niveau") {
    ecranNiveau(level);
  } 
}
