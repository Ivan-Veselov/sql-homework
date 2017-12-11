let all_sportsmen = [
    {
        "id": 1,
        "name": "LeBron James"
    },
    {
        "id": 2,
        "name": "Dwyane Wade"
    },
    {
        "id": 3,
        "name": "Serena Williams"
    }
];

let all_accommodations = [
    {
        "id": 1,
        "street": "Academy Street",
        "house_number": 42
    },
    {
        "id": 2,
        "street": "Jefferson Avenue",
        "house_number": 228
    },
    {
        "id": 3,
        "street": "Church Road",
        "house_number": 69
    }
];

let all_volunteers = [
    {
        "id": 1,
        "name": "Hagar Broz"
    },
    {
        "id": 2,
        "name": "Zviad Levitt"
    },
    {
        "id": 3,
        "name": "Breeshey Colón"
    }
];

let get_sportsman = {
    "name": "LeBron James",
    "sex": "male",
    "height": 203,
    "weight": 113,
    "age": 32,
    "accommodation": {
        "id": 1,
        "street": "Academy Street",
        "house_number": 42
    },
    "country": "USA",
    "volunteer": {
        "id": 1,
        "name": "Hagar Broz"
    }
};

let get_accommodation = {
    "street": "Academy Street",
    "house_number": 42,
    "type": "hotel",
    "name": "Sun Heaven"
};

let get_volunteer = {
    "name": "Hagar Broz",
    "telephone_number": "+7 999 2286942"
};

module.exports = {
    all_volunteers,
    all_accommodations,
    all_sportsmen,
    get_accommodation,
    get_sportsman,
    get_volunteer
};
