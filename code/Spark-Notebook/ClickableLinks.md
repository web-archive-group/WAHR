import org.warcbase.spark.matchbox._
import org.warcbase.spark.rdd.RecordRDD._

def createClickableLink(url: String, date: String): String = {
   "<a href='http://web.archive.org/web/" + date + "/" + url + "'>" +
url + "</a>"
}

val r =
RecordLoader.loadArc("/Users/jimmylin/arc/227-20051004191331-00000-crawling015.archive.org.arc.gz",
sc)
   .keepValidPages()
   .map(r => {
          val t = ExtractRawText(r.getBodyContent)
          val len = 100
          (r.getCrawldate, createClickableLink(r.getUrl,
r.getCrawldate), if ( t.length > len ) t.substring(0, len) else t)})
   .collect()

