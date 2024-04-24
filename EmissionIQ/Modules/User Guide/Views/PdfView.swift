//
//  PdfView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 14/03/2024.
//

import SwiftUI
import PDFKit

// Create a view able to display PDFs
struct PdfView: UIViewRepresentable {

    let pdfDocument: PDFDocument

    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}
