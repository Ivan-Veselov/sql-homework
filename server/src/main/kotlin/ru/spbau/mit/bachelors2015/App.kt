package ru.spbau.mit.bachelors2015

import com.google.gson.GsonBuilder
import spark.Request
import spark.Response
import spark.Spark.*

fun Request.getIntParam(name: String) : Int? {
    return try {
        this.queryParams(name)?.toInt()
    } catch(_: NumberFormatException) {
        null
    }
}

// todo: error responses for incorrect api usage
class Server(database: DataBaseManager) {
    private val serverPort = 8080

    private val jsonSerializer = GsonBuilder().serializeNulls().create()

    private val sportsmanAll: (Request, Response) -> Any? = {
        request, _ ->
        val accommodationId = request.getIntParam("accommodation_id")
        val athletes = database.allAthletes(accommodationId)

        jsonSerializer.toJson(athletes)
    }

    private val accommodationAll: (Request, Response) -> Any? = {
        _, _ -> jsonSerializer.toJson(database.allAccommodations())
    }

    private val volunteerAll: (Request, Response) -> Any? = {
        _, _ -> jsonSerializer.toJson(database.allVolunteers())
    }

    private val sportsmanGet: (Request, Response) -> Any? = {
        request, _ ->
        val athleteId = request.getIntParam("id")
        val athlete = athleteId?.let { database.getAthlete(it) }

        jsonSerializer.toJson(athlete)
    }

    private val accommodationGet: (Request, Response) -> Any? = {
        request, _ ->
        val accommodationId = request.getIntParam("id")
        val accommodation = accommodationId?.let { database.getAccommodation(it) }

        jsonSerializer.toJson(accommodation)
    }

    private val volunteerGet: (Request, Response) -> Any? = {
        request, _ ->
        val volunteerId = request.getIntParam("id")
        val volunteer = volunteerId?.let { database.getVolunteer(it) }

        jsonSerializer.toJson(volunteer)
    }

    private val sportsmanSet: (Request, Response) -> Any? = {
        request, _ ->

        val athleteId = request.getIntParam("id")
        val accommodationId = request.getIntParam("accommodation_id")
        val volunteerId = request.getIntParam("volunteer_id")

        if (athleteId != null) {
            database.setAthleteInfo(athleteId, accommodationId, volunteerId)
        }

        // response.redirect("/all") // todo: looks weird; don't understand what this is
        null
    }

    fun run() {
        init()

        get("/sportsman/all", sportsmanAll)
        get("/accommodation/all", accommodationAll)
        get("volunteer/all", volunteerAll)
        get("/sportsman/get", sportsmanGet)
        get("/accommodation/get", accommodationGet)
        get("/volunteer/get", volunteerGet)
        get("/sportsman/set", sportsmanSet)
    }

    private fun init() {
        exception<Exception>(Exception::class.java) {
            e, _, _ -> e.printStackTrace()
        }

        // staticFiles.location("/public") todo: set location for html files
        port(serverPort)
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
            throw InvalidIdException()
        }
    }

    override fun getAccommodation(accommodationId: Int): Accommodation {
        return accommodations.getOrElse(accommodationId - 1) {
            throw InvalidIdException()
        }
    }

    override fun getVolunteer(volunteerId: Int): Volunteer {
        return volunteers.getOrElse(volunteerId - 1) {
            throw InvalidIdException()
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
    Server(DullDataBaseManager()).run()
}
