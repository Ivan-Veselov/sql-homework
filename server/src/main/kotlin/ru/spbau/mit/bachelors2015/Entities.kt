package ru.spbau.mit.bachelors2015

data class AthleteBrief(private val id: Int, private val name: String)

data class Athlete(
    private val name: String,
    private val sex: String,
    private val height: Int,
    private val weight: Int,
    private val age: Int,
    private val accommodation: AccommodationBrief?,
    private val country: String,
    private val volunteer: VolunteerBrief?
) {
    fun brief(id: Int) : AthleteBrief {
        return AthleteBrief(id, name)
    }
}

data class AccommodationBrief(
    private val id: Int,
    private val street: String,
    private val houseNumber: Int
)

data class Accommodation(
    private val street: String,
    private val houseNumber: Int,
    private val type: String,
    private val name: String?
) {
    fun brief(id: Int) : AccommodationBrief {
        return AccommodationBrief(id, street, houseNumber)
    }
}

data class VolunteerBrief(private val id: Int, private val name: String)

data class Volunteer(private val name: String, private val telephoneNumber: String) {
    fun brief(id: Int) : VolunteerBrief {
        return VolunteerBrief(id, name)
    }
}
