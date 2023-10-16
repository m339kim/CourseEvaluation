# Course Evaluation Website
## Overview
In many universities, students evaluate their courses at the end of the semester, but they cannot share their feedback with each other, limiting their insight when choosing future courses. 

This website lets you develop a versatile course evaluation website applicable in any educational setting, allowing shared course insights!

## Setup
**IDE**: Eclipse EE
**Language**: Java JDK 8u161
**Database**: MySQL 5.7
**Web container**: Tomcat 8.5.94
**Framework**: Bootstrap 4.0
**Libraries**: JavaMail 1.4.7, JavaBeans Activation Framework 1.1, Popper 1.12.9, jQuery 3.7.1
> As of May 30, 2022, Google has discontinued the `Allow less secure apps` setting used for SMTP verification. Instead, we must generate an **App password**:
> 1. Manage your Google Account
> 2. Security
> 3. How you sign in to Google
> 4. 2-Step Verification
> 5. App passwords > Create
> 6. Paste the generated password to `Course Evaluation/Java Resources/src/main/java/user/util/Gmail.java `

<br>

## Functionalities
### Main Page
![Main Page](/imgs/Screenshot%202023-10-16%20at%204.12.58%20PM.png "Main Page")

### Log in or Sign up
First, log in with an existing ID or create a new account.
![Sign in page](/imgs/Screenshot%202023-10-16%20at%204.14.41%20PM.png "Sign in page")
![Verification email sent message](/imgs/Screenshot%202023-10-16%20at%204.15.09%20PM.png "Verification email sent message")

### Verify Email
A verification email with be sent to ****@gmail.com from the admin user email. Click the recieved link to proceed verification.
![Recieved email](/imgs/Screenshot%202023-10-16%20at%204.15.34%20PM.png "Recieved email")
![Verified modal](/imgs/Screenshot%202023-10-16%20at%204.16.41%20PM.png "Verified modal")

### Add a Course Evaluation
Congratulations! You can now add a course evaluation. All fields are required.
![Add course evaluation](/imgs/Screenshot%202023-10-16%20at%204.18.39%20PM.png "Add course evaluation")
See the course evaluation you added in the list of course reviews on the main page:
![See added course evaluation](/imgs/Screenshot%202023-10-16%20at%204.18.48%20PM.png "See added course evaluation")

### Report a Course Evaluation
You can submit a report to the site admin for inappropriate course evaluations.
![Report course evaluation](/imgs/Screenshot%202023-10-16%20at%204.34.47%20PM.png "Report course evaluation")
![After submitting report](/imgs/Screenshot%202023-10-16%20at%204.34.59%20PM.png "After subitting report")
Shortly after the report submission, you will recieve a confirmation email that the report has been successfully submitted to admin.
![Report confirmation email](/imgs/Screenshot%202023-10-16%20at%204.35.13%20PM.png "Report confirmation email")


### Additional Functionalities
- Like evaluations
- Delete evaluations that you wrote
- Search evaluations for a course
- Sort evaluations by Most Recent or Most Liked
