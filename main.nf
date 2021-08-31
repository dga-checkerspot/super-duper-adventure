#!/usr/bin/env nextflow


params.pacB='s3://wgs.algae.hifi/30-536540905/rawdata/fastX/CHK22.subreads.fastq.gz'

pacb_data = Channel.fromPath(params.pacB)

pacb_data.into{pacB_data1; pacB_data2; pacB_data3; pacB_data4}


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
 
 
 process seqkit {
  memory '48G'
  
  input:
  file pb from pacb_data
  
  output:
  file 'filt.fq' into seqkit
  
  """
  seqkit seq $pb -m 15000 > filt.fq
  """


*/



/*
process Hifiasm {
  memory '256G'


  input:
  path pb from pacB_data1
  
  output:
  file '*.gfa' into asm_alleles
  
  """
  hifiasm -o CHK22 -t180 $pb
  """

}

*/


process Raven {
  memory '256G'


  input:
  path pb from pacB_data2
  
  output:
  file 'raven.fasta' into raven_assembly
  
  """
  raven raven --weaken -t 96 $pb > raven.fasta
  """

}


process Canu {
  memory '256G'


  input:
  path pb from pacB_data3
  
  output:
  file './sub_canu/asm.contigs.fasta' into canu_assembly
  
  """
  canu -p asm -d sub_canu genomesize=19m -pacbio-hifi $pb 
  """

}


process Flye {
  memory '256G'


  input:
  path pb from pacB_data4
  
  output:
  file './pacb-flye/*.fasta' into raven_assembly
  
  """
  flye --pacbio-hifi $pb --out-dir pacb-flye --threads 96  --keep-haplotypes
  """

}






