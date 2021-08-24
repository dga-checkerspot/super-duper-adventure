#!/usr/bin/env nextflow


pacB='s3://wgs.algae.hifi/30-536540905/rawdata/fastX/CHK22.subreads.fastq.gz'


process Hifiasm {
  cpus '8'
  memory '64G'


  input:
  path pb from pacB
  
  output:
  file '*.gfa' into asm_alleles
  
  """
  ./hifiasm -o CHK22 -t8 -f0 $pb 2> test.log
  """

}
