// Definição do processo
process TRANSCREVER {
    publishDir 'resultados', mode: 'copy' // O 'copy' cria um arquivo físico independente

    input:
    val sequence // Definimos o 'input' como 'val' para que ele receba strings, números ou dados simples

    output:
    path 'rna_transcription_pipeline.txt' // Definimos o 'output' como um 'path' para capturar e gerenciar arquivos gerados

    script:
    """
    echo "${sequence}" | tr 'T' 'U' > rna_transcription_pipeline.txt
    """
}

workflow {
    def dna_canal = Channel.value("ATGCGATCGATCGAT")

    TRANSCREVER(dna_canal) // Chamada do processo passando o canal
}