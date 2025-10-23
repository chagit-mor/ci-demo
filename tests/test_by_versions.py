def test_greet(lang):

    match lang:
        case "he":
            return "שלום"
        case "en":
            return "Hello"
    return None
