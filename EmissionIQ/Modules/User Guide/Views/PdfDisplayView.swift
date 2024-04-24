//
//  PdfDisplayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 14/03/2024.
//

import SwiftUI
import PDFKit

// View to display a PDF file
struct PdfDisplayView: View {

    let pdfDoc: PDFDocument

    init() {
        let url = Bundle.main.url(forResource: "userGuide", withExtension: "pdf")!
        pdfDoc = PDFDocument(url: url)!
    }

    var body: some View {
        PdfView(showing: pdfDoc)
    }
}
