nextflow.enable.dsl=2

// Parâmetro que aponta para os arquivos brutos
params.reads = "dados/*.fastq"
params.results = "qc_reports"

process RODAR_FASTQC {
    tag "Analisando: ${fastq.name}"
    publishDir params.results, mode: 'copy'

    input:
    path fastq

    output:
    path "*_fastqc.{html,zip}"

    script:
    """
    fastqc ${fastq}
    """
}

workflow {
    // 1. Entrada: Criando canal de fila para capturar os arquivos fastq
    arquivos_fastq_ch = Channel.fromPath(params.reads)

    // 2. Processamento & Saída
    RODAR_FASTQC(arquivos_fastq_ch)
}