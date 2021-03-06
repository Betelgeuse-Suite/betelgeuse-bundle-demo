"use strict";
exports.__esModule = true;
var toVersion = function (v) {
    if (isValidStringVersion(v)) {
        throw "The given string: " + v + " is not a valid version!";
    }
    var _a = v.split('.'), major = _a[0], minor = _a[1], patch = _a[2];
    return {
        major: Number(major),
        minor: Number(minor),
        patch: Number(patch)
    };
};
var isValidStringVersion = function (v) {
    var _a = v.split('.'), major = _a[0], minor = _a[1], patch = _a[2];
    return !(isNumeric(major) && isNumeric(minor) && isNumeric(patch));
};
function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}
var toString = function (v) {
    v = v || {
        major: -1,
        minor: -1,
        patch: -1
    };
    return v.major + "." + v.minor + "." + v.patch;
};
var now = function () { return (new Date()).getTime(); };
var DataStore = (function () {
    function DataStore(storage) {
        this.storage = storage;
        this.KEY = '__betelgeuse__data';
    }
    DataStore.prototype.update = function (version, data) {
        this.storage.setItem(this.KEY, JSON.stringify({
            version: toString(version),
            updated_at: now(),
            data: data
        }));
    };
    DataStore.prototype.getCurrent = function () {
        try {
            var json = JSON.parse(this.storage.getItem(this.KEY) || '');
            return {
                data: json.data,
                version: toVersion(json.version),
                updatedAt: new Date(json.updated_at)
            };
        }
        catch (e) {
            return undefined;
        }
    };
    return DataStore;
}());
var store = new DataStore(window.localStorage);
var getCurrentVersion = function () {
    return (store.getCurrent() || { version: toVersion('12.0.3') }).version;
};
exports.getModel = function () {
    var cached = store.getCurrent();
    if (cached) {
        return cached.data;
    }
    var json = require('./Data.json');
    store.update(toVersion('12.0.3'), json);
    return json;
};
(function (window, URL, VERSION) {
    console.log('Current version:', toString(VERSION));
    var document = window.document;
    var compareVersions = function (vA, vB) {
        if (isEqualVersion(vA, vB)) {
            return 0;
        }
        else if (isNewerVersion(vA, vB)) {
            return -1;
        }
        return 1;
    };
    var isEqualVersion = function (vA, vB) {
        return vA.major === vB.major
            && vA.minor === vB.minor
            && vA.patch === vB.patch;
    };
    var isNewerVersion = function (vA, vB) {
        return vB.major > vA.major
            || vB.major === vA.major && vB.minor > vA.minor
            || vB.major === vA.major && vB.minor === vA.minor && vB.patch > vA.patch;
    };
    var isNonBreakingReleaseVersion = function (vA, vB) {
        return vA.major === vB.major;
    };
    var getJSONP = function (url, success) {
        var script = document.createElement('script'), head = document.getElementsByTagName('head')[0]
            || document.documentElement;
        window.__betelgeuse__getJSONP = function (data) {
            head.removeChild(script);
            success && success(data);
        };
        script.src = url;
        head.appendChild(script);
    };
    var sortVersionsDesc = function (vv) {
        if (vv === void 0) { vv = []; }
        return vv.sort(function (a, b) { return compareVersions(b, a); });
    };
    var onlyNewerAndNonBreakingVersions = function (vv) { return vv
        .filter(function (v) {
        return isNewerVersion(VERSION, v) && isNonBreakingReleaseVersion(VERSION, v);
    }); };
    var getBestVersion = function (vv) {
        return sortVersionsDesc(onlyNewerAndNonBreakingVersions(vv))[0];
    };
    var cacheTimestamp = function (seconds) {
        return '?at=' + Math.floor(now() / (seconds * 1000));
    };
    var versionsJsonURL = URL + '/master/versions.js' + cacheTimestamp(60);
    var getDataUrl = function (version) {
        return URL + "/v" + toString(version) + "/.bin/Data.js";
    };
    console.log('Attempting to fetch json from', versionsJsonURL);
    getJSONP(versionsJsonURL, function (data) {
        var allVersions = Object
            .keys(data)
            .map(toVersion);
        var bestVersion = getBestVersion(allVersions);
        if (bestVersion) {
            console.log('New version found:', toString(bestVersion));
            console.log('Loading', getDataUrl(bestVersion));
            getJSONP(getDataUrl(bestVersion), function (data) {
                console.log('Data', toString(bestVersion), ':', data);
                store.update(bestVersion, data);
            });
        }
        else {
            console.log('Nothing new! Current Version:', toString(VERSION));
        }
    });
})(window, 'https://rawgit.com/GabrielCTroia/betelgeuse-bundle-demo', getCurrentVersion());
