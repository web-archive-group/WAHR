import org.warcbase.spark.rdd.RecordRDD._
import org.warcbase.spark.matchbox.RecordLoader
import org.warcbase.spark.matchbox.ExtractGraph

val recs = RecordLoader.loadArchives("/collections/webarchives/geocities/warcs/*", sc).keepUrlPatterns(Set("http://geocities.com/EnchantedForest/.*".r))
val graph = ExtractGraph(recs)
graph.writeAsJson("nodes-accession01-static", "links-accession01-static")
