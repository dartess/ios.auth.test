import Sentry

func sentryCaptureEvent(level: SentryLevel, message: String, extra: [String: Any]?) {
    let event = Event(level: level)
    event.message = SentryMessage(formatted: "[iOS] \(message)")
    event.extra = extra
    SentrySDK.capture(event: event)
}
