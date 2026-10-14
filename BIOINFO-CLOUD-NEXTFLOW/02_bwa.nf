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

process SAMTOOLS_VIEW {

    container 'staphb/samtools:1.20'

    input:
    path sam

    output:
    path "*.bam"

    script:
    """
    samtools view -b ${sam} > ${sam.simpleName}.bam
    """
}

process SAMTOOLS_SORT{

    container 'staphb/samtools:1.20'

    input:
    path bam

    output:
    path "*.sorted.bam"

    script:
    """
    samtools sort ${bam} -o ${bam.simpleName}.sorted.bam
    """
}

process SAMTOOLS_INDEX {

    container 'staphb/samtools:1.20'

    input:
    path bam

    output:
    path "*.bai"

    script:
    """
    samtools index ${bam}
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

    sam_output = BWA_MEM(bwa_input)

    bam_output = SAMTOOLS_VIEW(sam_output)

    sorted_bam = SAMTOOLS_SORT(bam_output)

    SAMTOOLS_INDEX  
}