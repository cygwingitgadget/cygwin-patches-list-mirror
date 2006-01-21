Return-Path: <cygwin-patches-return-5717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10289 invoked by alias); 21 Jan 2006 07:10:34 -0000
Received: (qmail 10277 invoked by uid 22791); 21 Jan 2006 07:10:33 -0000
X-Spam-Check-By: sourceware.org
Received: from bay103-f10.bay103.hotmail.com (HELO hotmail.com) (65.54.174.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 21 Jan 2006 07:10:32 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC; 	 Fri, 20 Jan 2006 23:10:31 -0800
Message-ID: <BAY103-F10482309B205ED1887658FD31E0@phx.gbl>
Received: from 65.54.174.200 by by103fd.bay103.hotmail.msn.com with HTTP; 	Sat, 21 Jan 2006 07:10:30 GMT
X-Sender: devinteske@hotmail.com
From: "Devin Teske" <devinteske@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc:
Subject: full .lnk support
Date: Sat, 21 Jan 2006 07:10:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00026.txt.bz2

Hey there,

first time poster, but I'm not a member of the list, so please reply 
directly.

After 8 long months, I have fully reverse-engineered the Windows `.lnk' 
(shortcut) file format and have a core function set for creating/resolving 
them. I know that cygwin ALREADY understands Windows shortcuts, but not only 
barely. Cygwin does not resolve shortcuts created by windows.

It is worth noting that there are multiple versions of the shortcut file 
format (binary fields were added in Windows NT/2000/XP that differ from Win 
9x). Also, when cygwin creates a shortcut, it does not have the icon of the 
source file when viewed in explorer (not going to explain why exactly, I'll 
keep it short for now) because cygwin (to be blunt) creates crappy shortcut 
files.

I can personally attest to the most difficult task it was to decipher the 
binary format of this file (it's not documented anywhere, because Microsoft 
does not want you to create them manually but use the Shell32 API). However, 
I'm able to create them and they have support for all the enhanced features 
of the new format (Win XP) as well as the original version (Win 9x/NT/2000). 
Windows doesn't know any better that they were created manually (as binary 
data). However, cygwin craps out reading them, because it can't read 
anything but the stunted format (cygwin uses a constant string literal for 
the header which doesn't match the real deal).

I know that if you simply just wanted full/native shortcut support, you'd 
just use the Win32 API to create/manage them, however one of the advantages 
of doing it the way I did, means that I can create them without the Win32 
API (ie. on Mac OS X, UNIX, Linux, etc.). Which also means that you could 
say... build this into samba to understand shortcuts that clients running 
windows create on the share.

Well, the whole point of me writing this is to assess the value of something 
like this and whether it is something that is wanted. I think that it might 
be a nice addition (as I've been a long time cygwin user, and am hesitant to 
switch to SFU or anything else). Would like to know that if I contribute 
this, that it is something that will be gladly welcomed since it took such a 
long time to reverse engineer that god-forsaken format.

Cheers,
Devin

