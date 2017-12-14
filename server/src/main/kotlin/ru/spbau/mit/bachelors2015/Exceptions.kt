package ru.spbau.mit.bachelors2015

abstract class InvalidQueryException(message: String) : Exception(message)

class NoRequiredParamException(
    paramName: String
) : InvalidQueryException("No required parameter '$paramName'")

class IntParsingException(
    probableInt: String
) : InvalidQueryException("Unable to parse int value: $probableInt")

class InvalidIdException(
    id: Int,
    tableName: String
) : InvalidQueryException("Invalid id for table '$tableName': $id")
