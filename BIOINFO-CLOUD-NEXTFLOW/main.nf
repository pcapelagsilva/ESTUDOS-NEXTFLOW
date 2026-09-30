//Declara um processo chamado FASTQC
process FASTQC {

    //Diz para que quando o "process FASTQC" for executado, utilizar o seguinte container '...'
    container 'staphb/fastqc:0.12.1'
    //Determina para onde os resultados serão publicados
    publishDir 'results', mode: 'copy'

    //Mostra o que o processo receberá
    input:
    //Tuple = entrada será composta por mais de um elemento relacionado | val = Diz que o primeiro elemento do tuple será recebido como um valor chamado 'sample'
    //Path(reads) = diz que o próximo elemento do tuple representa arquivo(s) que serão disponibilizados como arquivos dentro do diretório de trabalho do process
    tuple val(sample), path(reads)
    //Essa linha inteira pode ser lida como: "Receba um conjunto de dados contendo o identificador da amostra e os arquivos FASTQ correspondentes"

    //Mostra as saídas do processo
    output:
    //Diz que o processo produzirá um arquivo com nome terminando em '_fastqc.html'
    path "*_fastqc.html"
    //Diz que o processo produzirá um arquivo com nome terminando em '_fastqc.zip'
    path "*_fastqc.zip"

    //É o comando que realmente será executado, ou seja, diz que quando chegar a hora de executar o processo, rode isso
    script:
    //fastqc = É o comando da ferramenta FastQC
    //${reads} = Substitui a variável pelo conteúdo recebido
    """
    fastqc ${reads}
    """
}

//Define o fluxo do pipeline, 'De onde os dados vêm e para onde vão'
workflow {
    //channel = um meio pelo qual os dados são transportados entre as partes do workflow.
    //.fromFilePairs = Agrupa os arquivos pareados.
    reads = channel.fromFilePairs('data/raw/*_R{1,2}.fastq.gz')

    //FASTQC(reads) = Conecta o workflow ao processo, basicamente: "Pegue o conteúdo do channel reads e envie o para o process FASTQC"
    FASTQC(reads)
}