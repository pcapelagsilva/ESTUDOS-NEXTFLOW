// 'fromFilePairs' encontra os arquivos R1/R2 e agrupa automaticamente

amostras_ch = Channel.fromFilePairs('dados/*_{1,2}.fastq')

process CHECAR_QUALIDADE {
    tag "$sample_id"

    input:
    tuple val(sample_id), path(reads)
    // O 'tuple' indica que os dados entram agrupados
    // O 'val(sample_id)' captura o ID (string) e 'path(reads)' captura a lista de arquivos

    script:
    """
    echo "Processando as reads ${reads[0]} e ${reads[1]} da amostra ${sample_id}"
    """
}

workflow {
    CHECAR_QUALIDADE(amostras_ch)
}