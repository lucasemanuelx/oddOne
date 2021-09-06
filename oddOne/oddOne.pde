//variáveis globais
int [][] M = new int [10][8];
int resultado = 0, cont, novo, pontos = 0;
boolean jogando = true;

void setup() {
  size(800, 800);
  noStroke();
  textAlign(CENTER);
  textSize(20);
  tam();
  novo = int(random(1, 4));
}

void draw() {
  if (jogando) {
    background(100);
    fim();
    figura();

    fill(255);
    if (resultado == 0) text("Selecione a figura diferente", width/2, height-75);
    if (resultado == 1) text("Acertou!!", width/2, height-75);
    if (resultado == 2) text("Errou!", width/2, height-75);

    //tempo
    cont++;
    rect(0, height-10, cont/600.0*800, height-10);
    
    //pontuação
    fill(255);
    text("Pontos: " + pontos, 700, 700);
  } else
    novaRodada();
}

/*
- função determina o tamanho das figuras
- sorteia uma figura com tamanho reduzido
*/
void tam() {
  for (int i = 0; i < M.length; i++)
    for (int j = 0; j < M[0].length; j++)
      M[i][j] = width/10;

  int x = int(random(10));
  int y = int(random(8));
  M[x][y] = width/10-10;
}

// função que desenha figuras
void figura() {
  for (int i = 0; i < M.length; i++) {
    for (int j = 0; j < M[0].length; j++) {
      //ellipse(40+80*i, 40+80*j, M[i][j], M[i][j]);
      //losango(40+80*i, 40+80*j, M[i][j]);

      if (novo == 1) {
        fill(255);
        losango(40+80*i, 40+80*j, M[i][j]);
        fill(100);
        rect(20+80*i, 19+80*j, 40, 40);
      } else if (novo == 2) {
        fill(255);
        losango(40+80*i, 40+80*j, M[i][j]);
        fill(100);
        ellipse(40+80*i, 40+80*j, 40, 40);
      } else if (novo == 3) {
        fill(255);
        ellipse(40+80*i, 40+80*j, M[i][j], M[i][j]);
        fill(100);
        losango(40+80*i, 40+80*j, M[i][j]);
        fill(255);
        rect(20+80*i, 19+80*j, 40, 40);
      }
    }
  }
}


//função para desenhar losangos
void losango(int x, int y, int l) {
  quad(x, y-l/2, x+l/2, y, x, y+l/2, x-l/2, y);
}

void mousePressed() {
  if (jogando) {
    if (M[mouseX/80][mouseY/80] == width/10-10) { //verifica se figura escolhida é a correta
      resultado = 1;
      cont = -1;
    } else resultado = 2;
  }
}

/*
função finaliza o jogo
- quando há ação do jogador
- se o tempo acabar
*/
void fim() {
  if (resultado == 1 || resultado == 2) {
    jogando = false;
  }

  if (cont/60 == 10) {
    resultado = 3;
    if (resultado == 4) text("Acabou o tempo!", width/2, height-75);
    jogando = false;
  }
}

/*
função começa uma nova rodada
- se o jogador ganhar, sorteia novo padrão e incrimenta +1 ponto
- se jogador perder, recomeça
*/
void novaRodada() {
  if (resultado == 1) {
    int aux = novo;
    while (novo == aux) novo = int(random(1, 4)); //impede que novo padrão seja igual ao anterior
    resultado = 0;
    jogando = true;
    tam();
    pontos++;
  } 

  if (resultado == 3 || resultado == 2) {
    fill(255, 255, 255, 2);
    rect(0, 0, width, height);
    fill(0);
    text("Pressione qualquer tecla para jogar novamente", width/2, height/2);
    if (keyPressed) {
      pontos = 0;
      cont = 0;
      novo = int(random(1, 4));
      resultado = 0;
      jogando = true;
      tam();
    }
  }
}
