//
//  AuthInterceptor.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//
import Alamofire

final class Interceptor: RequestInterceptor {

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        exit(0)
    }
}
