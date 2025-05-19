include { SHOTGUN_METAGENOMICS } from './workflows/shotgun-metagenomics'

workflow {
    main:
        SHOTGUN_METAGENOMICS()
}