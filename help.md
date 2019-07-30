MCTA024 - Sistemas Digitais - Lab 1 - Simulação com descrição VHDL


Como simular um arquivo VHDL usando linha de comando e o compilador GHDL no Linux


A página e o Manual do GHDL estão em "http://ghdl.free.fr";


- No Linux-Ubuntu, vá em "Pesquisar no seu computador" (ícone no canto superior esquerdo), e digite "Terminal" ou "terminal"; outra opção simples é pressionar simultaneamente as três teclas Ctrl+Alt+t;

- Para se certificar de que um programa está instalado no Linux, use o comando "which”; em nosso caso, digite "which ghdl" (sem as aspas); se aparecer um caminho (path) qualquer, o programa está instalado neste diretório; (no ambiente Unix/Linux é mais comum usar o termo “diretório”, em vez de “pasta”);

- Para descobrir em que diretório você se encontra, digite "pwd", e para saber o que há neste diretório, digite "ls" ou "ls -all";

- Para mudar de diretório, use o comando "cd <Nome_Do_Diretório>" ou "cd .." para subir um nível hierárquico; ao digitar apenas “cd”, o cursor volta para o diretório padrão do usuário, também conhecido como “home directory” ou “~”;

- Vá para o diretório onde foram salvos os arquivos "eq1.vhd" e "eq1_testbench.vhd";

- Digite "ghdl -h" para chamar o "help" do ghdl;

- Digite "ghdl -a eq1.vhd" para fazer a análise do circuito "eq1.vhdl";

- Digite "ghdl -a eq1_testbench.vhd" para fazer a análise do testbench "eq1_testbench.vhd";

- Digite "ghdl -e eq1_testbench" (sem o ponto e sem vhd) para fazer a elaboração (executável) do testbench;

- Digite "ghdl -r eq1_testbench --vcd=resposta.vcd" ou "./eq1_testbench --vcd=resposta.vcd" para injetar os vetores de entrada especificados no testbench para o circuito "eq1.vhd" e para salvar a resposta no arquivo "resposta.vcd";

- Uma alternativa para o formato "vcd" (value change dump), que é um formato aberto definido por uma empresa privada detentora dos direitos do Verilog, é o "wave" (que é um formato aberto definido pelo criador do ghdl); neste caso digite, "ghdl -r eq1_testbench --wave=resposta.ghw"; 

- Para ver a resposta da simulação, digite "gtkwave resposta.vcd &" (ou gtkwave resposta.ghw &), escolha quais sinais pretende ver (colocando em evidência o sinal desejado e acionando a opção "insert");

- Clique no ícone "Zoom Fit" para ajustar o intervalo de tempo adequado para a simulação efetuada;