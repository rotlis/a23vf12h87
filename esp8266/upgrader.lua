local M = {}

function M.upgrade(url)

    url = "http://192.168.2.200:1880/firmware";
    local headers = {"Authorization: Basic "..encoder.toBase64("admin:admin")}
    print(headers)
    http.get(url, headers, function(code, data)

        print("code:" .. code)
        if (code < 0) then
            print("HTTP request to "..url.." failed")
        else
            print("data:" .. data)
        end
    end)
end




--Authorization: Basic admin:admin

return M

