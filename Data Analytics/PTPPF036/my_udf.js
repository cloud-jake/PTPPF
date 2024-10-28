function transform(element) {
    var obj = JSON.parse(element)
    var result = {}
    if (obj.review == "positive")
       result.points = 1
    else
       result.points = 0
    result.url = obj.url
    return JSON.stringify(result);
}