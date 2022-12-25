include { FASTQC } from './modules/fastqc.nf' 
include { MULTIQC } from './modules/multiqc.nf' 

log.info """\
         BASIC FASTQ FILE QC - N F   P I P E L I N E
         ============================================
         input_reads_path        : ${params.input_dir}
         output_dir              : ${params.output_dir}
         """
         .stripIndent()
         
if (params.help) {
    log.info 'This is BASIC FASTQ FILE QC Pipeline'
    log.info 'Please define input_reads_path and output_dir!\n'
    log.info '\n'
    exit 1
}         

workflow {
  
  reads_ch = Channel.fromFilePairs("$params.input_dir/*{1,2}.fastq.gz")
  
  fastqc_ch = FASTQC(reads_ch)
  
  MULTIQC(fastqc_ch)
  
}

workflow.onComplete {

    println ( workflow.success ? """
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
    )
}
