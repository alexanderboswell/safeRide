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

### High contrast colors ###
For watchOS, the color spectrum is limited as dark mode is the only viewing mode. All colors used were checked with [Contrast](https://apps.apple.com/us/app/contrast-color-accessibility/id1254981365?mt=12) to ensure they pass the standard for [WCAG 2.1](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html) and have a AA+ score.

### VoiceOver ###
The app has been tested for navigation with VoiceOver. A low vision or blind user should be able to navigate with the standard gestures provided by VoiceOver. All custom elements have had accessibility traits and labels added. All other elements use stand conventions of Apple controls.

### Adjustable settings ###
 As part of the research the app is founded upon, allowing users to customize their experience provides an accessible experience. The operation system provides tuning of haptic feedback. For in app settings a user can customize the sensitivity of the sound recognizer. Also, an animation is displayed when a sound is recognized which can be turned off.

 #### Sensitivity options ####
 For sound classification, a user can adjust the sensitivity of sound recognition. Changing this option allows a user to receive more or less notifications based on the context they are currently riding in.
 
<img width="250" alt="A list of settings options, the first one called sensitivtiy with a value of high." src="https://user-images.githubusercontent.com/21343215/224427107-2943fa96-638f-4cca-99c7-82730cb4633e.png"> <img width="250" alt="A list of sensitivity options. The high option is currently selected." src="https://user-images.githubusercontent.com/21343215/224410995-0e285149-8ec9-45b1-bc51-e483d43fe9f8.png">

### Animation toggle ###
To address the [Animation From Interactions (Level AAA)](https://www.w3.org/WAI/WCAG21/Understanding/animation-from-interactions.html) WCAG 2.1 standard, an option has been created so that a user can turn off animations. The app heavily relies on providing information about sound recognition through an animation, icon, and label. When animations are disabled an alternative UI is provided.
| Animations enabled | Animations disabled |
| ------------------ | ------------------- |
|<img width="250" alt="Shows an icon for a bicycle bell with text 'Bicycle Bell'. Half circles can be seen on either side of the icon indicating a signal strength." src="https://user-images.githubusercontent.com/21343215/224426049-c4a36864-346e-4ba3-b62f-02126cd87e77.png"> | <img width="250" alt="Shows an icon for a bicycle bell with text saying 'Heard sound: Bicycle Bell'." src="https://user-images.githubusercontent.com/21343215/224426064-ca4cec84-419e-4b11-bf4d-f3fdd48a9027.png"> |

## Licenses ## 
