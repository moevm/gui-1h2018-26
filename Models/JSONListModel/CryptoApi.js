function makeGetRequest(url, callback)
{
    getRequest(url, callback, true);
}

function makeSyncGetRequest(url, callback)
{
    getRequest(url, callback, false);
}

function getRequest(url, callback, async){
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.DONE) {
            var response = doc.responseText;
            callback(response);
        }
    }
    doc.open("GET", url, async);
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

function getCurrentPrice(baseCoin, targetCoin, callback){
    var request = "https://min-api.cryptocompare.com/data/price?fsym="
            + baseCoin + "&tsyms=" + targetCoin;
    makeGetRequest(request, callback);
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

function getFromBaseToTargetFullInfo(baseCoins, targetCoin, callback){
    var request = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms="+baseCoins+"&tsyms="+targetCoin;
    makeGetRequest(request, callback);
}

function getGeneratedCustomAverage(baseCoin, targetCoin, exchange, callback){
    var request = "https://min-api.cryptocompare.com/data/generateAvg?fsym="+baseCoin+"&tsym="+ targetCoin +"&e=" + exchange;
    makeGetRequest(request, callback);
}

function getFeedsAndCategories(callback){
    var request = "https://min-api.cryptocompare.com/data/news/categories";
    makeGetRequest(request, callback);
}

function getFeedByCategory(catergory, callback){
    var request = "https://min-api.cryptocompare.com/data/news/?categories=" + catergory;
    makeGetRequest(request, callback);
}
