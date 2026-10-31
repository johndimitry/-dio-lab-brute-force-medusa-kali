# 🔐 Simulando Ataque de Brute Force com Medusa e Kali Linux
> Desafio DIO - Cybersecurity | por johndimitry

![Kali](https://img.shields.io/badge/Kali_Linux-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![Medusa](https://img.shields.io/badge/Medusa-Brute_Force-red?style=for-the-badge)
![Metasploitable](https://img.shields.io/badge/Metasploitable2-Lab-blue)

### 🎯 Objetivo
Simular ataques de força bruta em ambiente 100% controlado (VirtualBox Host-Only) para entender a vulnerabilidade e propor mitigações.

**Ambiente:**
- Atacante: Kali Linux 2024.2
- Alvo: Metasploitable 2 + DVWA
- Rede: Host-Only Adapter (192.168.56.0/24) - Isolada

### 🔧 Fase 1: Reconhecimento
```bash
# Descobrir IP do alvo
nmap -sn 192.168.56.0/24
nmap -sV -p 21,80,445 192.168.56.101