// Default module imports
include { MAKE_FASTQC_REPORT  } from '../modules/make-fastqc-report'
include { MAKE_MULTIQC_REPORT } from '../modules/make-multiqc-report'


workflow CHECK_READ_QUALITY {
    take:
        ch_reads
    
    main:
        MAKE_FASTQC_REPORT(ch_reads)
            .set {ch_fastqc_reports}
         
        Channel.of("combined")
            .set {ch_combined_id}

        MAKE_MULTIQC_REPORT(ch_combined_id
            .combine(ch_fastqc_reports
            .map {report -> report[1]}
            .map {report -> "${report}/*"}
            .reduce("") {report_1, report_2 -> "$report_1 $report_2"}))
            .set {ch_multiqc_report}
        
    emit:
        fastqc_reports = ch_fastqc_reports
        multiqc_report = ch_multiqc_report
}