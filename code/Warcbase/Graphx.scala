import org.warcbase.spark.rdd.RecordRDD._
import org.warcbase.spark.matchbox.RecordLoader
import org.warcbase.spark.matchbox.ExtractGraph

val recs = RecordLoader.loadArchives("/mnt/vol1/data_sets/cpp/cpp_warcs_accession_02/ARCHIVEIT-227-QUARTERLY-JOB182047-20151107015024751-00004.warc.gz", sc) 
ExtractGraph(recs, "nodes", "links")
