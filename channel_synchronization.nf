process MAPEAMENTO {
    input:
    val id
    val genoma

    script:
    """
    echo "Mapeando a amostra ${id} contra o genoma ${genoma}"
    """
}

workflow {
    id_ch = Channel.of('Amostra_A', 'Amostra_B')
    genoma_ch = Channel.of('Ref_Humano', 'Ref_Camundongo', 'Ref_Bacteria')

    MAPEAMENTO(id_ch, genoma_ch)
}

// PERGUNTA 1: Quantas vezes o processo MAPEAMENTO será executado na prática?
// RESPOSTA: O processo será executado apenas 2 vezes

// PERGUNTA 2: Quais serão os pares de dados processados?
// RESPOSTA:
//          - Tarefa 1: 'Amostra_A' com 'Ref_Humano'
//          - Tarefa 2: 'Amostra_B' com 'Ref_Camundongo'

// PERGUNTA 3: O que acontece com o item sobressalente Ref_Bacteria?
// RESPOSTA: Como 'id_ch' e 'genoma_ch' são CANAIS DE FILA (QUEUE CHANNELS), o nextflow consome os dados de forma serial e pareada.
//           No momento em que a fila 'id_ch' esvazia (após a 'Amostra_B'), o nextflow encerrou o processo, assim o item 'Ref_Bacteria' ficou sobrando no canal e não foi processado.