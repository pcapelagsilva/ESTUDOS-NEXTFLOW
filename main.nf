#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process COMPRIMENTAR {
    output:
    stdout

    script:
    """
    echo 'Nextflow rodando com sucesso no VS Code e WSL!'
    """
}

workflow {
    resultado_ch = COMPRIMENTAR()
    resultado_ch.view()
}