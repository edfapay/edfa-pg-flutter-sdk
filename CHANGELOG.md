## 0.0.2
Enhancements
- Updated Readme

## 0.0.3
Enhancements
- Update native dependency
- Fix build issues
- Migrate and fix ApplePay for iOS

## 0.0.4
Resolve ios pluginClass

## 0.0.5
Conditional bug fix

## 0.0.6
Error Handling
Card expiry validation
Change payment url

## 0.0.9
Change android native deps

## 0.0.9
Exception handling on error

## 2.0.0
Added 3 new UI screens for card detail input

## 2.0.0+1
Added 3 new UI screens for card detail input
 - Fixes Bug
 - Enhancement in Code
 - Changed and Unified Naming Conventions

## 2.0.1
- Update Card UI
- Handling double tap on andorid
- Enhancement

## 2.0.2
- Update Text Translation
- Enhancement

## 2.0.3
- Added **Recurring** to sale
  - Added to below
  >   ### EdfaCardPay
  >   ```dart
  >    EdfaCardPay()
  >       .setRecurring(true/false)
  >       ...
  >   ```
  >   ### EdfaPayWithCard
  >   ```dart
  >    EdfaPayWithCard()
  >       .setRecurring(true/false)
  >       ...
  >   ```

## 2.0.4
Random bug fix & enhancement

## 2.0.5
- Added **Auth** to sale transaction
  - Added to below
  >   ### EdfaCardPay
  >   ```dart
  >    EdfaCardPay()
  >       .setAuth(true/false)
  >       ...
  >   ```
  >   ### EdfaPayWithCard
  >   ```dart
  >    EdfaPayWithCard()
  >       .setAuth(true/false)
  >       ...
  >   ```

## 2.0.8
- Random Fix and enhancements
- Glitch in Card Entry Screen

## 2.0.8+1
- Random Fix and enhancements
- Native sdk version via pubspec.yaml at flutter project level

## 2.0.8+2
- Random Fix and enhancements
- Fix android gradle fall-back version

## 2.0.9
- Random Fix and enhancements
- Fix android gradle fall-back version
- **Native Version**
  - Android: **2.1.2**
  - iOS: **~> 2.0.7**
- **Developer can now pass the native version for android as below.**
  - **Android:**
    - In project `pubspec.yaml` define the edfapay_properties as below:
    > ```yaml
    > # ⚠️ IMPORTANT:
    > # The "edfapay_properties" key must start at the beginning of the line (no indentation).
    >
    > edfapay_properties:
    >   pg_android: "2.1.2"
    > ```
    _Note: The "edfapay_properties" key must start at the beginning of the line (no indentation)_


- iOS:
  - Coming soon
  - 

## 2.0.9+6
- 2.0.9
  - Random Fix and enhancements
  - Fix android gradle fall-back version
  - **Native Version**
    - Android: **2.1.2**
    - iOS: **~> 2.0.7**
  - **Developer can now pass the native version for android as below.**
    - **Android:**
      - In project `pubspec.yaml` define the edfapay_properties as below:
    >   ```yaml
    >   # ⚠️ IMPORTANT:
    >   # The "edfapay_properties" key must start at the beginning of the line (no indentation).
    >
    >   edfapay_properties:
    >     pg_android: "2.1.2"
    >   ```
      _Note: The "edfapay_properties" key must start at the beginning of the line (no indentation)_
    
    ------
    - **iOS**:
        - Coming soon
- +1
    - Random Fix
- +2
    - Random Fix
- +3
    - Random Fix
- +4
    - Random Fix
- +5
    - Random Fix
- +6
    - Allow adding extra info in sale




