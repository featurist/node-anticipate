(function() {
    var self = this;
    var anticipate;
    exports.tryingEverySeconds = function(block, interval) {
        var self = this;
        return {
            succeedsWithinTries: function(tries, success) {
                var self = this;
                return {
                    otherwise: function(error) {
                        var self = this;
                        return anticipate(block, tries, interval, success, error);
                    }
                };
            }
        };
    };
    anticipate = function(block, tries, interval, onSuccess, onError) {
        var attempt, fail;
        attempt = function(error, result) {
            if (error) {
                return fail(error);
            } else {
                try {
                    return onSuccess(result);
                } catch (error) {
                    return onError(error);
                }
            }
        };
        fail = function(error) {
            var iterate;
            if (tries === 1) {
                return onError(error);
            } else if (tries > 1) {
                iterate = function() {
                    return anticipate(block, tries - 1, interval, onSuccess, onError);
                };
                return setTimeout(iterate, interval * 1e3);
            }
        };
        try {
            return block(attempt);
        } catch (error) {
            return fail(error);
        }
    };
}).call(this);