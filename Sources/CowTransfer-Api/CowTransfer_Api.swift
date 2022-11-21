import Foundation
import JAYSON

public struct CowTransfer_Api {
    let email: String
    let pwd: String

    var redirectLink: URL?
    var loginCookie: String? // remember-mev2

    public init(email: String, pwd: String) {
        self.email = email
        self.pwd = pwd
    }

    public mutating func login() async throws -> Bool {
        guard let URL = URL(string: "https://cowtransfer.com/api/user/emaillogin") else { throw NSError() }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"

        // Headers

        request.addValue("cowtransfer.com", forHTTPHeaderField: "Host")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("263", forHTTPHeaderField: "Content-Length")
        request.addValue("\"Google Chrome\";v=\"107\", \"Chromium\";v=\"107\", \"Not=A?Brand\";v=\"24\"", forHTTPHeaderField: "sec-ch-ua")
        request.addValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.addValue("multipart/form-data; boundary=----WebKitFormBoundarypsmYTMYAVSc4fhwh", forHTTPHeaderField: "Content-Type")
        request.addValue("COW_CN_WEB", forHTTPHeaderField: "x-channel-code")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("COW_TRANSFER", forHTTPHeaderField: "x-business-code")
        request.addValue("\"macOS\"", forHTTPHeaderField: "sec-ch-ua-platform")
        request.addValue("https://cowtransfer.com", forHTTPHeaderField: "Origin")
        request.addValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
        request.addValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
        request.addValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")
        request.addValue("https://cowtransfer.com/login?redirect=%2F", forHTTPHeaderField: "Referer")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("zh-CN,zh;q=0.9,en;q=0.8", forHTTPHeaderField: "Accept-Language")

        // Body
        let bodyString = "------WebKitFormBoundarypsmYTMYAVSc4fhwh\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\n\(email)\r\n------WebKitFormBoundarypsmYTMYAVSc4fhwh\r\nContent-Disposition: form-data; name=\"password\"\r\n\r\n\(pwd)\r\n------WebKitFormBoundarypsmYTMYAVSc4fhwh--\r\n"
        request.httpBody = bodyString.data(using: .utf8, allowLossyConversion: true)

        /* Start a new Task */
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let fields = httpResponse.allHeaderFields as? [String: String] else {
            return false
        }

        let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: URL)

        guard let cookie = cookies.first(where: {
            $0.name == "remember-mev2"
        })?.value else {
            return false
        }

        self.loginCookie = cookie

        let json = try JSON(data: data)
        print(json)
        let errorCode = json["errorCode"]?.int
        let redirectLink = try json["redirectLink"]?.getURL()

        self.redirectLink = redirectLink

        return errorCode == 0
    }
}
