Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 537B74BA23C6; Fri, 13 Feb 2026 16:01:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 537B74BA23C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770998477;
	bh=X7LcKSLwHG54u8o53fayHukz7fvPVg0YdczA1bGwU3Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=XYtrcYgvEaMG0WPR7yGecC4aUjdGmuFUf32HQ+LIpF10vIuwUU3Rm1BeS/+cSfTOE
	 wSJnkl5o04WWtPcrwUq1ebPEL2RYgh/uAmsdemYiE2AP6Gy/iC1zySameYMgRiVBl3
	 Rziznp98txOSs+DIBldvBwrg6jwnQ1QXTK1VHvAc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 46FFBA80994; Fri, 13 Feb 2026 17:01:15 +0100 (CET)
Date: Fri, 13 Feb 2026 17:01:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: hookapi.cc: Fix some handles not being inherited
 when spawning
Message-ID: <aY9Ky2rJmDLyRqt7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <aY4Gibum9Q1gj9lp@arm.com>
 <aY45Re_bOuUxBUrz@calimero.vinschen.de>
 <3eb9430b-2457-4179-a9ab-1376da7860e3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eb9430b-2457-4179-a9ab-1376da7860e3@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Feb 13 13:32, Jon Turney wrote:
> On 12/02/2026 20:34, Corinna Vinschen wrote:
> > On Feb 12 16:57, Igor Podgainoi wrote:
> > > diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
> > > index ee2edbafe..b0126ac04 100644
> > > --- a/winsup/cygwin/hookapi.cc
> > > +++ b/winsup/cygwin/hookapi.cc
> > > @@ -45,6 +45,8 @@ PEHeaderFromHModule (HMODULE hModule)
> > >       {
> > >       case IMAGE_FILE_MACHINE_AMD64:
> > >         break;
> > > +    case IMAGE_FILE_MACHINE_ARM64:
> > > +      break;
> > >       default:
> > >         return NULL;
> > >       }
> > 
> > Pushed.
> 
> This whole switch statement looks like a wart left over from x86 times?
> 
> Either that or it should be properly checking that we're not trying to mix
> architectures somehow? (See the comment where PEHeaderFromHModule is used in
> hook_or_detect_cygwin).

Good point.

Kind of like this?

diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
index b0126ac04e3e..861eea003660 100644
--- a/winsup/cygwin/hookapi.cc
+++ b/winsup/cygwin/hookapi.cc
@@ -43,10 +43,13 @@ PEHeaderFromHModule (HMODULE hModule)
   /* Return valid PIMAGE_NT_HEADERS only for supported architectures. */
   switch (pNTHeader->FileHeader.Machine)
     {
+#ifdef __x86_64__
     case IMAGE_FILE_MACHINE_AMD64:
       break;
+#elif __aarch64__
     case IMAGE_FILE_MACHINE_ARM64:
       break;
+#endif
     default:
       return NULL;
     }


Corinna
