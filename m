Return-Path: <cygwin-patches-return-2974-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 754 invoked by alias); 16 Sep 2002 09:05:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 719 invoked from network); 16 Sep 2002 09:05:40 -0000
Date: Mon, 16 Sep 2002 02:05:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <14513084897.20020916130307@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: cygwin part of pseudo-relocs patch
In-Reply-To: <20020915200933.GA1512@redhat.com>
References: <17051818150.20020903103820@logos-m.ru>
 <20020914184315.GA19372@redhat.com> <101436798232.20020915155139@logos-m.ru>
 <20020915200933.GA1512@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00422.txt.bz2

Hi!

Monday, 16 September, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Sun, Sep 15, 2002 at 03:51:39PM +0400, egor duda wrote:
>>This entry point was added intentionally, to diagnose the case
>>when application, linked using --enable-pseudo-relocs, is linked
>>(statically or dynamically) with a runtime which doesn't support such
>>relocations. Actually, i don't see the way for application to handle
>>such situation in other way than simply exiting with some kind of
>>"fatal error" message. I see only one drawback of my approach vs.
>>"application tries to use cygwin_internal(CW_RESOLVE_PSEUDO_RELOCS)
>>and fails, then printing error message and exiting". The GUI dialog
>>which pops up in the former case is bad if we run our applicaton from
>>other machine via ssh. In this case we won't see the dialog and will
>>be unable to react accordingly. Adding 'pei386_runtime_relocator'
>>symbol to libcygwin.a was also made to detect when 'new' application
>>is linked to 'old' runtime at link time.

CF> On rereading your previous description of what you are trying to do with
CF> _pei386_runtime_relocator, I see that you generate a user level
CF> reference via the linker to detect if the user "does the wrong thing"
CF> and tries to link with an older libcygwin.a.

CF> The various cygwin version numbers were designed with this kind of thing
CF> in mind.  I wouldn't mind adding a short warning to the "linked in"
CF> version of the crt startup code which detects a version mismatch.
CF> Properly worded, it would, IMO, provide a much nicer end-user experience
CF> than a cryptic "symbol not found" message or an annoying dialog box popup.

CF> The drawback is that it would allow people to build executables that
CF> could conceivably not work with the version of cygwin on their system
CF> but I think that the likelihood of having a newer libcygwin.a and an
CF> older cygwin1.dll is remote.

If users installs new cygwin, builds an application and then rolls
back to an older dll for some reason. Usually, this leads exactly to
the behaviour we're trying to prevent: If application uses some symbol
from dll, which has just been exported (like strlcat, or strptime, or
whatever) then user gets 'symbol not found' dialog. I get those
constantly when shuffling different custom-built and released versions
of dll.

In this sense, 'having an ability to handle pseudo-relocations' is,
IMHO, pretty similar to 'having an ability to perform strptime()'

CF> What I think this means is that you don't need either a function or
CF> a cygwin_internal implementation.  You just need to add code in
CF> _cygwin_crt0_common which checks for proper version numbers.

CF> The other drawback to this method is that there is a tiny startup
CF> cost penalty.  I think the possibility of having a descriptive error
CF> message offsets that, however.

I don't care much about startup cost, as it's indeed negligible. What
really worries me is a possibility that new application somehow
manages to load silently with old runtime. Yet if we'll decide that
the latter is not of much concern and that we can minimize the chance
of its occurance, then i'll modify my patch so that relocations are
handled via cygwin_internal() call and crt0 code checks if there are
any relocations, checks dll version and exit with fatal error message
if relocations are present and dll is too old.

BTW, what to do in case of '-mwindows'? AFAICS, such applicatons use
the same crt0 as console ones.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
