import org.warcbase.spark.rdd.RecordRDD._
import org.warcbase.spark.matchbox.RecordLoader
import org.warcbase.spark.matchbox.ExtractGraph

val recs = RecordLoader.loadArchives("/mnt/vol1/data_sets/cpp/cpp_warcs_accession_01/partner.archive-it.org/cgi-bin/getarcs.pl/*", sc) 

val graph = ExtractGraph(recs)
graph.writeAsJson("nodes-all-CPP-accession-1", "links-all-CPP-accession-1")