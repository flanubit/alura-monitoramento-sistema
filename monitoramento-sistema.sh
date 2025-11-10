#!/bin/bash
# Script: monitoramento-do-sistema.sh
# Autor: Flanubio Ribeiro
# Descrição: Monitora os logs 'syslog' e 'auth.log', a conectividade de rede, o espaço de disco e memória RAM. Um projeto do curso de nivelamento DevOps da Alura.
# Uso: ./monitoramento-do-sistema.sh

DIRETORIO="sistema"
mkdir -p $DIRETORIO

function monitorar_logs() {
	
	echo "$(date)" > $DIRETORIO/monitoramento_logs_syslog.txt
	echo "$(date)" > $DIRETORIO/monitoramento_logs_auth.txt
	
	grep -E "(fail(ed)?|error|denied|unauthorized)" /var/log/syslog | awk '{print $1, $2, $3, $5, $6, $7}' >> $DIRETORIO/monitoramento_logs_syslog.txt
	grep -E "(fail(ed)?|error|denied|unauthorized)" /var/log/auth.log | awk '{print $1, $2, $3, $5, $6, $7}' >> $DIRETORIO/monitoramento_logs_auth.txt
}

function monitorar_rede() {
	
	if ping -c 1 8.8.8.8 > /dev/null; then
		echo "$(date): Conectividade ativa." > $DIRETORIO/monitoramento_logs_rede.txt
	else
		echo "$(date): Sem conexão com a internet." > $DIRETORIO/monitoramento_logs_rede.txt
	fi

	if curl -s --head https://www.alura.com.br/ | grep -q "HTTP/2 200"; then
		echo "$(date): Conexão bem sucedida com o site da Alura." >> $DIRETORIO/monitoramento_logs_rede.txt
	else
		echo "$(date): Sem conexão com o site da Alura." >> $DIRETORIO/monitoramento_logs_rede.txt
	fi
}

function monitorar_disco() {
	
	echo "$(date)" > $DIRETORIO/monitoramento_logs_disco.txt
	
	df -h | grep -v "drivers" | awk '$5+0 > 75 {print "A unidade "$1" está com "$5" de uso."}' >> $DIRETORIO/monitoramento_logs_disco.txt
	
	echo "Uso de disco no diretório principal:" >> $DIRETORIO/monitoramento_logs_disco.txt
	du -sh /home/flanubit/ >> $DIRETORIO/monitoramento_logs_disco.txt
}

function monitorar_hardware() {
	
	echo "$(date)" > $DIRETORIO/monitoramento_logs_hardware.txt
	
	free -h | grep "Mem:" | awk '{print "Memória RAM Total: "$2", Usada: "$3", Livre: "$4"."}' >> $DIRETORIO/monitoramento_logs_hardware.txt
	top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "Uso da CPU: "100-$1"%"}' >> $DIRETORIO/monitoramento_logs_hardware.txt
	
	echo "Operações de leitura e escrita:" >> $DIRETORIO/monitoramento_logs_hardware.txt
	iostat | grep -E "Device|^sda|^sdb|^sdc" | awk '{print $1, $2, $3, $4}' >> $DIRETORIO/monitoramento_logs_hardware.txt
}

function executar_monitoramento() {
	monitorar_logs
	monitorar_rede
	monitorar_disco
	monitorar_hardware
}

executar_monitoramento
