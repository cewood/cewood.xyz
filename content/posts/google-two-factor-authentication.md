---
title: "Setting up two-factor auth for Google"
date: 2018-03-10T15:00:39+01:00
tags: ["google", "two-factor-auth", "security"]
draft: false
---

I made this post for my parents, who finally wanted to set up two-factor authentication for their Google accounts.

It's a picture heavy walkthrough of setting up two-factor authentication on Google, backing up the code, and generating recovery codes.

## Quick overview of the process:

 1. Go to your Google account
 1. Go to the Sign-in & Security settings
 1. Configure a recovery email address
 1. Configure a recovery phone number
 1. Go to the 2-Step Verification settings
 1. Configure 2-Step Verification by phone (temporary only)
 1. Go to the 2-Step Verification alternative methods
 1. Configure 2-Step Verification by Authenticator app
 1. Generate backup codes
 1. Profit


## Detailed walkthrough:

1. Go to your Google account

    This can be by whatever means is most convenient, for many that could be via the account badge in top right bar of Gmail, as shown in the screenshot below:

    ![My account](/images/2fa-google/01_my-account.png)

    ---


1. Go to the Sign-in & Security settings

    Once in Google account page, navigate to the "Sign-in & security" settings page by clicking on the heading, as shown in the screenshot below:

    ![Sign-in & Security settings](/images/2fa-google/02_sign-in-and-security.png)

    Then scroll down and you will see the "Sign-in & security" settings overview, as shown in the screenshot below:

    ![Security settings overview](/images/2fa-google/03_overview.png)

    ---


1. Configure a recovery email address

    Setup a recovery email address for your account, by clicking on the "Recovery email" heading from the "Sign-in & security" settings overview page, you will then be presented with a prompt like the screenshot below:

    ![Recovery email](/images/2fa-google/04_recovery-email.png)

    ---


1. Configure a recovery phone

    Setup a recovery phone number for your account, by clicking on the "Recovery phone" heading from the "Sign-in & security" settings overview page, you will then be presented with a prompt like the screenshot below:

    ![Recovery phone](/images/2fa-google/05_recovery-phone.png)

    ---


1. Go to the 2-Step Verification settings

    To configure 2-Step Verification click on the "2-Step Verification" heading, as shown in the screenshot below:

    ![Security settings overview](/images/2fa-google/03_overview.png)

    ---


1. Configure 2-Step Verification by phone (temporary only)

    To enable 2-Step Verification you first have to enable the phone method, which will use SMS or Voice (computer) calls to send you a secret confirmation code. After you set up and confirm this method, you'll be able to configure alternate methods, such as Authenticator which uses TOTP (time based one time password).

    To begin the process, select your country, and enter you phone number at the prompt, as shown in the screenshot below:

    ![2-Step verification phone setup](/images/2fa-google/06_two-step-phone-setup.png)

    Then enter the verification code you received via SMS at the prompt, as shown in the screenshot below:

    ![2-Step verification phone confirm](/images/2fa-google/07_two-step-phone-confirm.png)

    If verification succeeded, then click "Turn on" to finish the process, as shown in the screenshot below:

    ![2-Step verification phone success](/images/2fa-google/08_two-step-phone-success.png)

    If everything went correctly, then you'll now see the "Voice or text message (Default)" entry on the "2-Step Verification" overview page, as shown in the screenshot below:

    ![2-Step verification phone completed](/images/2fa-google/09_two-step-phone-completed.png)

    ---


1. Go to the 2-Step Verification alternative methods

    With 2-Step Verification configured for SMS, you can now configure alternative methods, like Authenticator.

    To configure Authenticator (which will replace/override SMS), click on the Authenticator heading, as shown in the screenshot below:

    ![2-Step verification alternate overview](/images/2fa-google/10_two-step-alternate-overview.png)

    ---


1. Configure 2-Step Verification by Authenticator app

    Select the appropriate platform for your phone, and click next, as shown in the screenshot below:

    ![2-Step verification authenticator](/images/2fa-google/11_two-step-authenticator.png)

    If you don't already have the Authenticator application installed (or a suitable equivalent), then go do that now, so you can proceed by scanning the QR code, as shown in the screenshot below:

    ![2-Step verification authenticator setup](/images/2fa-google/12_two-step-authenticator-setup.png)

    Now assuming you successfully scanned the QR code, **don't** click next. Instead click on "Can't scan it" to reveal the secret as a text string, this allows us to backup the secret somewhere securely, in case we want to change phones later (easily). So copy the secret down somewhere safe, and now click next, as shown in the screenshot below:

    ![2-Step verification authenticator backup](/images/2fa-google/13_two-step-authenticator-backup.png)

    Using the authenticator or equivalent app you installed before, lookup the token/code for your Google account, and enter it into the confirmation prompt, as shown in the screenshot below:

    ![2-Step verification authenticator validate](/images/2fa-google/14_two-step-authenticator-validate.png)

    If everything went well you will see a confirmation screen which means you're almost done, as shown in the screenshot below:

    ![2-Step verification authenticator success](/images/2fa-google/15_two-step-authenticator-success.png)

    ---


1. Generate backup codes

    Now that you have 2-Step Verification enabled, it's always good practice to have some backup codes available. This is handy if you loose your phone, and suddenly can't use the Authenticator, nor are you able to receive the SMS codes as a fallback. So this is when backup codes can really come in handy. To generate backup codes, simply click on "Set up" under the "Backup codes" entry on the 2-Step Verification alternative methods page, as shown in the screenshot below:

    ![2-Step verification alternate overview](/images/2fa-google/10_two-step-alternate-overview.png)

    You will then be presented with a prompt like the one below, containing your 10 backup codes. Copy these down somewhere safe and secure, a secure password safe program is an ideal candidate. Also you may want to try the download option to get these codes in basic ASCII format, without any HTML glyphs.

    ![2-Step verification backup codes](/images/2fa-google/16_two-step-backup-codes.png)

    ---


1. Profit

    If you've made it this far then you're now all set up, your "Sign-in & security" settings overview should now look something like the screenshot below:

    ![2-Step verification overview](/images/2fa-google/17_two-step-overview.png)

    Remember to keep the secret code and backup codes safe. You now have a very strongly secured Google account, so you can worry less about someone guessing your password, instead you now need to make sure your computer, phone, and password safe are never compromised :)

    ---

