process PREPARE_ID {
    cpus 1
    memory "2 GB"
    container "MicroOceLab/python:1.0"

    input:
        val(sequences)
    
    output:
        tuple eval("echo \${ID}"), val(sequences)

    script:
        """
        ID=`${params.prepare_id_method}.py ${sequences}`
        """
}