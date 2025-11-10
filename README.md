# Alura - Monitoramento do Sistema

Um projeto do curso de nivelamento DevOps da Alura.
Monitora os logs 'syslog' e 'auth.log', a conectividade de rede, o espaço de disco, memória RAM e uso de CPU.

# Arquivos ".service" e ".timer" p/ agendamento com o Systemd

Copie o script "monitoramento-sistema.sh" para o diretório "/usr/local/bin/":
~~~bash
sudo cp monitoramento-sistema.sh /usr/local/bin/monitoramento-sistema.sh
~~~

Atribui a permissão de execução:
~~~bash
sudo chmod +x /usr/local/bin/monitoramento-sistema.sh
~~~

[Em desenvolvimento...]
