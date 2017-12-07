package ru.spbau.mit.bachelors2015

data class AthleteBrief(val id: Int, val name: String)

data class Athlete(
    val name: String,
    val sex: String,
    val height: Int,
    val weight: Int,
    val age: Int,
    val accommodation: AccommodationBrief?,
    val country: String,
    val volunteer: VolunteerBrief?
) {
    fun brief(id: Int) : AthleteBrief {
        return AthleteBrief(id, name)
    }
}

data class AccommodationBrief(
    val id: Int,
    val street: String,
    val houseNumber: Int
)

data class Accommodation(
    val street: String,
    val houseNumber: Int,
    val type: String,
    val name: String?
) {
    fun brief(id: Int) : AccommodationBrief {
        return AccommodationBrief(id, street, houseNumber)
    }
}

data class VolunteerBrief(val id: Int, val name: String)

data class Volunteer(val name: String, val telephoneNumber: String) {
    fun brief(id: Int) : VolunteerBrief {
        return VolunteerBrief(id, name)
    }
}
