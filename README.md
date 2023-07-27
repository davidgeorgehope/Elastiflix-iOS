# iOS OpenTelemetry Example Project

This is an example iOS application built with SwiftUI that demonstrates how to use the [OpenTelemetry Swift SDK](https://github.com/open-telemetry/opentelemetry-swift) for distributed tracing.

## Project Overview

The app has a simple user interface that displays a random sentence every few seconds. The generation of each sentence is instrumented with OpenTelemetry spans, which are sent to a configured OpenTelemetry collector. The spans include an attribute representing the word count of each sentence.

## Getting Started

### Prerequisites

- Swift 5.2 or later
- iOS 11 or later
- Xcode 12.0 or later

### Installation

1. Clone the repository:

   ```
   git clone https://github.com/davidgeorgehope/Elastiflix-iOS.git
   ```

2. Open the `.xcodeproj` file in Xcode.

3. Make sure the OpenTelemetry SDK is added to the project. You can add it using the Swift Package Manager in Xcode: File > Swift Packages > Add Package Dependency, and then enter the URL for the OpenTelemetry Swift SDK.

4. Run the app on a simulator or a device.

## Key Components

- `TraceManager`: This class sets up the OpenTelemetry SDK with an OTLP exporter, which sends spans to a configured endpoint over HTTP. The SDK is also set up with a resource that includes attributes such as the service name and version.

- `ContentView`: This SwiftUI view displays a random sentence and a globe image. It also generates spans for the sentence generation process.
