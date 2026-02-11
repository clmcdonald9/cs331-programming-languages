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
        currentSub = string.sub(str,i,i+num-1)
        
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

function pa2.revsubstr()

end

function pa2.collatzSeq()

end

return pa2