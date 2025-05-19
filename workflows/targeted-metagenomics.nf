// Error checks


// Default module imports
include { ### } from '../modules/###'


// Pipeline workflow
workflow SHOTGUN_METAGENOMICS {
    main:
        Channel.fromPath("./${params.data}/*.fastq")
            .set {ch_reads}
}
