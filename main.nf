#!/usr/bin/env nextflow


pacB='s3://wgs.algae.hifi/30-536540905/rawdata/fastX/CHK22.subreads.fastq.gz'


process seqtk {
  memory '12G'
  
  input:
  path pb from pacB
  
  output:
  file 'pacb.fq.gz' into seqtk
  
  """
  seqtk sample -s100 $pb 0.5 > pacb.fq 
  gzip pacb.fq
  
  """
  
 }





process Hifiasm {
  memory '256G'


  input:
  path pb from seqtk
  
  output:
  file '*.gfa' into asm_alleles
  
  """
  hifiasm -o CHK22 -t64 $pb
  """

}
