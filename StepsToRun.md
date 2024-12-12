#### Steps used by SurveySparrow Team to run this Particular Repo: 

Add your credentials in `src/app/home/home.page.ts`

```ts
let domain = "<account-domain>";
let token = "<sdk-token>";
```

#### IOS

1. `npm i`
2. `npm start`
3. `npm run build && npx cap copy && npx cap update ios `
4. Ensure `SurveySparrowPlugin` is added in packageClassList present at `ios/App/App/capacitor.config.json`
5. Open `ios/App` in XCode and click play button to  build the app

#### Android

1. `npm i`
2. `npm start`
3. `npm run build && npx cap copy && npx cap update android `
4. Add `android/libs/survey-sparrow-android-sdk-release.aar` in the respective path
5. Run Gradle Sync
6. Open `android/` in Android Studio and click play button to  build the app


#### Node version used by SurveySparrow Team - v20.11.0