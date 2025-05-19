process MAKE_MULTIQC_REPORT {
    cpus 4
    memory "8 GB"
    container "quay.io/biocontainers/multiqc:1.28--pyhdfd78af_0"
    publishDir "${params.results}/make-multiqc-report", mode: "copy"

    input:
        tuple val(id), val(fastqc_report_directories)

    output:
        path("${id}-multiqc-report/")

    script:
        """
        mkdir ${id}-fastqc-reports
        cp ${fastqc_report_directories} ${id}-fastqc-reports/

        mkdir ${id}-multiqc-report
        multiqc \
            -o ${id}-multiqc-report/ \
            ${id}-fastqc-reports/
        """

}