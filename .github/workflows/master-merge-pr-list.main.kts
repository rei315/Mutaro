#!/usr/bin/env kotlin
@file:DependsOn("com.google.code.gson:gson:2.10")
@file:OptIn(ExperimentalStdlibApi::class)

import com.google.gson.Gson
import java.io.File
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse

val commentUrl = System.getenv("COMMENT_URL")
val githubToken = System.getenv("GITHUB_TOKEN")

val currentBranchName = System.getenv("GITHUB_HEAD_REF")
val command = "git log --pretty=format:‘%s’ --first-parent --merges origin/master..${currentBranchName}"
println(command)
val numbers = Runtime.getRuntime().exec(
    command,
    null,
    File(".")
).let { process ->
    process.errorStream.use { stream ->
        stream.bufferedReader().use { reader ->
            reader.lineSequence()
                .onEach { System.err.println(it) }
                .toList()
        }
    }

    process.inputStream.use { stream ->
        stream.bufferedReader().use { reader ->
            val regex = """Merge pull request #(\d.+?) """.toRegex()
            val notRegex = """Merge pull request #(\d.+?) from rei315/release""".toRegex()
            reader.lineSequence()
                .onEach { println(it) }
                .filterNot {
                    notRegex.find(it) != null
                }
                .mapNotNull {
                    regex.find(it)
                }
                .mapNotNull {
                    it.groupValues.getOrNull(1)
                }.toList()
        }
    }
}

data class Comment(val body: String)

val urls = numbers.map { number ->
    "${System.getenv("GITHUB_SERVER_URL")}/${System.getenv("GITHUB_REPOSITORY")}/pull/$number"
}
val comment = Comment(
    buildList {
        add("# Pull Request一覧")
        addAll(urls)
        add("```")
        addAll(urls)
        add("```")
    }.joinToString("\n")
)

val json = Gson().toJson(comment)
println(json)

val request = HttpRequest.newBuilder()
    .uri(URI.create(commentUrl))
    .header("Content-Type", "application/json")
    .header("Authorization", "token $githubToken")
    .POST(HttpRequest.BodyPublishers.ofString(json))
    .build()

val response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString())

println(response)
