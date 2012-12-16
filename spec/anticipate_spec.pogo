anticipate = require '../src/anticipate'

describe 'anticipate'
    
    started at = nil
    
    before each
        started at := new (Date())
    
    (n) seconds should have elapsed =
        roughly (n * 1000) ms should have elapsed since (started at)
    
    roughly (ms) ms should have elapsed since (start) =
        now = new (Date())
        elapsed ms = now.get time() - started at.get time()
        elapsed ms.should.be.within(ms - 20, ms + 20)
    
    it 'calls a block repeatedly until it stops yielding errors' @(done)        
        attempts = 0
        block (callback) =
            attempts := attempts + 1
            if (attempts == 3)
                callback (nil, "finally!")
            else
                callback "not yet..."
        
        anticipate.trying (block) every 0.1 seconds for 3 tries @(result)
            result.should.equal "finally!"
            attempts.should.equal 3
            0.2 seconds should have elapsed
            done ()
        else (done)

    it 'calls the error callback if the block never stops yielding errors' @(done)        
        attempts = 0
        block (callback) =
            attempts := attempts + 1
            callback "not stopping..."
        
        anticipate.trying (block) every 0.1 seconds for 3 tries @(result)
            done "this shouldn't happen"
        else @(err)
            err.should.equal "not stopping..."
            attempts.should.equal 3
            0.2 seconds should have elapsed
            done ()

    it 'calls the error callback if the block throws' @(done)        
        attempts = 0
        block (callback) =
            attempts := attempts + 1
            throw "oops"
        
        anticipate.trying (block) every 0.1 seconds for 3 tries @(result)
            done "this shouldn't happen"
        else @(err)
            err.should.equal "oops"
            attempts.should.equal 3
            0.2 seconds should have elapsed
            done ()