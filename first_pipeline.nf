nextflow.enable.dsl=2

// Parâmetros de entrada (Pode ser alterado pela linha de comando)
params.sequencia = "ATCGATCGATCGATCGATCG"
params.outdir = "results_first_pipeline"

process CONTAR_BASES {
    // Diretiva para organizar a saída final
    publishDir params.outdir, mode: 'copy'

    input:
    val seq

    output:
    path "database_report_first_pipeline.txt"

    script:
    """
    echo "--- RELATÓRIO DE SEQUENCIAMENTO ---" > database_report_first_pipeline.txt
    echo "Sequência analisada: ${seq}" >> database_report_first_pipeline.txt
    echo -n "Total de bases encontradas: ">> database_report_first_pipeline.txt
    ech -n "${seq}" | wc -c >> database_report_first_pipeline.txt
    """
}

workflow {
    // 1. Entrada: Criando o canal a partir do parâmetro
    canal_seq = Channel.value(params.sequencia)

    // 2. Processamento: Chamando o processo
    CONTAR_BASES(canal_seq)
}