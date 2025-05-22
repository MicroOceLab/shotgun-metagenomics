// Error checks


// Default module imports
include { PREPARE_ID } from '../modules/prepare-id'
include { TRIM_READS } from '../modules/trim-reads'

// Default subworkflow imports
include { CHECK_READ_QUALITY  } from '../subworkflows/check-read-quality.nf'


// Pipeline workflow
workflow SHOTGUN_METAGENOMICS {
    main:
        Channel.fromPath("./${params.data}/*.fastq")
            .set {ch_reads}

        PREPARE_ID(ch_reads)
            .set {ch_reads_with_id}

        ch_reads_with_id
            .branch { reads ->
                forward_reads: reads[1] =~ /${params.f_read}/
                reverse_reads: reads[1] =~ /${params.r_read}/
                other: true}
            .set {ch_separated}

        TRIM_READS(ch_separated.forward_reads
            .join(ch_separated.reverse_reads))
            .set {ch_trimmed}
        
        
}
