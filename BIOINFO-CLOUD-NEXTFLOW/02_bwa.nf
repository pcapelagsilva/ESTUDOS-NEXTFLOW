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

process BWA_MEM {
    
    container 'staphb/bwa:0.7.17'

    input:
    tuple val(sample), path(reads), path(reference), path(index_files)

    output:
    path "${sample}.sam"

    script:
    """
    bwa mem ${reference} ${reads[0]} ${reads[1]} > ${sample}.sam
    """

}

workflow {
    reference = channel.fromPath('data/reference/SARS-CoV-2_reference.fasta')

    reference.view()

    index_reference = BWA_INDEX(reference)

    index_reference.view()

    reads = channel.fromFilePairs('data/raw/*_R{1,2}.fastq.gz')

    reads.view()

    bwa_input = reads
        .combine(index_reference)
        .map { sample_id, read_files, ref_fasta, amb_file, ann_file, bwt_file, pac_file, sa_file ->
            tuple(
                sample_id,
                read_files,
                ref_fasta,
                [amb_file, ann_file, bwt_file, pac_file, sa_file]
        )
    }

    bwa_input.view()

    BWA_MEM(bwa_input)
}