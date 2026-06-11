canal1 = Channel.of(1, 2, 3)
canal2 = Channel.of(1)

process SUM {
    input:
    val x
    val y

    output:
    stdout

    script:
    """
    echo \$(($x+$y))
    """
}

workflow {
    SUM(canal1, canal2.first()).view()
}

Channel
    .fromFilePairs('./data/ggal/*_{1,2}.fq', hidden: true)
    .view()