// URLInputBar.swift 07.12.25
import SwiftUI

struct PasteEnabledTextField: NSViewRepresentable {
    @Binding var text: String

    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.placeholderString = "Paste Amazon URL here"
        textField.isEditable = true
        textField.isSelectable = true
        textField.isBezeled = true
        textField.isBordered = true
        textField.focusRingType = .default
        textField.delegate = context.coordinator
        return textField
    }

    func updateNSView(_ nsView: NSTextField, context: Context) {
        if nsView.stringValue != text {
            nsView.stringValue = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextFieldDelegate {
        var parent: PasteEnabledTextField

        init(_ parent: PasteEnabledTextField) {
            self.parent = parent
        }

        func controlTextDidChange(_ obj: Notification) {
            if let textField = obj.object as? NSTextField {
                parent.text = textField.stringValue
            }
        }
    }
}

struct URLInputBar: View {
    @Binding var url: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            PasteEnabledTextField(text: $url)
                .frame(height: 24)
        }
        .padding()
    }
}
