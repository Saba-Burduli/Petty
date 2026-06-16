# Desktop Companion Research

## References

- Apple `NSWindow.CollectionBehavior`: useful for Spaces and fullscreen-related window behavior. https://developer.apple.com/documentation/appkit/nswindow/collectionbehavior-swift.struct
- Apple `NSWindow.Level`: documents window stacking levels. https://developer.apple.com/documentation/appkit/nswindow/level-swift.struct
- Apple `MenuBarExtra`: SwiftUI menu bar scene API. https://developer.apple.com/documentation/SwiftUI/MenuBarExtra
- Pets Therapy on the Mac App Store: pixel desktop pets with many collectible companions. https://apps.apple.com/us/app/pets-therapy-desktop-pets/id1575542220
- Desktop Pet: AI/productivity-oriented desktop companion positioning. https://desktoppet.app/
- Convai Desktop Pet: demonstrates common desktop pet ideas like roaming, animation, dragging, and conversation, but uses copied/pop-culture style examples that this product should avoid. https://github.com/AkshitIreddy/convai-desktop-pet
- Nil Coalescing menu bar utility article: highlights menu bar lifecycle concerns, including hiding Dock presence and still providing Quit. https://nilcoalescing.com/blog/BuildAMacOSMenuBarUtilityInSwiftUI

## What Existing Products Do Well

- Immediate delight: the character is visible and animated quickly.
- Collectibility: multiple characters create a clear long-term product path.
- Low-friction controls: menu bar or context menu actions keep the companion lightweight.
- Desktop-native behavior: draggable, always-visible companions are more compelling than ordinary app windows.

## What Existing Products Do Poorly

- Many lean on copied anime/game characters or copyrighted silhouettes.
- AI/chat features can distract from the core desktop companion loop.
- Always-on-top behavior can become annoying if the app lacks quick hide and reset controls.
- Some products feel like novelty toys rather than polished native utilities.

## UX Ideas To Use

- Start with one original character and a few readable states.
- Keep the character small, draggable, and easy to hide.
- Use activity only as a coarse signal: active, idle, bored.
- Make reset position available from the menu bar for multi-monitor and off-screen recovery.
- Design future characters around original personalities, not references to existing IP.

## Things To Avoid

- No copyrighted game, anime, movie, or existing app assets.
- No copied names, logos, silhouettes, or one-to-one character designs.
- No telemetry or invasive monitoring.
- No aggressive window levels that interfere with system UI.
- No complex store, accounts, or payments in this prototype.
