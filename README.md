# Estudos - Nextflow & Pipelines de Bioinformática

Este repositório centraliza meus estudos, scripts de teste e o desenvolvimento de fluxos de trabalho (pipelines) utilizando o **Nextflow**. O objetivo principal é dominar a automação, reprodutibilidade e a escalabilidade de análises de dados biológicos complexos (como genômica e transcriptômica).

---

## 🚀 Sobre o Nextflow

O Nextflow é uma linguagem de domínio específico (DSL) baseada em Groovy que simplifica a escrita de pipelines computacionais de forma orientada a dados (*data-driven*). Ele permite:
* **Paralelização Nativa:** Gerenciamento automático de processos paralelos.
* **Reprodutibilidade:** Integração robusta com gerenciadores de pacotes (Conda) e containers (Docker, Singularity).
* **Portabilidade:** O mesmo pipeline pode rodar localmente no WSL/Linux ou ser escalado para clusters de HPC (Slurm) e nuvem (AWS, Google Cloud).

---

## 📁 Estrutura do Repositório

* `main.nf`: Arquivo principal contendo a lógica central do pipeline de estudos.
* `channel_queue.nf`: Scripts de teste e aprendizado sobre *Queue Channels* (canais assíncronos e fluxos unidirecionais).
* `channel_value.nf`: Scripts focados em *Value Channels* (canais que emitem valores estáticos ou reutilizáveis).
* `.gitignore`: Arquivo de configuração para ignorar logs pesados e pastas temporárias de execução do Nextflow.

---

## 🛠️ Tecnologias e Ferramentas Utilizadas

* **Nextflow** (DSL2)
* **Linux / Bash**
* **WSL 2** (Windows Subsystem for Linux - Ubuntu)
* **VS Code** (com extensões para Nextflow e suporte ao WSL)

---

## ⚙️ Como Executar os Scripts

Certifique-se de ter o Java (Java 11 ou superior) e o Nextflow instalados no seu ambiente WSL.

Para rodar qualquer um dos scripts de canais ou o pipeline principal, utilize o terminal do Linux dentro da pasta do projeto:

```bash
# Executar o pipeline principal
nextflow run main.nf

# Testar os conceitos de Queue Channels
nextflow run channel_queue.nf

# Testar os conceitos de Value Channels
nextflow run channel_value.nf