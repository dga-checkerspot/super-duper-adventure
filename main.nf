#!/usr/bin/env nextflow


params.pacB='s3://wgs.algae.hifi/30-536540905/rawdata/fastX/CHK22.subreads.fastq.gz'

pBiodata = Channel.fromPath(params.pacB)

process Hifiasm {

  memory '128G'


  input:
  path pb from pBiodata
  
  output:
  file '*.gfa' into asm_alleles
  
  """
  ./hifiasm -o CHK22 -t4 -f0 $pb 2> test.log
  """

}
