# Safe Ride #

<img width="200" alt="Shows a user interface with a round button that says start." src="https://user-images.githubusercontent.com/21343215/224447117-b0b21ded-d90e-4bba-9025-c5d2c563810a.png"> <img width="200" alt="A list of sound options that can be selected." src="https://user-images.githubusercontent.com/21343215/224447121-3e51749d-13de-478a-8a53-e309d37bf2c7.png"> <img width="200" alt="Shows an icon for an ear with text 'Listening...'. Half circles can be seen on either side of the icon indicating a signal strength." src="https://user-images.githubusercontent.com/21343215/224595654-8c8ccd7e-ee1a-41d5-8eda-29c1cf4c90d4.png"> <img width="200" alt="A list of historical info showin detected sounds." src="https://user-images.githubusercontent.com/21343215/224595647-f9ec1b2c-4272-43d8-ad72-c5e6914db913.png"> 


## Introduction ##

Safely cycling in an urban or off road setting depends on being able to process and respond to events such as sights, sounds, and changing landscape. Current solutions include bicycle bells, rear view mirrors, lights, and road signs. Along with these solutions each state or country has a set of laws that dictate how cyclists interact with each other and vehicles on the road. In the state of Washington a set of [Bicycle Laws](https://wabikes.org/index.php/growing-bicycling/washington-bike-laws/bicycle-laws-safety-revised-code-of-washington-state-bicycle-related) provide details on the interactions.

Many of the interactions between two cyclists or a cyclist and a vehicle occur through sound. For an individual who is hard of hearing, the event could be difficult or impossible to recognize otherwise. For example, if a cyclist on a dirt trail is coming around a blind corner towards another cyclist and rings their bell, a hard of hearing person has no visual alternative to respond to that event. Another scenario is if a vehicle or a cyclist is passing a cyclist. The current solution of a rear view mirror helps to solve this problem but requires a cyclist to constantly check their surroundings instead of giving attention to the road in front of them. This can result in [neck strain](#first-person-account) and increased likelihood of accidents from looking back more often.

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

Based on the related work, the goal of the project was to create an app that is tailored to do sound classification for a cyclist. The experience is built upon the insight that was observed in the studies mentioned.

Currently, the iPhone operating system (iOS) does provide some sound classification functionality. Unfortunately it fails in two major ways. First, it only has a subset of sounds that are available to be recognized which are more general use like a fire alarm, door bell, or baby crying. Second, a user will only get prompted of this sound recognition through a notification. When cycling, that information is difficult to consume as it is temporarily and requires input to get all of the details.

So the solution is to provide sound recognition through a trained model on sounds that occur while cycling. The base model is one provided by Apple and is trained on a variety of bicycle bells. I focused on this type of communication as it is a common practice to use a bicycle bell when cycling to indicate passing or approaching. It was trained with additional data that I collected while riding my own bicycle. This made it so the model was more accurate when used in a common environment the app is designed to be used in, trail riding.

Secondly, the user interface was designed based on the outcomes of the research that are referenced. The app will convey sound recognition through a visual representation by an icon and strength level. It will also provide a tactile response through haptics. Also based on the research, a user can adjust [multiple settings](#adjustable-settings) in the app so that it meets their needs. By having this information readily available and consumable through multiple senses, a hard of hearing person can use this information to ride safely in environments they might not be able to otherwise.

## Disability justice perspective ##

### Collective liberation ###

The app was designed to help hard of hearing individuals to have the same access to roads and trails as any other cyclist. By building on top of the research from a variety of individuals from different backgrounds, and a first person account, I have worked through them to create a solution that will ensure some individuals are not left behind. The app achieves this by providing cyclists a way to ride safely. It also ensures it can be used for individuals with a mixed set of abilities through multiple accessibility options. I also recognize that the app fails to completely meet disability justice of collective liberation. From the limitations of working by myself I have not included the perspective of multi-gendered, mixed class, or across the sexual spectrum. As I continue to work on this project I should seek those who can broaden the perspectives to ensure that no one is left behind and the solution can help everyone ride safely. As I find individuals who can develop the app with me, we can work together to ensure that cycling is free from limitations.

### Recognizing wholeness  ###

As I was researching and designing a project, I came across a [first person experience](#first-person-account) of a hard of hearing cyclist. Shane Prendergast rides around the world and has been deaf for most of his life. His experience shaped the app in many ways as I tried to address the challenges he described when riding. At the same time, Shane describes the rich experience he does have while cycling even though he can't hear. He finds it to be tranquil and prefers it over wearing hearing aids as it allows him to think clearly. I recognize that the app does not fill a need for Shane to have a enjoyable experience on a bicycle. The app is a tool and is not designed or communicated as a way to make up for something that Shane lacks that other cyclists have. Any wording or phasing in the app and in the future App Store page will not include language that conveys that a hard of hearing individual must have the app to enjoy cycling.

### Leadership of the most impacted  ###

While the project was designed around studies that involved hard of hearing individuals, I do not have hearing loss. So therefore I do not represent who would be most impacted by the app. I recognize that the app might have many faults as there has been no user feedback or development involving someone from the hard of hearing community. By finding someone who could be the leader of the most impacted and have their input or development skills involved, we could ensure that this is the correct solution to the problem. In addition I could find more articles, videos, and activists of cycling safety in the deaf community to include their perspective.

## First person account ##

The design of the app leans heavily on a hard of hearing cyclist and the challenges that he faces. As he describes in an [article from The Guardian](https://www.theguardian.com/environment/bike-blog/2016/apr/15/im-deaf-but-it-doesnt-stop-me-cycling), neck strain, lack of knowledge of what is behind him, and difficulty coordinating with other cyclists have all lead to un-safe riding practices. Shane Prendergast does not let this limit his passion for cycling but does recognize these issues pose a challenge for him.

## Learnings ##

Throughout the creation of the app, there were multiple times I saw the shortcomings of it not being accessible. As an experienced app developer it was surprising how a small app could fall short to addressing the needs of different types of disabilities that heard of hearing individuals using the app might also have. I was able to address some of these before completing the project, but was not able to user test it with the disability community. This lead me to start researching other apps that those in the disability community highly regard to mimic some of the best practices for accessible apps.

## Future work ##
Many of the sound classifiers used in the app are models provided by Apple. The classifiers are for general use and not trained on data that accurately reflects the environments encountered while cycling. To address this, custom models should be created for all sounds provided in the app. Also, the model that I did train was only improved by my own personal data which is biased by where I ride and my riding ability.

An issue quickly arises when a cyclist uses this app and their own bicycle bell is detected. Adding the capability of on device machine learning so that the user can ensure their own bike bell is not recognized would reduce frustration of false positives in sound recognition.

An Apple Watch provides information from an app through [complications](https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/complications). Having the information from this app be surfaced in other ways would allow a user to view it alongside other apps they might be using at the same time.

A general refactor of code also should occur. Many of software best practices are not implemented in the minimal viable product.

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

## Licenses ## 

[Apple sound classifier demo application](https://github.com/alexanderboswell/safeRide/blob/main/licenses/LICENSE.txt)

Background of icon image by <a href="https://www.freepik.com/free-vector/green-topographic-map-background_8904743.htm#query=topographic%20map&position=24&from_view=search&track=ais">Freepik</a>
