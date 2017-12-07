package ru.spbau.mit.bachelors2015

interface DataBaseManager {
    fun allAthletes(accommodationId: Int?) : List<AthleteBrief>

    fun allAccommodations() : List<AccommodationBrief>

    fun allVolunteers() : List<AccommodationBrief>

    fun getAthlete(athleteId: Int) : Athlete

    fun getAccommodation(accommodationId: Int) : Accommodation

    fun getVolunteer(volunteerId: Int) : Volunteer

    fun setAthleteInfo(athleteId: Int, accommodationId: Int, volunteerId: Int)
}

object DataBaseManagerImpl : DataBaseManager {
    override fun allAthletes(accommodationId: Int?) : List<AthleteBrief> {
        TODO("not implemented")
    }

    override fun allAccommodations() : List<AccommodationBrief> {
        TODO("not implemented")
    }

    override fun allVolunteers() : List<AccommodationBrief> {
        TODO("not implemented")
    }

    override fun getAthlete(athleteId: Int) : Athlete {
        TODO("not implemented")
    }

    override fun getAccommodation(accommodationId: Int) : Accommodation {
        TODO("not implemented")
    }

    override fun getVolunteer(volunteerId: Int) : Volunteer {
        TODO("not implemented")
    }

    override fun setAthleteInfo(athleteId: Int, accommodationId: Int, volunteerId: Int) {
        TODO("not implemented")
    }
}
