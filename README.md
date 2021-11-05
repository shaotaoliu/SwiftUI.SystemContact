# SystemContact

This app is similar to the Contacts app on iPhone. It fetches the contacts from the Contact framework and saves the changes back to the Contact framework.

When the app starts, it loads all the contacts. To save memory, only the family name and given name (and identifier) are fetched.

![image](https://user-images.githubusercontent.com/15805568/140265054-db00485d-068f-40fd-be41-139547037885.png)

If the user has no permission to access the Contacts framework, an error will be shown and the screen is disabled.

![image](https://user-images.githubusercontent.com/15805568/140265324-cd019157-ef3b-475d-abfe-1fe816fbe515.png)

To delete a contact, swipe a contact row to the left. A confirmation dialog will show and click the Delete button will delete the contact permanently.

![image](https://user-images.githubusercontent.com/15805568/140265606-961824e4-ba37-40aa-b2bf-5aa7bfdde93b.png)

To add a new contact, tap the plus sign.

![image](https://user-images.githubusercontent.com/15805568/140265742-2e7b5adb-d361-4781-8d09-b56a5d16f949.png)
![image](https://user-images.githubusercontent.com/15805568/140265805-dfb39f9a-707c-4c9d-b05f-ae93680e2571.png)

Click "Add Photo" button to add a photo from the Album.

![image](https://user-images.githubusercontent.com/15805568/140265986-724403b7-452d-475e-94b6-28040186ae9b.png)
![image](https://user-images.githubusercontent.com/15805568/140266053-260d1dc8-e88e-4e3f-a2b3-0f7de39decda.png)

You can add multiple phones, emails, addresses, and urls. 

![image](https://user-images.githubusercontent.com/15805568/140268410-ba7bb3ee-e5ba-426b-a9ee-d320ec9afb4e.png)
![image](https://user-images.githubusercontent.com/15805568/140268279-4ea2b5d1-0985-48bc-8ea4-13dd5b67d8bb.png)

Click a contact in the list of the main screen will show the details of the contact. The contact with the identifier will be fetched from ContactStore.

![image](https://user-images.githubusercontent.com/15805568/140267860-ad46b77f-6a24-430a-8669-466cfe809f8d.png)

If you want to modify it, click the Edit button.

![image](https://user-images.githubusercontent.com/15805568/140267944-223e0e47-af63-4947-8ae1-247eb79b2f00.png)

Same as the Contacts app on iPhone, there is a Delete button at the bottom of the edit screen. You can delete the contact from the edit screen too.

![image](https://user-images.githubusercontent.com/15805568/140268016-b94d1a3c-4965-4d05-a29f-1fccc8cc5782.png)

At the beginning, I used Picker to select the types of the phones, emails, addresses, and urls, and countries; however, I found two issues:
1. The text (home, work, etc.) is right alignment and I cannot make it left alignment.
2. Because the picker is in a row of the Form, tapping the TextField on its right also opens the picker dialog.

To make it work better, I create my own picker.

![image](https://user-images.githubusercontent.com/15805568/140269400-9d66fcad-77fe-4dc4-9d98-4497ad7396f7.png)

TODO: Should use the structure of SwiftUI.ItemList2 which is better.
