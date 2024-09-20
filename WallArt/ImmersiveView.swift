//
//  ImmersiveView.swift
//  WallArt
//
//  Created by Christopher J. Roura on 6/13/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State private var characterEntity: Entity = {
        let headAnchor = AnchorEntity(.head)
        headAnchor.position = [0.70, -0.35, -1.0]
        
        let radians = -30 * Float.pi / 180
        ImmersiveView.rotateEntityAroundYAxis(entity: headAnchor, angle: radians)
        
        return headAnchor
    }()
    
    @State private var cubeEntity: Entity = {
            let cubeMesh = MeshResource.generateBox(size: 0.2)
            let material = SimpleMaterial(color: .blue, isMetallic: false)
            let cubeEntity = ModelEntity(mesh: cubeMesh, materials: [material])
            cubeEntity.position.y = -0.125
            return cubeEntity
        }()
    
    @State private var planeEntity: Entity = {
        // NOTE: This does not anchor to any desired wall. Instead it anchors to a wall that best matches the desired criteria of what we are looking for.
        // cms
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2<Float>(0.6, 0.6)))
        
        // meters
        let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 2.625, cornerRadius: 0.1)
        let material = ImmersiveView.loadImageMaterial(imageUrl: "think_different")
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        planeEntity.name = "Canvas"
        wallAnchor.addChild(planeEntity)
        
        return wallAnchor
    }()
    
    var body: some View {
        RealityView { content in
            do {
                let immersiveEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                characterEntity.addChild(immersiveEntity)
                characterEntity.addChild(cubeEntity)
                content.add(characterEntity)
                content.add(planeEntity)
            } catch {
                print("Error in RealityView's make: \(error)")
            }
        }
    }
    
    static func rotateEntityAroundYAxis(entity: Entity, angle: Float) {
        var currentTransform = entity.transform
        let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
        
        currentTransform.rotation = rotation * currentTransform.rotation
        entity.transform = currentTransform
    }
    
    static func loadImageMaterial(imageUrl: String) -> SimpleMaterial {
        do {
            let texture = try TextureResource.load(named: imageUrl)
            var material = SimpleMaterial()
            let color = SimpleMaterial.BaseColor(texture: MaterialParameters.Texture(texture))
            material.color = color
            return material
        } catch {
            fatalError(String(describing: error))
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
