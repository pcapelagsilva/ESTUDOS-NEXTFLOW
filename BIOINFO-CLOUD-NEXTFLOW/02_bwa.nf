process BWA_INDEX {
    
    container 'staphb/bwa:0.7.17'

    input:
    path reference

    output:
    tuple path(reference), path("*.amb"), path("*.ann"), path("*.bwt"), path("*.pac"), path("*.sa")

    script:
    """
    bwa index ${reference}
    """
}

workflow {
    reference = channel.fromPath('data/reference/SARS-CoV-2_reference.fasta')

    reference.view()

    index_reference = BWA_INDEX(reference)

    index_reference.view()

    reads = channel.fromFilePairs('data/raw/*_R{1,2}.fastq.gz')

    reads.view()

    bwa_input = reads.combine(index_reference)

    bwa_input.view()
}