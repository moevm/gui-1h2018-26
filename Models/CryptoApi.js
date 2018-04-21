function makeGetRequest(url, callback)
{
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.DONE) {
            var response = doc.responseText;
            callback(response);
        }
    }
    doc.open("GET", url, true);
    doc.send();
}

function getAllExchangesList(callback) {
    var allExchangesUrl = "https://min-api.cryptocompare.com/data/all/exchanges";
    makeGetRequest(allExchangesUrl, callback);
}

function getAllCoins(callback) {
    var allCoinsUrl = "https://min-api.cryptocompare.com/data/all/coinlist";
    makeGetRequest(allCoinsUrl, callback);
}

function getCoinInfoByHours(baseCoin, targetCoin, hours, callback){
    var request = "https://min-api.cryptocompare.com/data/histohour?fsym="
            + baseCoin + "&tsym=" + targetCoin + "&limit=" + hours;
    makeGetRequest(request, callback);
}

function getCoinInfoByDays(baseCoin, targetCoin, days, callback){
    var request = "https://min-api.cryptocompare.com/data/histoday?fsym="
            + baseCoin + "&tsym=" + targetCoin + "&limit=" + days;
    makeGetRequest(request, callback);
}

function getCoinInfoByMinutes(baseCoin, targetCoin, minutes, callback){
    var request = "https://min-api.cryptocompare.com/data/histominutes?fsym="
            + baseCoin + "&tsym=" + targetCoin + "&limit=" + minutes;
    makeGetRequest(request, callback);
}

function getCoinInfoByTimestamp(baseCoin, targetCoin, timestamp, callback){
    var request = "https://min-api.cryptocompare.com/data/histominute?fsym="
            + baseCoin + "&tsym=" + targetCoin + "&ts=" + timestamp;
    makeGetRequest(request, callback);
}
