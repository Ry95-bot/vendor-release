package io.sdkman.vendor.release

import java.util.concurrent.Executors

import org.mongodb.scala.bson.{BsonString, Document}

import scala.concurrent.ExecutionContext
import scala.language.implicitConversions

package object repos {

  implicit val mongoExecutionContext = ExecutionContext.fromExecutor(Executors.newFixedThreadPool(10))

  implicit def documentToCandidate(doc: Document): Candidate =
    Candidate(
      field("candidate", doc),
      field("name", doc),
      field("description", doc),
      field("default", doc),
      field("websiteUrl", doc),
      field("distribution", doc))

  implicit def documentToVersion(doc: Document): Version =
    Version(
      field("candidate", doc),
      field("version", doc),
      field("platform", doc),
      field("url", doc))

  private def field(n: String, d: Document) = d.get[BsonString](n).map(_.asString.getValue).get
}