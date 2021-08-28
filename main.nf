#!/usr/bin/env nextflow


//pacB='s3://wgs.algae.hifi/30-536540905/rawdata/fastX/CHK22.subreads.fastq.gz'



/*
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


*/


seqtk='s3://pipe.scratch.3/work/ac/874c9065784992f1a14aec29c5a131/pacb.fq.gz'

process Hifiasm {
  memory '512G'


  input:
  path pb from seqtk
  
  output:
  file '*.gfa' into asm_alleles
  
  """
  hifiasm -o CHK22 -t128 $pb
  """

}
