import Foundation
import Combine


@available(iOS 13.0, *)
public func fetchAsync<Response: Decodable>(for request: URLRequest,
                                            with type: Response.Type) async -> Result<Response, ErrorType> {
    if !Reachability.isConnectedToNetwork() {
        return .failure(ErrorType.internetError)
    }
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        if let error = errorCase(with: Response.self,
                                 data: data,
                                 response: response) {
            return error
        }
        do {
            let dataDecoded  = try JSONDecoder().decode(type, from: data)
            return .success(dataDecoded)
        }
        catch {
            return .failure(ErrorType.decoderError)
        }
    }
    catch {
        return .failure(ErrorType.decoderError)
    }
}

@available(iOS 13.0, *)
func errorCase<Response: Decodable>(with type: Response.Type,
                                           data: Data,
                                           response: URLResponse) -> Result<Response, ErrorType>? {
    if !Reachability.isConnectedToNetwork() {
        return .failure(ErrorType.internetError)
    }
    do {
        if let dataError = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?], dataError["error"] != nil {
            return .failure(ErrorType.error((dataError["reason"] as? String) ?? "Error"))
        }
        
        guard let resp = response as? HTTPURLResponse,
              resp.statusCode == 200 else {
            return .failure(ErrorType.httpStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0))
        }
    }catch {
        return .failure(ErrorType.noData)
    }
    return nil
}


