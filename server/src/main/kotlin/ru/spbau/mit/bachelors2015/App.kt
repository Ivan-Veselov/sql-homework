package ru.spbau.mit.bachelors2015

class Server(database: DataBaseManager) {
    // TODO
}

class DullDataBaseManager : DataBaseManager {
    private val athletes: List<Athlete> = TODO("not implemented")

    private val volunteers: List<Volunteer> = TODO("not implemented")

    private val accommodations: List<Accommodation> = TODO("not implemented")

    override fun allAthletes(accommodationId: Int?): List<AthleteBrief> {
        TODO("not implemented")
    }

    override fun allAccommodations(): List<AccommodationBrief> {
        TODO("not implemented")
    }

    override fun allVolunteers(): List<AccommodationBrief> {
        TODO("not implemented")
    }

    override fun getAthlete(athleteId: Int): Athlete {
        TODO("not implemented")
    }

    override fun getAccommodation(accommodationId: Int): Accommodation {
        TODO("not implemented")
    }

    override fun getVolunteer(volunteerId: Int): Volunteer {
        TODO("not implemented")
    }

    override fun setAthleteInfo(athleteId: Int, accommodationId: Int, volunteerId: Int) {
    }
}

fun main(args: ArrayList<String>) {
    TODO("not implemented")
}
