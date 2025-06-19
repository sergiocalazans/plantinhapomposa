// Importa a biblioteca de som do Processing
import processing.sound.*;
// Importa a biblioteca de vídeo do Processing
import processing.video.*;

// Declara objetos para os arquivos de som usados no jogo
SoundFile trilha;
SoundFile click;
SoundFile flor;

// Variável de controle para saber se o quiz chegou ao fim
boolean fimDoQuiz = false;

// Imagem de fundo
PImage fundo;

// Estado controla a tela atual (menu, perguntas, explicação, resultado etc.)
int estado = 0;

// Coordenadas e tamanhos dos botões da tela inicial
int xBotaoIniciar = 150;
int yBotaoIniciar = 300;
int xBotaoSobre = 150;
int yBotaoSobre = 380;
int larguraBotao = 200;
int alturaBotao = 60;
int raioBotao = 15; // Arredondamento dos cantos

// Cores personalizadas para os elementos da interface
color corBordaBotao = #f6f3cb;
color corFundoBotao = #602e0f;
color corTextoBotao = #f6f3cb;
color corCaixaTexto = #c7ea76;
color corTextoTitulo = #f6f3cb;
color corTextoGeral = #602e0f;
color corCaixaBorda = #602e0f;

// Fonte do texto
PFont fonte;

// Estrutura de dados para armazenar as perguntas
JSONArray perguntasJSON;
ArrayList<Pergunta> perguntas = new ArrayList<Pergunta>();
int perguntaAtual = 0;

Movie[] videos = new Movie[7];

// Pontuação do jogador
int pontuacao = 0;

// Classe interna para representar uma pergunta
class Pergunta {
  int id;
  String pergunta;
  String[] options;
  int correta;

  // Construtor da pergunta
  Pergunta(int id, String pergunta, String[] options, int correta) {
    this.id = id;
    this.pergunta = pergunta;
    this.options = options;
    this.correta = correta;
  }
}

// Vetor para armazenar as imagens de flores (usadas no resultado)
PImage[] flores;

void setup() {
  size(500, 700); // Tamanho da janela

  fundo = loadImage("img/fundo.jpg");
  fundo.resize(width, height);

  fonte = createFont("fontes/Gagalin-Regular.otf", 64);

  carregarPerguntas("Perguntas.json");

  trilha = new SoundFile(this, "sons/trilha-sonora.mp3");
  click = new SoundFile(this, "sons/mouse-click.mp3");
  flor = new SoundFile(this, "sons/som-flor.mp3");

  videos[0] = new Movie(this, "videos/Questao02.mp4");
  videos[1] = new Movie(this, "videos/Questao01.mp4");
  videos[2] = new Movie(this, "videos/Questao03.mp4");
  videos[3] = new Movie(this, "videos/Questao04.mp4");
  videos[4] = new Movie(this, "videos/Questao05.mp4");
  videos[5] = new Movie(this, "videos/Questao06.mp4");
  videos[6] = new Movie(this, "videos/Questao07.mp4");

  trilha.loop();
  trilha.amp(1.0);
  click.amp(2.0);

  flores = new PImage[12];
  for (int i = 0; i < flores.length; i++) {
    flores[i] = loadImage("img/flor" + nf(i + 1, 2) + ".png");
  }
}

void draw() {
  background(fundo);
  textFont(fonte);

  if (perguntaAtual >= 0 && perguntaAtual < videos.length && videos[perguntaAtual].available()) {
    videos[perguntaAtual].read();
  }

  if (estado == 4 && perguntaAtual < videos.length && videos[perguntaAtual].available()) {
    videos[perguntaAtual].read();
  }

  if (estado == 0) {
    mostrarInicio(corCaixaBorda);
  } else if (estado == 1){
    mostrarSobre(corCaixaTexto, corCaixaBorda, corTextoTitulo, corTextoGeral);
  } else if (estado == 2){
    mostrarInstrucoes();
  } else if (estado == 3){
    if (perguntaAtual < videos.length) videos[perguntaAtual].pause();
    mostrarPergunta(perguntas.get(perguntaAtual));
  } else if (estado == 4){
    if (perguntaAtual < videos.length) videos[perguntaAtual].play();
    mostrarExplicacao();
  } else if (estado == 5) {
    desenharFlor(pontuacao);
  } else {
    if (perguntaAtual < videos.length) videos[perguntaAtual].pause();
    estado = 0;
  }
}

void mousePressed() {
  if (estado == 3) {
    for (Botao b : botoesOpcoes) {
      if (b.clicado(mouseX, mouseY)) {
        click.play();
        trilha.pause();
        Pergunta p = perguntas.get(perguntaAtual);

        if (b.indice == p.correta) {
          pontuacao++;
          println("Resposta correta");
        }

        estado = 4;

        if (perguntaAtual < videos.length) {
          videos[perguntaAtual].stop();
        }

        if (perguntaAtual == perguntas.size() - 1) {
          fimDoQuiz = true;
        }

        break;
      }
    }
  }

  if (estado == 0) {
    if (clicouNoBotao(xBotaoIniciar, yBotaoIniciar)){
      click.play();
      estado = 2;
    } else if (clicouNoBotao(xBotaoSobre, yBotaoSobre)) {
      click.play();
      estado = 1;
    }
  } else if (estado == 1) {
    if (clicouNoBotao(150, 620)) {
      click.play();
      estado = 0;
    }
  }

  if (clicouNoBotao(150, 600)) {
    click.play();

    if (estado == 2){
      trilha.amp(0.4);
      estado = 3;
    } else if (estado == 4) {
      if (perguntaAtual < videos.length) videos[perguntaAtual].pause();

      if (fimDoQuiz) {
        println("Fim do questionário");
        println("Pontuação final: " + pontuacao);
        perguntaAtual = 1;
        trilha.stop();
        estado = 5;
        flor.amp(0.1);
        flor.play();
        fimDoQuiz = false;
      } else {
        perguntaAtual++;
        if (perguntaAtual < perguntas.size()) {
          trilha.play();
          trilha.amp(0.4);
          estado = 3;
        }
      }
    }
  }

  if (mouseX >= scrollBarX && mouseX <= scrollBarX + scrollBarLargura &&
      mouseY >= scrollPointerY && mouseY <= scrollPointerY + scrollPointerAltura) {
    arrastandoScroll = true;
  }
}

void keyPressed() {
  if (key == 'e' || key == 'E') {
    exit();
  }
}

void movieEvent(Movie m) {
  m.read();
}
