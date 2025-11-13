# Alura - Monitoramento do Sistema

Um projeto do curso de nivelamento DevOps da Alura.
Monitora os logs 'syslog' e 'auth.log', a conectividade de rede, o espaço de disco, memória RAM e uso de CPU.

# Arquivos _".service"_ e _".timer"_ para agendamento com o Systemd

Copie o script _"monitoramento-sistema.sh"_ para o diretório "/usr/local/bin/" e atribua a permissão de execução:
~~~~
sudo cp monitoramento-sistema.sh /usr/local/bin/monitoramento-sistema.sh
sudo chmod +x /usr/local/bin/monitoramento-sistema.sh
~~~~

Copie os arquivos _".service"_ e _".timer"_ para o diretório _"/etc/systemd/system/"_:
~~~~
sudo cp monitoramento-sistema.service monitoramento-sistema.timer /etc/systemd/system/
~~~~

Reinicie o _"daemon"_ e habilite o serviço no arquivo _".timer"_:
~~~~
sudo systemctl daemon-reload
sudo systemctl enable monitoramento-sistema.timer
~~~~

Verifique se o serviço foi habilitado:
~~~~
sudo systemctl status monitoramento-sistema.timer
~~~~

Se o serviço estiver habilitado corretamente, você terá uma saída similar a esta:
~~~~
● monitoramento-sistema.timer - Timer para execução periódica do Monnitoramento de Sistema
     Loaded: loaded (/etc/systemd/system/monitoramento-sistema.timer; enabled; preset: enabled)
     Active: active (waiting) since Sun 2025-11-09 21:53:58 -03; 2h 1min ago
    Trigger: Mon 2025-11-10 00:00:00 -03; 4min 22s left
   Triggers: ● monitoramento-sistema.service

Nov 09 21:53:58 shereka systemd[1]: Started monitoramento-sistema.timer - Timer para execução periódica do Monnitoramento de Sistema.
~~~~

Você pode verificar se a execução do script aconteceu, usando:
~~~~
sudo journalctl -u monitoramento-sistema.service
~~~~

Se o script foi executado pelo menos uma vez você terá uma saída similar:
~~~~
Nov 10 00:00:15 shereka systemd[1]: Starting monitoramento-sistema.service - Script de Monitoramento de Sistema...
Nov 10 00:00:18 shereka systemd[1]: monitoramento-sistema.service: Deactivated successfully.
Nov 10 00:00:18 shereka systemd[1]: Finished monitoramento-sistema.service - Script de Monitoramento de Sistema.
~~~~
