package ru.spbau.mit.bachelors2015

import com.google.gson.GsonBuilder
import spark.Request
import spark.Response
import spark.Spark

fun Request.getIntParam(name: String) : Int? {
    val param = this.queryParams(name) ?: return null

    try {
        return param.toInt()
    } catch (_: NumberFormatException) {
        throw IntParsingException(param)
    }
}

fun Request.getRequiredIntParam(name: String) : Int {
    return this.getIntParam(name) ?: throw NoRequiredParamException(name)
}

fun Request.getOptionalIntParam(name: String) : Int? {
    return this.getIntParam(name)
}

class Server(database: DataBaseManager) {
    private val serverPort = 8080

    private val jsonSerializer = GsonBuilder().serializeNulls().create()

    private val sportsmanAll: (Request, Response) -> Any? = {
        request, _ ->
        val accommodationId = request.getOptionalIntParam("accommodation_id")

        database.allAthletes(accommodationId)
    }

    private val accommodationAll: (Request, Response) -> Any? = {
        _, _ -> database.allAccommodations()
    }

    private val volunteerAll: (Request, Response) -> Any? = {
        _, _ -> database.allVolunteers()
    }

    private val sportsmanGet: (Request, Response) -> Any? = {
        request, _ ->
        val athleteId = request.getRequiredIntParam("id")

        database.getAthlete(athleteId)
    }

    private val accommodationGet: (Request, Response) -> Any? = {
        request, _ ->
        val accommodationId = request.getRequiredIntParam("id")

        database.getAccommodation(accommodationId)
    }

    private val volunteerGet: (Request, Response) -> Any? = {
        request, _ ->
        val volunteerId = request.getRequiredIntParam("id")

        database.getVolunteer(volunteerId)
    }

    private val sportsmanSet: (Request, Response) -> Any? = lambda@ {
        request, _ ->

        val athleteId = request.getRequiredIntParam("id")
        val accommodationId = request.getOptionalIntParam("accommodation_id")
        val volunteerId = request.getOptionalIntParam("volunteer_id")

        database.setAthleteInfo(athleteId, accommodationId, volunteerId)

        return@lambda null // todo: is that necessary?
    }

    fun run() {
        init()

        Spark.path("/sportsman") {
            safeGet("/all", sportsmanAll)
            safeGet("/get", sportsmanGet)
            safeGet("/set", sportsmanSet)
        }

        Spark.path("/accommodation") {
            safeGet("/all", accommodationAll)
            safeGet("/get", accommodationGet)
        }

        Spark.path("/volunteer") {
            safeGet("/all", volunteerAll)
            safeGet("/get", volunteerGet)
        }
    }

    private fun init() {
        Spark.exception<Exception>(Exception::class.java) { e, _, _ ->
            e.printStackTrace()
        }

        Spark.staticFiles.location("/public")
        Spark.port(serverPort)
    }

    private fun safeGet(path: String, route: (Request, Response) -> Any?) {
        Spark.get(path) { request, response ->
            val objectToSend = try {
                OrdinaryResponse(route(request, response))
            } catch (e: InvalidQueryException) {
                ErrorResponse(e.message ?: "Unknown error")
            }

            jsonSerializer.toJson(objectToSend)
        }
    }

    private abstract class ServerResponse {
        abstract val type: String
    }

    private class OrdinaryResponse(val result: Any?) : ServerResponse() {
        override val type: String = "success"
    }

    private class ErrorResponse(val message: String) : ServerResponse() {
        override val type: String = "error"
    }
}
