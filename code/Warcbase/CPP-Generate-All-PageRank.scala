/** Executed shell using /home/i2millig/spark-1.5.1/bin/spark-shell --driver-memory 60G --jars ~/warcbase/target/warcbase-0.1.0-SNAPSHOT-fatjar.jar. **/

import org.warcbase.spark.rdd.RecordRDD._
import org.warcbase.spark.matchbox.RecordLoader
import org.warcbase.spark.matchbox.ExtractGraph

val a=RecordLoader.loadArchives("/mnt/vol1/data_sets/cpp/cpp_arcs_accession_01/*", sc)
var b=RecordLoader.loadArchives("/mnt/vol1/data_sets/cpp/cpp_warcs_accession_01/partner.archive-it.org/cgi-bin/getarcs.pl/*", sc)
var c=RecordLoader.loadArchives("/mnt/vol1/data_sets/cpp/cpp_warcs_accession_02/*", sc)

var recs=a.union(b).union(c)

val graph = ExtractGraph(recs)
graph.writeAsJson("nodes-all", "links-all")
