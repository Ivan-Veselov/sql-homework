package ru.spbau.mit.bachelors2015

import com.google.gson.GsonBuilder
import spark.Request
import spark.Response
import spark.Spark.*
import com.google.gson.internal.bind.TypeAdapters.URL
import java.net.URLClassLoader


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

        // response.redirect("/all") // todo: looks weird; don't understand what this is
        return@lambda null // todo: is that necessary?
    }

    fun run() {
        init()

        path("/sportsman") {
            safeGet("/all", sportsmanAll)
            safeGet("/get", sportsmanGet)
            safeGet("/set", sportsmanSet)
        }

        path("/accommodation") {
            safeGet("/all", accommodationAll)
            safeGet("/get", accommodationGet)
        }

        path("/volunteer") {
            safeGet("/all", volunteerAll)
            safeGet("/get", volunteerGet)
        }
    }

    private fun init() {
        exception<Exception>(Exception::class.java) {
            e, _, _ -> e.printStackTrace()
        }

        staticFiles.location("/public")
        port(serverPort)
    }

    private fun safeGet(path: String, route: (Request, Response) -> Any?) {
        get(path) {
            request, response ->
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

class DullDataBaseManager : DataBaseManager {
    private val volunteers: List<Volunteer> =
        listOf(
            Volunteer(
                "Hagar Broz",
                "+7 999 2286942"
            ),
            Volunteer(
                "Zviad Levitt",
                "+7 666 6669666"
            ),
            Volunteer(
                "Breeshey Colón",
                "+7 000 9110000"
            )
        )

    private val accommodations: List<Accommodation> =
        listOf(
            Accommodation("Academy Street", 42, "hotel", "Sun Heaven"),
            Accommodation("Jefferson Avenue", 228, "hostel", null),
            Accommodation(
                "Church Road",
                69,
                "hutments",
                "A place for my head"
            )
        )

    private val athletes: MutableList<Athlete> =
        mutableListOf(
            Athlete(
                "LeBron James",
                "male",
                203,
                113,
                32,
                accommodations[0].brief(1),
                "USA",
                volunteers[0].brief(1)
            ),
            Athlete(
                "Dwyane Wade",
                "male",
                193,
                100,
                35,
                null,
                "USA",
                null
            ),
            Athlete(
                "Serena Williams",
                "female",
                175,
                90,
                36,
                null,
                "USA",
                volunteers[1].brief(2)
            )
        )

    override fun allAthletes(accommodationId: Int?): List<AthleteBrief> {
        return (1..athletes.size).filter {
            accommodationId == null || athletes[it - 1].accommodation?.id == accommodationId
        }.map { athletes[it - 1].brief(it) }
    }

    override fun allAccommodations(): List<AccommodationBrief> {
        return  (1..accommodations.size).map { accommodations[it - 1].brief(it) }
  }

    override fun allVolunteers(): List<VolunteerBrief> {
        return (1..volunteers.size).map { volunteers[it - 1].brief(it) }
    }

    override fun getAthlete(athleteId: Int): Athlete {
        return athletes.getOrElse(athleteId - 1) {
            throw InvalidIdException(athleteId, "athlete")
        }
    }

    override fun getAccommodation(accommodationId: Int): Accommodation {
        return accommodations.getOrElse(accommodationId - 1) {
            throw InvalidIdException(accommodationId, "accommodation")
        }
    }

    override fun getVolunteer(volunteerId: Int): Volunteer {
        return volunteers.getOrElse(volunteerId - 1) {
            throw InvalidIdException(volunteerId, "volunteer")
        }
    }

    override fun setAthleteInfo(athleteId: Int, accommodationId: Int?, volunteerId: Int?) {
        val pos = athleteId - 1
        val athlete = athletes[pos]
        val accommodation = accommodationId?.let { accommodations[it - 1].brief(it) }
        val volunteer = volunteerId?.let { volunteers[it - 1].brief(it) }

        athletes[pos] = Athlete(
            athlete.name,
            athlete.sex,
            athlete.height,
            athlete.weight,
            athlete.age,
            accommodation,
            athlete.country,
            volunteer
        )
    }
}

fun main(args: Array<String>) {
    // todo: replace dull manager with true one

    val cl = ClassLoader.getSystemClassLoader()

    val urls = (cl as URLClassLoader).getURLs()

    for (url in urls) {
        System.out.println(url.getFile())
    }

    Server(DullDataBaseManager()).run()
}
