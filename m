Return-Path: <cygwin-patches-return-3277-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22255 invoked by alias); 4 Dec 2002 14:06:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22234 invoked from network); 4 Dec 2002 14:06:35 -0000
Message-ID: <3DEE0B91.4070208@ece.gatech.edu>
Date: Wed, 04 Dec 2002 06:06:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
References: <3DEB8ABD.80309@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00228.txt.bz2

> CF> On Mon, Dec 02, 2002 at 01:30:24PM +0300, egor duda wrote:
>>>2002-12-02  Egor Duda <deo@logos-m.ru>
>>>
>>>        * cygwin/lib/pseudo-reloc.c: New file.
>>>        * cygwin/cygwin.sc: Add symbols to handle runtime pseudo-relocs.
>>>        * cygwin/lib/_cygwin_crt0_common.cc: Perform pseudo-relocs during
>>>        initialization of cygwin binary (.exe or .dll).
> 
> CF> I'm rapidly approaching the I-don't-care-anymore state for this 

I hope that means "I don't care *either way* whether this goes in or 
not".  And doesn't mean "this whole idea can go hang for all I care; 
it's never going in".  :-)

> CF> but I am
> CF> not clear on why we need to add the changes to cygwin.sc.  This is for people
> CF> who want to link the cygwin DLL without using the appropriate header files
> CF> which label things as __declspec(dllexport) or using the appropriate libcygwin.a,
> CF> right?  Why should that matter?
> 
> Yes, you're right. This part is not needed. It's probably been left
> out from the "experimental" phase when i tried different ways to
> handle pseudo-relocs. Here's the updated one.

I've tested Egor's patch and it seems to work just fine, as demonstrated 
by the two test cases he posted last week, AND as demonstrated by the 
test case posted to the binutils list some months ago (it tested 
pseudo-reloc behavior in the child after a fork).

I've also tested Egor's runtime reloc support with Ralf's binutils "use 
the DLL as the import lib" and it ALSO works fine in all three cases.

I'm going to continue using ld.exe-ralf and 
cygwin1.dll-egor/libcygwin.a-egor for my day-to-day use, just to see if 
something wacky crops up...


Egor listed three ways to implement the runtime pseudo-reloc support. 
His recent patches used method #1 below.
---------------------------------------
 > 1. Implement everything in application (in crt0.o)

Actually, egor's patch puts the code into the static portion of libcygwin.a.

 > Benefits: Will work with any version of cygwin1.dll. All problems with
 > lack of support from runtime are detected during application linking.

Which means only the application builder needs the fancy runtime code 
installed on his system (e.g. an up-to-date libcygwin.a).  The 
application itself will run just fine on a not-so-up-to-date machine 
(within reason, of course; you probably can't use gold-standard B20.1 
release...)  Neat.

 > (Possibly) common code with mingw.
 > Drawbacks: Will require rebuilding application in case we'll want
 > change something.

This is a danger, if  pseudo-reloc.c  ever changes.

---------------------------------------
 > 2. Implement everything in cygwin1.dll.

This is right out.  Because:

 > Drawbacks: GUI window popping up when "new" application is loaded with
 > "old" runtime. Lack of support is detected only at application
 > startup.

"Entry point not found" -- not very informative for the casual user. 
Bad bad bad bad.

---------------------------------------
 > 3. Implement actual relocation in dll, and call it from crt0 via
 > cygwin_internal(). Check dll api version and print error message if
 > runtime is too old.

Meh.  Seems like a lot of overhead...

 > Benefits: Easy to change relocation semantics without relinking
 > application.

Okay, so if pseudo-reloc.c changes, everybody gets the change by virtue 
of installing a new cygwin1.dll.  But if pseudo-reloc.c changes, doesn't 
that mean that something in the linker changed?

 > Drawbacks: Lack of support is detected only at application
 > startup.

But at least we can customize the error message to something more 
informative than "Entry point not found".

But, both the builder and the user have to have the SAME version of 
cygwin1.dll, right?  Because I built the program and tested it with 
pseudo-relocs working THIS way, but the user tries to run the program 
and pseudo-relocs on her machine work THAT way...  kaboom?

 > Question: How can one distinguish console application from GUI one?
 > What is the best wording for the error message?

Yes, this scenario requires runtime warnings either console mode -- if 
we're a console app -- or GUI WinPopups if we're a GUI app.  Not a 
terrible problem; see the code snippet I posted Monday.  But it "feels" 
like we'd be piling on more and more *stuff*...incompatibility detection 
code, console-vs-GUI detection code, notification methods, 
cygwin_internal() redirection...

#1 is much simpler...and doesn't require *matching* cygwin1.dll's.
---------------------------------------

On balance, I agree that #1 is the best option.  Unless I run afoul of 
some unforseen wackiness in the next few days, recommend inclusion as is 
(in the most recent iteration, e.g. no cygwin.sc changes)

--Chuck
