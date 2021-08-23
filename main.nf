#!/usr/bin/env nextflow


params.pacBio='s3://wgs.algae.hifi/30-536540905/rawdata/fastX/CHK22.subreads.fastq.gz'

pacBio_data = Channel.fromPath(params.pacBio)

process Hifiasm {


  input:
  path pb from pacBio_data
  
  output:
  file '*.gfa' into asm_alleles
  
  """
  ./hifiasm -o CHK22 -t4 -f0 $pb 2> test.log
  """

}
