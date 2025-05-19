process MAKE_FASTQC_REPORT {
    cpus 2
    memory "4 GB"
    container "quay.io/biocontainers/fastqc:0.11.7--4"
    publishDir "${params.results}/make-fastqc-report", mode: "copy"

    input:
        tuple val(id), path(reads)

    output:
        tuple val(id), path("${id}-fastqc-report/")

    script:
        """
        mkdir ${id}-fastqc-report
        fastqc \
            -o ${id}-fastqc-report/ \
            ${reads}
        """

}