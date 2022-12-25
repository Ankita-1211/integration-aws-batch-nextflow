process MULTIQC {
    publishDir "$params.output_dir/multiqc", mode:'copy'
       
    input:
    path (inputfiles)
    
    output:
    path 'multiqc_report.html'
     
    script:
    """
    multiqc . 
    """
} 
