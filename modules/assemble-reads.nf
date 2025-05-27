process ASSEMBLE_READS {
    cpus 12
    memory "32 GB"
    container "quay.io/biocontainers/spades:4.2.0--h8d6e82b_1"

    input:
        tuple val(forward_reads), val(reverse_reads)
    
    output:
        path("metagenome-assembly/")

    script:
        """
        cat ${forward_reads} >> combined_forward.fastq
        cat ${forward_reads} >> combined_reverse.fastq
        usr/local/bin/spades.py \
            -1 combined_forward.fastq \
            -2 combined_reverse.fastq \
            -o metagenome-assembly
        """
}