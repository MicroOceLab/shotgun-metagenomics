// Error checks


// Default module imports
include { PREPARE_ID } from '../modules/prepare-id'

// Default subworkflow imports
include { CHECK_READ_QUALITY  } from '../subworkflows/check-read-quality.nf'


// Pipeline workflow
workflow SHOTGUN_METAGENOMICS {
    main:
        Channel.fromPath("./${params.data}/*.fastq")
            .set {ch_reads}

        PREPARE_ID(ch_reads)
            .set {ch_reads_with_id}

        
}
