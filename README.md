# anticipate

Retries asynchronous functions until they succeed.

## Install

npm install anticipate

#### Example  ([PogoScript](http://github.com/featurist/pogoscript))
    
    anticipate = require 'anticipate'
    
    anticipate.trying @(callback)
        something unreliable (callback)
    every 0.1 seconds for 3 tries @(result)
        it worked (result)
    else @(error)
        oh noes (error)

#### Example  (JavaScript)
    
    anticipate = require('anticipate');
    
    anticipate.tryingEverySecondsForTriesElse(function(callback) {
        somethingUnreliable(callback);
    }, 0.1, 3, function(result) {
        itWorked(result);
    }, function(error) {
        ohNoes(error);
    });

#### License
BSD