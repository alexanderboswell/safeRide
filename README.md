# Safe Ride #

## Introduction ##

## Related work ##
This project was built upon the research of 3 studies:
- [Evaluating Smartwatch-based Sound Feedback for Deaf and Hard-of-hearing Users Across Contexts](https://web.eecs.umich.edu/~profdj/img/portfolio/Goodman_SoundWatch_CHI2020.pdf)
- [Field Study of a Tactile Sound Awareness Device for Deaf Users
](https://web.eecs.umich.edu/~profdj/img/portfolio/Jain_Vibes_ISWC2020.pdf)
- [SoundWatch: Exploring Smartwatch-based Deep Learning Approaches to Support Sound Awareness for Deaf and Hard of Hearing Users 
](https://web.eecs.umich.edu/~profdj/img/portfolio/Jain_SoundWatch_ASSETS2020.pdf)


## Methodology ##

## Disability justice perspective ##

### Collective access ###

### First person account ###

## Learnings and future work ##

## App accessability ##
The app uses apple conventions that are defined in the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/platforms/designing-for-watchos). Following these patterns allow the app to be accessible as it builds upon the work of Apple in their design decisions.
For these project the main focus areas have been:
- High contrast colors
  - For watchOS, the color spectrum is limited as dark mode is the only viewing mode. All colors used were checked with [Contrast](https://apps.apple.com/us/app/contrast-color-accessibility/id1254981365?mt=12) to ensure they pass the standard for [WCAG 2.1](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html) and have a AAA score.
- VoiceOver
  - The app has been tested for navigation with VoiceOver. A low vision or blind user should be able to navigate with the standard gestures provided by VoiceOver. All custom elements have had accessibility traits and labels added. All other elements use stand conventions of Apple controls.
- Adjustable settings
  - As part of the research the app is founded upon, allowing users to customize their experience provides an accessible experience. The operation system provides tuning of haptic feedback. For in app settings a user can customize the sensitivity of the sound recognizer. Also, an animation is displayed when a sound is recognized which can be turned off.
