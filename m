Return-Path: <cygwin-patches-return-1602-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23286 invoked by alias); 19 Dec 2001 06:39:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23268 invoked from network); 19 Dec 2001 06:39:02 -0000
Message-ID: <023601c18857$c37d36e0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKKEPHCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Setup.exe in a property sheet
Date: Wed, 07 Nov 2001 05:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 19 Dec 2001 06:38:59.0852 (UTC) FILETIME=[D74944C0:01C18857]
X-SW-Source: 2001-q4/txt/msg00134.txt.bz2

Ok, first glance:

You've diffed across versions - please update both the clean dir and
your working dir for the next patch. Thats a major reason the patch is
so big.

* please use win32 thread API calls, not _beginthread et al.
* All classes with an explicit destructor need copy constructors and
operator =. (If they aren't used, declare but don't implement). Reason:
synthesised copy constructors and assignment operators will be wrong.
(And yes, this is wrong elsewhere in setup too).
* varargs and C++ don't mix from what I'm told. (because objects passed
in lose information). It's probably ok for your string class... but I'm
not sure why it exists?
* To test if something is not needed, comment it out and see if you get
link errors.
* have you run this through indent?
* the #if 0...#endifs should go. Delete the code or document why it's
not deleted.
* I don't like the PropertyPage semnatics - Why is Create not the
constructor?
* The propertysheet/propertypage friend relationship would be good to
have correct.
* please keep CVSID's in source files. They aren't used in the code, but
I find them useful for review.
* The ThreeBar refactoring seems incomplete - it is dependent on the end
user functions, rather than the other way around. It seems to me that
the ThreeBar refactor should implement/provide a control but not create
threads for the install process...
* I'd rather not see _any_ structs - use class's with all public members
if needed.
* is chooser.o going to be equivalent to choose.o? If so then just
fiddle choose.o please. I commit my changes quite frequently so we won't
collide much.

Lastly, I think it would be a good idea (if possible) to do the
refactoring bit-by-bit in future. i.e. factor in the Window class and
the threeline progress bar. Then the class conversion for the pages.
etc. That just reduces the risk of a huge commit.

Rob
