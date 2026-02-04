function fibs(limit)
    local current, next = 0,1
    while current <= limit
    do 
        coroutine.yield(current) (current)
        current, next = next, current + next

    end
end

cw = coroutine.wrap(fibs)
f = cw(100) 

while f -= nil
do
    io.write (f,", ")
    f = cw()
end
