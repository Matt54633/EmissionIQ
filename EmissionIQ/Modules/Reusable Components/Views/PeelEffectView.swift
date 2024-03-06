//
//  PeelEffectView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import SwiftUI

// PeelEffectView is used to create a peel like effect for the trivia item
struct PeelEffectView<Content: View, Back: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var dragProgress: CGFloat = 0.05
    @State private var isExpanded: Bool = false
    @State private var isDragging = false
    
    var content: Content
    var back: Back
    
    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder back: @escaping () -> Back) {
        self.content = content()
        self.back = back()
    }
    
    var body: some View {
        content
            .onAppear {
                dragProgress = horizontalSizeClass == .compact ? 0.05 : 0.02
            }
            .hidden()
            .overlay(content: {
                GeometryReader {
                    
                    let rect = $0.frame(in: .global)
                    let minX = rect.minX
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.black.gradient)
                        .overlay(alignment: .trailing) {
                            back
                                .disabled(!isExpanded)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard !isDragging else { return }
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                dragProgress = horizontalSizeClass == .compact ? 0.1 : 0.04
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    dragProgress = horizontalSizeClass == .compact ? 0.05 : 0.02
                                }
                            }
                        }
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged({ value in
                                    
                                    guard !isExpanded else { return }
                                    var translationX = value.translation.width
                                    translationX = max(-translationX, 0)
                                    let progress = min(0.9, translationX / rect.width)
                                    dragProgress = progress
                                    
                                    if abs(value.translation.width) > 10 {
                                        isDragging = true
                                    }
                                    
                                })
                                .onEnded({ value in
                                    
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                        dragProgress = horizontalSizeClass == .compact ? 0.05 : 0.02
                                        isExpanded = false
                                        isDragging = false
                                    }
                                    
                                })
                        )
                    
                    Rectangle()
                        .fill(.black)
                        .padding(.vertical, 23)
                        .shadow(color: .darkGreen.opacity(0.3), radius: 15, x: 30, y: 0)
                        .padding(.trailing, rect.width * dragProgress)
                        .mask(content)
                        .allowsHitTesting(false)
                        .offset(x: dragProgress == 1 ? -minX : 0)
                    
                    content
                        .mask {
                            Rectangle()
                                .padding(.trailing, dragProgress * rect.width)
                        }
                        .allowsHitTesting(false)
                        .offset(x: dragProgress == 1 ? -minX : 0)
                }
            })
            .overlay {
                GeometryReader {
                    
                    let size = $0.size
                    let minX = $0.frame(in: .global).minX
                    let minOpacity = dragProgress / 0.05
                    let opacity = min(1, minOpacity)
                    
                    content
                        .shadow(color: .midGreen.opacity(dragProgress != 0 ? 0.2 : 0), radius: 5, x: 15, y: 0)
                        .overlay {
                            
                            Rectangle()
                                .fill(.white.opacity(0.25))
                                .mask(content)
                            
                        }
                        .overlay(alignment: .trailing) {
                            
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [
                                        .clear,
                                        .primaryGreen,
                                        .clear,
                                        .clear
                                    ], startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(width: 60)
                                .offset(x: 40)
                                .offset(x: -30 + (30 * opacity))
                                .offset(x: size.width * -dragProgress)
                            
                        }
                        .scaleEffect(x: -1)
                        .offset(x: size.width - (size.width * dragProgress))
                        .offset(x: size.width * -dragProgress)
                        .mask {
                            
                            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 0, topTrailingRadius: 0)
                                .offset(x: size.width * -dragProgress)
                            
                        }
                        .offset(x: dragProgress == 1 ? -minX : 0)
                }
                .allowsHitTesting(false)
            }
    }
}
