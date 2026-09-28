process FASTQC {

    container 'staphb/fastqc:0.12.1'
    
    publishDir 'results', mode: 'copy'

    input:
    path reads
    
    output:
    path '*_fastqc.html'
    path '*_fastqc.zip'

    script:
    """
    fastqc ${reads}
    """
}

workflow {

    reads = channel.fromPath('data/raw/*.fastq.gz')

    FASTQC(reads)
}