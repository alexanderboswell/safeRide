# Safe Ride #


<img width="250" alt="Shows a user interface with a round button that says start." src="https://user-images.githubusercontent.com/21343215/224447117-b0b21ded-d90e-4bba-9025-c5d2c563810a.png"> <img width="250" alt="Shows an icon for an ear with text 'Listening...'. Half circles can be seen on either side of the icon indicating a signal strength." src="https://user-images.githubusercontent.com/21343215/224447120-86b6c5d9-219e-45c7-82ec-048a8cc1e6d0.png"> <img width="250" alt="A list of sound options that can be selected." src="https://user-images.githubusercontent.com/21343215/224447121-3e51749d-13de-478a-8a53-e309d37bf2c7.png"> 


## Introduction ##

Safely cycling in an urban or off road setting depends on being able to process and respond to events such as sights, sounds, and changing landscape. Current solutions include bicycle bells, rear view mirrors, lights, and road signs. Along with these solutions each state or country has a set of laws that dictate how cyclists interact with each other and vehicles on the road. In the state of Washington a set of [Bicycle Laws](https://wabikes.org/index.php/growing-bicycling/washington-bike-laws/bicycle-laws-safety-revised-code-of-washington-state-bicycle-related) provide details on the interactions.

Many of the interactions between two cyclists or a cyclist and a vehicle occur through sound. For an individual who is hard of hearing, the event could be difficult or impossible to recognize otherwise. For example, if a cyclist on a dirt trail is coming around a blind corner towards another cyclist and rings their bell, a hard of hearing person has no visual alternative to respond to that event. Another scenario is if a vehicle or a cyclist is passing a cyclist. The current solution of a rear view mirror helps to solve this problem but requires a cyclist to constantly check their surroundings instead of giving attention to the road in front of them. This can result in neck strain and increased likelihood of accidents from looking back more often.

The goal of the app is to provide a solution through a combination of visual and haptic feedback. By allowing a hard of hearing individual to be notified of events happening around them, they can ride safely. The app runs on an Apple Watch and utilizes the device microphone. By actively listening, the app can identify many common sounds that can occur while cycling. When a sound is identified, a user will be notified both visually and tactually. By having the information be available in real time and easily viewable on the wrist of a cyclist, they can respond to events occurring around them.

## Related work ##
This project was built upon the research of four studies:
- [Evaluating Smartwatch-based Sound Feedback for Deaf and Hard-of-hearing Users Across Contexts](https://web.eecs.umich.edu/~profdj/img/portfolio/Goodman_SoundWatch_CHI2020.pdf)
- [Field Study of a Tactile Sound Awareness Device for Deaf Users
](https://web.eecs.umich.edu/~profdj/img/portfolio/Jain_Vibes_ISWC2020.pdf)
- [SoundWatch: Exploring Smartwatch-based Deep Learning Approaches to Support Sound Awareness for Deaf and Hard of Hearing Users 
](https://web.eecs.umich.edu/~profdj/img/portfolio/Jain_SoundWatch_ASSETS2020.pdf)
- [ProtoSound: A Personalized and Scalable Sound Recognition System for Deaf and Hard of Hearing Users](https://web.eecs.umich.edu/~profdj/img/portfolio/Jain_ProtoSound_CHI2022.pdf)

Each of the studies involve using portal computing devices as sound classifiers. By having a device with them at all times, a hard of hearing individual can be notified of situational, environmental, and safety cues. The research studied how both tactile and visual feedback could be potentially helpful in providing information of sounds occurring around them. By running a study with hard of hearing individuals, the disability community was involved and affirmed that using sound classification can help and is not a form of ableism.

Other common results from the studies also emerged. A combination of visual and tactile feedback provided the best experience. Also, filtering options for the tactile feedback allowed individuals to tailor the experience to their environment. Lastly, recognizing the direction of sound and conveying that visually to a user has not been solved and still remains an open question.

## Methodology ##

## Disability justice perspective ##

### Collective access ###

### First person account ###

## Learnings ##

## App accessibility ##
The app uses apple conventions that are defined in the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/platforms/designing-for-watchos). Following these patterns allow the app to be accessible as it builds upon the work of Apple in their design decisions.

### High contrast colors ###
For watchOS, the color spectrum is limited as dark mode is the only viewing mode. All colors used were checked with [Contrast](https://apps.apple.com/us/app/contrast-color-accessibility/id1254981365?mt=12) to ensure they pass the standard for [WCAG 2.1](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html) and have a AA+ score.

### VoiceOver ###
The app has been tested for navigation with VoiceOver. A low vision or blind user should be able to navigate with the standard gestures provided by VoiceOver. All custom elements have had accessibility traits and labels added. All other elements use stand conventions of Apple controls.

### Adjustable settings ###
 As part of the research the app is founded upon, allowing users to customize their experience provides an accessible experience. The operating system provides tuning of haptic feedback. For in app settings a user can customize the sensitivity of the sound recognizer. Also, an animation is displayed when a sound is recognized which can be turned off.

 #### Sensitivity options ####
 For sound classification, a user can adjust the sensitivity of sound recognition. Changing this option allows a user to receive more or less notifications based on the context they are currently riding in.
 
<img width="250" alt="A list of settings options, the first one called sensitivtiy with a value of high." src="https://user-images.githubusercontent.com/21343215/224427107-2943fa96-638f-4cca-99c7-82730cb4633e.png"> <img width="250" alt="A list of sensitivity options. The high option is currently selected." src="https://user-images.githubusercontent.com/21343215/224410995-0e285149-8ec9-45b1-bc51-e483d43fe9f8.png">

#### Animation toggle ####
To address the [Animation From Interactions (Level AAA)](https://www.w3.org/WAI/WCAG21/Understanding/animation-from-interactions.html) WCAG 2.1 standard, an option has been created so that a user can turn off animations. The app heavily relies on providing information about sound recognition through an animation, icon, and label. When animations are disabled an alternative UI is provided.
| Animations enabled | Animations disabled |
| ------------------ | ------------------- |
|<img width="250" alt="Shows an icon for a bicycle bell with text 'Bicycle Bell'. Half circles can be seen on either side of the icon indicating a signal strength." src="https://user-images.githubusercontent.com/21343215/224426049-c4a36864-346e-4ba3-b62f-02126cd87e77.png"> | <img width="250" alt="Shows an icon for a bicycle bell with text saying 'Heard sound: Bicycle Bell'." src="https://user-images.githubusercontent.com/21343215/224426064-ca4cec84-419e-4b11-bf4d-f3fdd48a9027.png"> |

## Future work ##
Many of the sound classifiers used in the app are models provided by Apple. The classifiers are for general use and not trained on data that accurately reflects the environments encountered while cycling. To address this, custom models should be created for all sounds provided in the app.

An issue quickly arises when a cyclist uses this app and their own bicycle bell is detected. Adding the capability of on device machine learning so that the user can ensure their own bike bell is not recognized would reduce frustration of false positives in sound recognition.

An Apple Watch provides information from an app through [complications](https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/complications). Having the information from this app be surfaced in other ways would allow a user to view it alongside other apps they might be using at the same time.

A general refactor of code also should occur. Many of software best practices are not implemented in the minimal viable product.

## Licenses ## 
