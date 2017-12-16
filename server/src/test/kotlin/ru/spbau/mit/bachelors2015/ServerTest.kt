package ru.spbau.mit.bachelors2015

import org.junit.Assert.*

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

class ServerTest