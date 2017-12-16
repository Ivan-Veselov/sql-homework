package ru.spbau.mit.bachelors2015

fun main(args: Array<String>) {
    if (args.size > 1) {
        System.err.println("Invalid number of arguments")
        return
    }

    if (args.size == 1) {
        val port = try {
            args.first().toInt()
        } catch (_: NumberFormatException) {
            System.err.println("Unable to parse first argument as port")
            return
        }

        Server(DataBaseManagerImpl(port = port)).run()
    } else {
        Server(DataBaseManagerImpl()).run()
    }
}
