Return-Path: <cygwin-patches-return-2970-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19077 invoked by alias); 15 Sep 2002 20:09:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19059 invoked from network); 15 Sep 2002 20:09:24 -0000
Date: Sun, 15 Sep 2002 13:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin part of pseudo-relocs patch
Message-ID: <20020915200933.GA1512@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <17051818150.20020903103820@logos-m.ru> <20020914184315.GA19372@redhat.com> <101436798232.20020915155139@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101436798232.20020915155139@logos-m.ru>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00418.txt.bz2

On Sun, Sep 15, 2002 at 03:51:39PM +0400, egor duda wrote:
>This entry point was added intentionally, to diagnose the case
>when application, linked using --enable-pseudo-relocs, is linked
>(statically or dynamically) with a runtime which doesn't support such
>relocations. Actually, i don't see the way for application to handle
>such situation in other way than simply exiting with some kind of
>"fatal error" message. I see only one drawback of my approach vs.
>"application tries to use cygwin_internal(CW_RESOLVE_PSEUDO_RELOCS)
>and fails, then printing error message and exiting". The GUI dialog
>which pops up in the former case is bad if we run our applicaton from
>other machine via ssh. In this case we won't see the dialog and will
>be unable to react accordingly. Adding 'pei386_runtime_relocator'
>symbol to libcygwin.a was also made to detect when 'new' application
>is linked to 'old' runtime at link time.

On rereading your previous description of what you are trying to do with
_pei386_runtime_relocator, I see that you generate a user level
reference via the linker to detect if the user "does the wrong thing"
and tries to link with an older libcygwin.a.

The various cygwin version numbers were designed with this kind of thing
in mind.  I wouldn't mind adding a short warning to the "linked in"
version of the crt startup code which detects a version mismatch.
Properly worded, it would, IMO, provide a much nicer end-user experience
than a cryptic "symbol not found" message or an annoying dialog box popup.

The drawback is that it would allow people to build executables that
could conceivably not work with the version of cygwin on their system
but I think that the likelihood of having a newer libcygwin.a and an
older cygwin1.dll is remote.

What I think this means is that you don't need either a function or
a cygwin_internal implementation.  You just need to add code in
_cygwin_crt0_common which checks for proper version numbers.

The other drawback to this method is that there is a tiny startup
cost penalty.  I think the possibility of having a descriptive error
message offsets that, however.

cgf
