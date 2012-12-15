exports.trying (block) every (interval) seconds =
    {
        succeeds within (tries) tries (success) =
            {
                otherwise (error) =
                    anticipate (block, tries, interval, success, error)
            }
    }

anticipate (block, tries, interval, on success, on error) =
    attempt (error, result) =
        if (error)
            fail (error)
        else
            try
                on success (result)
            catch (error)
                on error (error)

    fail (error) =
        if (tries == 1)
            on error (error)
        else if (tries > 1)
            iterate () = anticipate (block, tries - 1, interval, on success, on error)
            set timeout (iterate, interval * 1000)
                    
    try
        block (attempt)
    catch (error)
        fail (error)
