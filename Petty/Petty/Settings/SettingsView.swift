import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsStore: SettingsStore
    let onShow: () -> Void
    let onHide: () -> Void
    let onResetPosition: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            header

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("Character Store")
                    .font(.headline)

                Text("Bundled character frames are rendered directly in the desktop pet. Rive can still be added later if we need vector state machines.")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 12)], spacing: 12) {
                    ForEach(CharacterCatalog.assets) { asset in
                        CharacterCard(
                            asset: asset,
                            isSelected: asset.id == settingsStore.selectedCharacterID
                        ) {
                            settingsStore.selectedCharacterID = asset.id
                        }
                    }
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                Toggle("Always on top", isOn: $settingsStore.alwaysOnTop)

                HStack {
                    Text("Size")
                    Slider(value: $settingsStore.characterScale, in: 0.75...1.35, step: 0.05)
                    Text("\(Int(settingsStore.characterScale * 100))%")
                        .foregroundStyle(.secondary)
                        .frame(width: 48, alignment: .trailing)
                }
            }

            HStack {
                Button("Show", action: onShow)
                Button("Hide", action: onHide)
                Button("Reset Position", action: onResetPosition)
                Spacer()
            }
        }
        .padding(20)
        .frame(width: 520)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Petty")
                .font(.largeTitle.weight(.bold))
            Text("Choose a character, tune visibility, and test desktop behavior.")
                .foregroundStyle(.secondary)
        }
    }
}

private struct CharacterCard: View {
    let asset: CharacterAsset
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 10) {
                MiniCharacterPreview(asset: asset)
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text(asset.displayName)
                            .font(.headline)
                        Spacer()
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }

                    Text(asset.tagline)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(asset.source)
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(12)
            .background(.quaternary.opacity(isSelected ? 0.8 : 0.35), in: RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? .green : .clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct MiniCharacterPreview: View {
    let asset: CharacterAsset

    var body: some View {
        ZStack(alignment: .center) {
            if let image = CharacterImageLoader.frameImage(named: "zed_idle", characterFolder: asset.resourceFolder) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 92)
            } else {
                Text("Missing")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(height: 92)
    }
}
