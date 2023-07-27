import SwiftUI
import OpenTelemetryApi
import OpenTelemetrySdk
import OpenTelemetryProtocolExporterHttp

// New TraceManager class
class TraceManager {
    static let shared = TraceManager()

    init() {
        
        let endpoint = URL(string: "https://4289d143d75c4acdaf3c6164ca66413a.apm.us-central1.gcp.cloud.es.io/v1/traces")!

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer RGsQRhhxE0852KtUrS"]
        let session = URLSession(configuration: configuration)

        let exporter = OtlpHttpTraceExporter(endpoint: endpoint, useSession: session)

        let attributes: [String: AttributeValue] = [
            "service.name": AttributeValue.string("iOS-App"),
            "service.version": AttributeValue.string("1.0"),  // optional
            "deployment.environment": AttributeValue.string("production"),
            "telemetry.sdk.name": AttributeValue.string("opentelemetry"),
            "telemetry.sdk.language": AttributeValue.string("swift"),
            "telemetry.sdk.version": AttributeValue.string("1.0.0")  // replace with your SDK version
        ]
        let resource = Resource(attributes: attributes)
        
        OpenTelemetry.registerTracerProvider(tracerProvider: TracerProviderBuilder()
            .add(spanProcessor: SimpleSpanProcessor(spanExporter: exporter)).with(resource: resource).build())
    }


}


struct ContentView: View {
    let tracer = OpenTelemetry.instance.tracerProvider.get(instrumentationName: "YourInstrumentationName", instrumentationVersion: "1.0")
    
    @State private var sentence: String = "Hello, world!"
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(sentence)
        }
        .padding()
        .onReceive(timer) { _ in
            sentence = generateText()
        }
    }
    
    private func generateText() -> String {
        // Create and end a span, including word count as an attribute
        let span = tracer.spanBuilder(spanName: "generateText").setSpanKind(spanKind: .client).setActive(true).startSpan()
        
        // Define some example sentences
        let sentences = [
            "Hello, world!",
            "Goodbye, world!",
            "SwiftUI is really interesting!",
            "I love learning about OpenTelemetry.",
            "How's the weather today?",
            "Just another random sentence."
        ]
        
        // Choose a random sentence
        let sentence = sentences.randomElement() ?? "Hello, world!"
        
        let wordCount = sentence.split(separator: " ").count
        span.setAttribute(key: "wordCount", value: AttributeValue.int(wordCount))
        print("Span started, sentence: \(sentence), word count: \(wordCount)")
        span.end()
        print("Span ended")
        
        return sentence
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

