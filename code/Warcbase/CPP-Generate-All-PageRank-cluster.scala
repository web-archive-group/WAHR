/* spark-shell --jars ~/warcbase/target/warcbase-0.1.0-SNAPSHOT-fatjar.jar --num-executors 75 --executor-cores 5 --executor-memory 15G --driver-memory 30G */

import org.warcbase.spark.rdd.RecordRDD._
import org.warcbase.spark.matchbox.RecordLoader
import org.warcbase.spark.matchbox.ExtractGraph

val a=RecordLoader.loadArchives("/collections/webarchives/CanadianPoliticalParties/arc", sc)
var b=RecordLoader.loadArchives("/collections/webarchives/CanadianPoliticalParties/warc", sc)

var recs=a.union(b)

val graph = ExtractGraph(recs)
graph.writeAsJson("nodes-cpp-all", "links-cpp-all")
