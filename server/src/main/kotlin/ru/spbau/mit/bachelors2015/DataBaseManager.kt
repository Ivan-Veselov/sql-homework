package ru.spbau.mit.bachelors2015

import java.sql.Connection
import java.sql.DriverManager
import java.sql.Types
import kotlin.coroutines.experimental.buildSequence

interface DataBaseManager {
    fun allAthletes(accommodationId: Int?) : List<AthleteBrief>

    fun allAccommodations() : List<AccommodationBrief>

    fun allVolunteers() : List<VolunteerBrief>

    fun getAthlete(athleteId: Int) : Athlete

    fun getAccommodation(accommodationId: Int) : Accommodation

    fun getVolunteer(volunteerId: Int) : Volunteer

    fun setAthleteInfo(athleteId: Int, accommodationId: Int?, volunteerId: Int?)
}

class DataBaseManagerImpl(
        host: String = "localhost",
        port: Int = 5432,
        database: String = "postgres",
        user: String = "postgres",
        password: String = ""
) : DataBaseManager {

    private val connection: Connection = DriverManager.getConnection("jdbc:postgresql://$host:$port/$database", user, password)

    override fun allAthletes(accommodationId: Int?) : List<AthleteBrief> {
        val statement = """
            |SELECT id, name
            |   FROM athletes""".trimMargin()
                .let {
                    if (accommodationId == null) {
                        connection.prepareStatement(it)
                    } else {
                        connection.prepareStatement(it + "\nWHERE accomodation_id = ?").apply {
                            setInt(1, accommodationId)
                        }
                    }
                }
        return statement.executeQuery().use { rs ->
            buildSequence {
                while (rs.next()) {
                    val id = rs.getInt("id")
                    val name = rs.getString("name")
                    yield(AthleteBrief(id, name))
                }
            }.toList()
        }
    }

    override fun allAccommodations() : List<AccommodationBrief> {
        val statement = connection.prepareStatement("""
            |SELECT id, street, house_number
            |   FROM buildings
            |   """.trimMargin())
        return statement.executeQuery().use { rs ->
            buildSequence {
                while (rs.next()) {
                    val buildingId = rs.getInt("id")
                    val street = rs.getString("street")
                    val houseNumber = rs.getInt("house_number")
                    yield(AccommodationBrief(buildingId, street, houseNumber))
                }
            }.toList()
        }
    }

    override fun allVolunteers() : List<VolunteerBrief> {
        val statement = connection.prepareStatement("""
            |SELECT id, name
            |   FROM volunteers
            |   """.trimMargin())
        return statement.executeQuery().use { rs ->
            buildSequence {
                while (rs.next()) {
                    val id = rs.getInt("id")
                    val name = rs.getString("name")
                    yield(VolunteerBrief(id, name))
                }
            }.toList()
        }
    }

    override fun getAthlete(athleteId: Int) : Athlete {
        val statement = connection.prepareStatement("""
            |SELECT A.name, A.sex, A.height, A.weight, A.age,
            |       B.id AS building_id, B.street, B.house_number,
            |       C.name AS country,
            |       V.id AS volunteer_id, V.name AS volunteer
            |   FROM athletes A
            |   LEFT JOIN buildings B ON A.accomodation_id = B.id
            |   LEFT JOIN volunteers V ON A.volunteer_id = V.id
            |   JOIN delegations D ON A.delegation_id = D.id
            |   JOIN countries C ON D.country_id = C.id
            |   WHERE A.id = ?
            |   """.trimMargin())
                .apply { setInt(1, athleteId) }
        return statement.executeQuery().use { rs ->
            if (!rs.next()) {
                throw InvalidIdException(athleteId, "athletes")
            }
            val name = rs.getString("name")
            val sex = rs.getString("sex")
            val height = rs.getInt("height")
            val weight = rs.getInt("weight")
            val age = rs.getInt("age")
            val buildingId = rs.getInt("building_id")
            val street = rs.getString("street")
            val houseNumber = rs.getInt("house_number")
            val country = rs.getString("country")
            val volunteerId = rs.getInt("volunteer_id")
            val volunteer = rs.getString("volunteer")

            Athlete(name, sex, height, weight, age,
                    maybeAccommodationBrief(buildingId, street, houseNumber),
                    country,
                    maybeVolunteerBrief(volunteerId, volunteer))
        }
    }

    override fun getAccommodation(accommodationId: Int) : Accommodation {
        val statement = connection.prepareStatement("""
            |SELECT street, house_number, building_types.type AS type, name
            |   FROM buildings
            |   JOIN building_types ON buildings.type_id = building_types.id
            |   WHERE buildings.id = ?
            |   """.trimMargin())
                .apply { setInt(1, accommodationId) }
        return statement.executeQuery().use { rs ->
            if (!rs.next()) {
                throw InvalidIdException(accommodationId, "buildings")
            }
            val street = rs.getString("street")
            val houseNumber = rs.getInt("house_number")
            val type = rs.getString("type")
            val name = rs.getString("name")
            Accommodation(street, houseNumber, type, name)
        }
    }

    override fun getVolunteer(volunteerId: Int) : Volunteer {
        val statement = connection.prepareStatement("""
            |SELECT name, telephone_number
            |   FROM volunteers
            |   WHERE id = ?
            |   """.trimMargin())
                .apply { setInt(1, volunteerId) }
        return statement.executeQuery().use { rs ->
            if (!rs.next()) {
                throw InvalidIdException(volunteerId, "volunteers")
            }
            val name = rs.getString("name")
            val telephoneNumber = rs.getString("telephone_number")
            Volunteer(name, telephoneNumber)
        }
    }

    override fun setAthleteInfo(athleteId: Int, accommodationId: Int?, volunteerId: Int?) {
        val statement = connection.prepareStatement("""
            |UPDATE athletes SET accomodation_id = ?, volunteer_id = ?
            |   WHERE id = ?
            |   """.trimMargin())
                .apply {
                    if (accommodationId != null) {
                        setInt(1, accommodationId)
                    } else {
                        setNull(1, Types.INTEGER)
                    }

                    if (volunteerId != null) {
                        setInt(2, volunteerId)
                    } else {
                        setNull(2, Types.INTEGER)
                    }

                    setInt(3, athleteId)
                }
        if (statement.executeUpdate() == 0) {
            throw InvalidIdException(athleteId, "athletes")
        }
    }


    private fun maybeAccommodationBrief(id: Int?, street: String?, houseNumber: Int?): AccommodationBrief? {
        return if (id != null && street != null && houseNumber != null) {
            AccommodationBrief(id, street, houseNumber)
        } else {
            null
        }
    }

    private fun maybeVolunteerBrief(id: Int?, name: String?): VolunteerBrief? {
        return if (id != null && name != null) {
            VolunteerBrief(id, name)
        } else {
            null
        }
    }
}
