# anticipate

Retries asynchronous functions until they succeed.

## Install

npm install anticipate

#### Example  ([PogoScript](http://github.com/featurist/pogoscript))
    
    anticipate = require 'anticipate'
    
    anticipate.trying @(callback) every 0.1 seconds
        something flaky with (callback)
    .succeeds within 10 tries @(result)
        it worked (result)
    .otherwise @(error)
        oh noes (error)

#### Example  (JavaScript)
    
    anticipate = require('anticipate');
    
    anticipate.tryingEverySeconds(0.1, function(callback) {
        somethingFlakyWith(callback);
    }).succeedsWithinTries(10, function(result) {
        itWorked(result);
    }).otherwise(function(error) {
        ohNoes(error);
    });

#### License
BSD