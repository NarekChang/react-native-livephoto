# react-native-livephoto (Library for working with Apple LivePhoto)

![GitHub stars](https://img.shields.io/github/stars/NarekChang/react-native-livephoto.svg)
![GitHub forks](https://img.shields.io/github/forks/NarekChang/react-native-livephoto.svg)
![npm version]((https://img.shields.io/github/npm/NarekChang/react-native-livephoto.svg)

`Apple LivePhotos are working only on IOS devices.`

## Installation

### Mostly automatic installation

`$ npm install react-native-livephoto --save`

or

`$ react-native link react-native-livephoto`

### Manual installation

In order to use this extension, you have to do the following steps:

In your react-native project, run `npm install react-native-livephoto --save` or `yarn add react-native-livephoto`
### XCode:
1. go to xcode's `Project Navigator` tab
<p align="center">
    <img src ="https://raw.githubusercontent.com/alinz/react-native-webview-bridge/master/doc/assets/01.png" />
</p>
2. right click on `Libraries`
3. select `Add Files to [your project's name]` option
<p align="center">
    <img src ="https://raw.githubusercontent.com/alinz/react-native-webview-bridge/master/doc/assets/02.png" />
</p>
4. navigate to `node_modules/react-native-livephoto/src` and add `Livephoto.xcodeproj` folder
<p align="center">
    <img src ="https://raw.githubusercontent.com/alinz/react-native-webview-bridge/master/doc/assets/03.png" />
</p>
5. on project `Project Navigator` tab, click on your project's name and select Target's name and from there click on `Build Phases`
<p align="center">
    <img src ="https://raw.githubusercontent.com/alinz/react-native-webview-bridge/master/doc/assets/04.png" />
</p>
6. expand `Link Binary With Libraries` and click `+` sign to add a new one.
7. select `libLivephoto.a` and click `Add` button.
<p align="center">
    <img src ="https://raw.githubusercontent.com/alinz/react-native-webview-bridge/master/doc/assets/05.png" />
</p>
8. clean compile to make sure your project can compile and build.

## Documentation
If you want save or open livephoto from Camera Roll you need add permissions in Info.plist:
```
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Your text.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Your text.</string>
```

For show livephoto from Camera Roll use the `<LivePhoto />`. The library using native picker. Call `pickLivePhoto()`.

For show livephoto from remote server/app's storage use the `<LivePhotoAssemled />`. `react-native-livephoto` is using your app cache to optimize assembly of a livephoto. You can manage memory of your app from prop `cachedPhotos` for `<LivePhotoAssembled />`.

### Functions

| Function            | Description                                                                         |
| --------------------|-------------------------------------------------------------------------------------|
| downloadLivePhoto() | `Work only with <LivePhotoAssembled />`. Download assembled LivePhoto of local file |
| pickLivePhoto()     | `Work only with <LivePhoto />`. Pick LivePhoto from Camera Roll                     |


### Props for LivePhotoAssembled component

| Prop        | Type    | Default| Description                                                           |
| ------------|---------|--------|-----------------------------------------------------------------------|
| imgUri      |`string` | `null` | `Required`! Remote/local absolute url picture(`.jpeg`) for livephoto. |
| videoUri    |`string` | `null` | `Required`! Remote/local absolute url video(`.mov`) for livephoto.    |
| cachedPhotos|`number` | `0`    | Cached livephoto count.                                               |
| vibration   |`boolean`| `true` | You can enable/disable vibration while start of playback livephoto.   |
| autoplay    |`boolean`| `true` | Will be beginning of playback when livephoto are finished assembled.  |
| style       |         | `null` | Use `react-native StyleSheet` for styling LivePhoto component.        |
| disabled       |`boolean`| `false`| You can disable livephoto for playing                                   |



### Props for LivePhoto component

| Prop           | Type    | Default| Description                                                             |
| ---------------|---------|--------|-------------------------------------------------------------------------|
| vibration      |`boolean`| `true` | You can enable/disable vibration while start of playback livephoto.     |
| autoplay       |`boolean`| `true` | Will be beginning of playback when livephoto are finished assembled.    |
| style          |         | `null` | Use `react-native StyleSheet` for styling LivePhoto component.          |
| disabled       |`boolean`| `false`| You can disable livephoto for playing                                   |


## Usage

Just import the module with one of the suggested ways:

```js
//CommonJS style
var LivePhoto = require('react-native-livephoto');
// ES6/ES2015 style
import LivePhoto from 'react-native-livephoto';
```

#### Asseble livephoto
```js
import React from 'react';
import { View, TouchableOpacity, Text, Alert } from 'react-native';
import { LivePhotoAssembled } from 'react-native-livephoto';

export default class MyLivePhotoComp extends React.Component {
  download = async () => {
    const downloadRes = await this.livephoto.downloadLivePhoto();

    if (downloadRes.success) {
      Alert.alert('All right!')
    } else {
      Alert.alert('Error!')
    }
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <LivePhotoAssembled
          ref={ref => this.livephoto = ref}
          imgUri={'remote or absolute image URL'}
          videoUri={'remote or absolute video URL'}
          autoplay={true}
          vibration={false}
          style={{ width: '100%', height: '100%' }}
        />
        <TouchableOpacity onPress={this.download}>
          <Text>Save my livephoto!</Text>
        </TouchableOpacity>
      </View>
    );
  }
}
```
#### Show livephoto
```js
import React from 'react';
import { View, TouchableOpacity, Text, Alert } from 'react-native';
import { LivePhoto } from 'react-native-livephoto';

export default class MyLivePhotoComp extends React.Component {
  pickLivePhoto = async () => {
    const pickerRes = await this.livephoto.pickLivePhoto();

    if (pickerRes.success) {
      Alert.alert('All right!')
    } else {
      Alert.alert('Error!')
    }
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <LivePhoto
          ref={ref => this.livephoto = ref}
          autoplay={true}
          vibration={false}
          style={{ width: '100%', height: '100%' }}
        />
        <TouchableOpacity onPress={this.pickLivePhoto}>
          <Text>You can pick livephoto from Camera Roll to your component LivePhoto</Text>
        </TouchableOpacity>
      </View>
    );
  }
}
```