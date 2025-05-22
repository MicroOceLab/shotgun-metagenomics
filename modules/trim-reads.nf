process TRIM_READS {
    cpus 4
    memory "8 GB"
    container "quay.io/biocontainers/trimmomatic:0.33--1"

    input:
        tuple val(id), val(forward_reads), val(reverse_reads)
    
    output:
        tuple eval("echo \${ID}"), path("${id}-trimmed-paired-forward-reads.fastq"), path("${id}-trimmed-paired-reverse-reads.fastq"), emit: paired_reads
        tuple eval("echo \${ID}"), path("${id}-trimmed-unpaired-forward-reads.fastq"), path("${id}-trimmed-unpaired-reverse-reads.fastq"), emit: unpaired_reads

    script:
        """
        trimmomatic PE \
            ${forward_reads} \
            ${reverse_reads} \
            ${id}-trimmed-paired-forward-reads.fastq \
            ${id}-trimmed-unpaired-forward-reads.fastq \
            ${id}-trimmed-paired-reverse-reads.fastq \
            ${id}-trimmed-unpaired-reverse-reads.fastq \
            ILLUMINACLIP:${params.trim_reads_adapters}:${params.trim_reads_illuminaclip} \
            LEADING:${params.trim_reads_leading} \
            TRAILING:${params.trim_reads_trailing} \
            SLIDINGWINDOW:${params.trim_reads_slidingwindow} \
            MINLEN:${params.trim_reads_minlen}
        """
}