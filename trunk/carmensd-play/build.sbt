import sbt._
import Keys._

name := """carmensd-play"""

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayJava)

scalaVersion := "2.11.1"

libraryDependencies ++= Seq(
  javaJdbc,
  javaEbean,
  cache,
  javaWs,
 "unq.ciu.tp" % "carmensd.domain" % "0.0.1-SNAPSHOT"
)

//Esto deberia ser setteado para cada integrante del equipo
resolvers += ("Local Maven" at "file:///C:/Users/Home/.m2/repository")
//resolvers += ("Local Maven" at "file:////Users/alejandrok/.m2/repository")

