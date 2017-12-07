package ru.spbau.mit.bachelors2015

class Server(database: DataBaseManager) {
    // TODO
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

    private val athletes: List<Athlete> =
        listOf(
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
        TODO("not implemented")
    }

    override fun allAccommodations(): List<AccommodationBrief> {
        TODO("not implemented")
    }

    override fun allVolunteers(): List<VolunteerBrief> {
        TODO("not implemented")
    }

    override fun getAthlete(athleteId: Int): Athlete? {
        return athletes.getOrNull(athleteId)
    }

    override fun getAccommodation(accommodationId: Int): Accommodation? {
        return accommodations.getOrNull(accommodationId)
    }

    override fun getVolunteer(volunteerId: Int): Volunteer? {
        return volunteers.getOrNull(volunteerId)
    }

    override fun setAthleteInfo(athleteId: Int, accommodationId: Int, volunteerId: Int) {
        TODO("not implemented")
    }
}

fun main(args: ArrayList<String>) {
    TODO("not implemented")
}
