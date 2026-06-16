# Petty Project Plan

## Product Summary

Petty is a native macOS desktop companion app. The first character, Petty, is a tiny original productivity gym creature that lives in a transparent floating desktop window and reacts to basic user activity.

## MVP Scope

- Show one original placeholder character on the desktop.
- Provide a local Character Store for switching built-in character assets.
- Use a transparent, borderless native macOS window.
- Let the character float above normal windows when enabled.
- Allow direct dragging and save the last position.
- Switch between `idle`, `active`, `bored`, and `dragging` states.
- Provide menu bar controls for show, hide, reset position, always-on-top, and quit.
- Include a simple internal landing page for product direction.

## Non-Goals

- Payments, accounts, subscriptions, backend, App Store integration, or marketplace.
- AI chat, voice, telemetry, cloud sync, or advanced animation pipelines.
- Premium character packs beyond documenting the future direction.
- Downloaded or copied character assets.

## Technical Architecture

- Swift and SwiftUI for app code and character rendering.
- AppKit for macOS-specific window behavior, menu bar integration, and activity checks.
- `NSPanel` hosts a SwiftUI `CharacterView` through `NSHostingView`.
- `UserDefaults` persists the character position and always-on-top setting.
- A timer polls privacy-safe idle time through `CGEventSource.secondsSinceLastEventType`.

## Main Files and Classes

- `PettyApp.swift`: SwiftUI app entry point and app delegate bridge.
- `AppDelegate.swift`: app lifecycle and controller wiring.
- `CharacterWindowController.swift`: transparent floating panel creation, positioning, drag handling, and visibility.
- `CharacterView.swift`: renders bundled transparent PNG character frames.
- `CharacterState.swift`: state enum.
- `CharacterStateManager.swift`: simple activity and dragging state transitions.
- `ActivityMonitor.swift`: privacy-safe system idle polling.
- `MenuBarController.swift`: native menu bar controls.
- `SettingsStore.swift`: persisted settings.
- `SettingsView.swift`: in-app Store & Settings window.
- `CharacterAsset.swift`: local character catalog.

## Edge Cases

- Multiple monitors: restore saved position only if it intersects a visible screen.
- Screen changes: reset if the saved or current position is no longer visible.
- Character dragged off-screen: constrain final saved position to visible screen bounds.
- Fullscreen apps and Spaces: use `canJoinAllSpaces` and `fullScreenAuxiliary`, but avoid system-critical window levels.
- Menu bar lifecycle: hiding the character does not quit the app; Quit is explicit.
- CPU/GPU usage: use simple SwiftUI animation and a low-frequency activity timer.

## macOS Permissions and Limitations

- The prototype does not read typed text, inspect other apps, capture screenshots, or store activity logs.
- Basic idle detection uses system event timing and should not require Accessibility permission.
- A future richer interaction model may require Accessibility permission; that should be opt-in and documented in-app.
- Fullscreen and Spaces behavior depends on macOS window management and may vary by version and user settings.

## Git Workflow

- Keep commits small and reviewable.
- Do not commit build products, DerivedData, user-specific Xcode files, secrets, or temporary files.
- Commit after docs, project scaffold, floating window, dragging, menu controls, activity states, and landing page.

## Next Milestones

- Replace the shape prototype with original animated character art.
- Add a small settings window for behavior and opacity.
- Add smarter visibility modes: Smart Mode, Desktop Only, Focus Mode, Pause During Fullscreen, and Lower Opacity During Work.
- Add a lightweight character pack data model.
- Create onboarding and a stronger visual identity after the technical prototype is proven.
