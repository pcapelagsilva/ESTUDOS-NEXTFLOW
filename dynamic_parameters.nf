params.alinhador = 'bowtie2'
params.analisar = false

process ALINHAMENTO {
    input:
    val ferramenta

    when:
    params.analisar
    // A cláusula  'when:' avalia uma expressão booleana.
    // O processo só rodará se 'params.analisar' for igual a 'true'

    script:
    """
    echo "Executando o alinhamento genômico utilizando a ferramenta: ${ferramenta}"
    """
}

workflow {
    ferramenta_ch = Channel.value(params.alinhador)
    ALINHAMENTO(ferramenta_ch)
}

// Se rodarmos o script da forma que ele esta escrito acima ("nextflow run dynamic_parameters"), o processo será ignorado porque o "params.analisar" é "false". Para roda-lo, precisamos passa a seguinte flag no terminal: "nextflow run dynamic_parameters.nf --analisar"