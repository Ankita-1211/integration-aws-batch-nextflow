process FASTQC {

    tag "${sampleName}"

    publishDir "$params.output_dir/fastqc", mode: "copy"

    input:
        tuple val(sampleName), path(reads)

    output:
        path("*"), emit: fastqc_html_ch

    script:

        """
        fastqc $reads
        
        """

}
