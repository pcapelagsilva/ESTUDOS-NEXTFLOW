nextflow.enable.dsl=2

// 1. Parâmetros configuráveis
params.input_file = "simple_pipeline_data.txt"
params.output_dir = "simple_pipeline_report"

process CONTAR_LINHAS {
    // Define onde o relatório final será copiado fisicamente
    publishDir params.output_dir, mode: 'copy'

    input:
    path file_txt

    output:
    path "simple_pipeline_report.txt"

    script:
    """
    echo "=== RELATÓRIO DE CONTAGEM ===" > simple_pipeline_report.txt
    echo "Arquivo analisado: ${file_txt.name}" >> simple_pipeline_report.txt
    echo -n "Quantidade total de linhas: " >> simple_pipeline_report.txt

    # Comando Bash clássico para contar linhas de um arquivo
    wc -l < ${file_txt} >> simple_pipeline_report.txt

    echo "Análise concluída com sucesso em: \\\$(date)" >> simple_pipeline_report.txt
    """
}

workflow {
    // Criando um canal de fila a partir do caminho do arquivo de texto
    archive_channel = Channel.fromPath(params.input_file)

    // Executando o processo
    CONTAR_LINHAS(archive_channel)
}