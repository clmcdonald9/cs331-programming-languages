pa2 = {}

function pa2.arrayFilter(p, t)

    local resultArr = {}
    local resultIndex = 1

    for i, value in ipairs(t) do
        if p(value) == true then
            resultArr[resultIndex] = value
            resultIndex = resultIndex + 1
        end
    end

    return resultArr

end

function pa2.mostCommon(str, num)
    if str == "" or num == 0 then
        return ""
    end


    local strLength = str:len()
    local lastSubStr = strLength - num + 1

    local bestCount = 0
    local bestSub = ""

    local counts = {}
    local firstPosition = {}

    for i = 1, lastSubStr do
        currentSub = str:sub(i,i+num-1)
        
        if counts[currentSub] == nil then
            counts[currentSub] = 1
            firstPosition[currentSub] = i
        else
            counts[currentSub] = counts[currentSub] + 1
        end

        if counts[currentSub] > bestCount then
            bestCount= counts[currentSub]
            bestSub = currentSub
        elseif counts[currentSub] == bestCount then
            if firstPosition[currentSub] < firstPosition[bestSub] then
                bestSub = currentSub
            end
        end
    end
    
    
    return bestSub

end

function pa2.revSubstr(s)
    local totalLength = s:len()
    local r = s:reverse()
    local subS = ""

    for subLength = 0, totalLength do
        if subLength == 0 then
            coroutine.yield("")
        else
            for start = 1, totalLength-subLength+1 do
                subS = r:sub(start, start+subLength-1)
                coroutine.yield(subS)
            end
        end
    end

end

local function isEven(n)
    if n then
        if n%2 == 0 then
            return true
        else
            return false
        end
    end
end

function pa2.collatzSeq(k)
    local n = k

    local function iterator()
        local current = n
        if not n then
            return current
        end
        if n == 1 then
            n = nil
            return current
        end

        if isEven(n) then
            n = n/2
        else
            n = 3*n + 1
        end
        return current
    end

    return iterator

end

return pa2