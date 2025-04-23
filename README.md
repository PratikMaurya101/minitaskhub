# minitaskhub

--------------Setup instructions-----------------------

1. Get latest version of android ndkVersion installed

    in app:build.gradle.kts
    add : 

    android {
        ndkVersion = "latestversion"
    }

2. Add provider dependency to your project by using terminal or editing pubspec.yaml

    using terminal
        flutter pub add provider
    
    or in your pubspec.yaml
        dependencies:
            provider:     //leave this space empty to get the latest version

3. Install other dependencies using terminal

    flutter pub get


-------------------Supabase setup---------------------------------

1. Add Supabase to your project using terminal

        flutter pub add supabase_flutter

2. Go to Supabase's website and create your account

3. Go to dashboard and create new project

    - Enter your project's name
    - Choose password
    - Select region

4. Get your project credentials i.e.
    - Project API key
    - Project URL

5. In your main.dart, edit the main() like

    void main() async {
        ...
    }

6. In your main.dart file in the main() add the following

    await Supabase.initialize(
        anonKey: "your-key",
        url: "your-url"
    )

Hot Reload
- Keeping the state same, injects the changes into your running app
- The current state is preserved
- Used for minor UI tweaks like changing colour etc.

Hot Restart
- Restarts the app from main()
- Rebuilds the widget tree
- State is not preserved
- Slower than Hot Reload
- When static variable or state changes are needed to be reloaded

