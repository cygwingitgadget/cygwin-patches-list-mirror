Return-Path: <cygwin-patches-return-2965-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9958 invoked by alias); 15 Sep 2002 11:52:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9944 invoked from network); 15 Sep 2002 11:52:33 -0000
Date: Sun, 15 Sep 2002 04:52:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <101436798232.20020915155139@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: cygwin part of pseudo-relocs patch
In-Reply-To: <20020914184315.GA19372@redhat.com>
References: <17051818150.20020903103820@logos-m.ru>
 <20020914184315.GA19372@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00413.txt.bz2

Hi!

Saturday, 14 September, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Tue, Sep 03, 2002 at 10:38:20AM +0400, egor duda wrote:
>>This is an updated cygwin part of pseudo-relocs patch.  Relocations are
>>performed inside of cygwin1.dll, as Chris suggested, and it seems to
>>work ok in case of one dll referencing another one.  After new binutils
>>package is released, it can go into cygwin release.

CF> Sorry for the long delay in reviewing this.  As the mantra goes "I've
CF> been incredibly busy".  I could tell you just how busy I am but I don't
CF> have time right now.  Anyway, I thought that this patch would take some
CF> time to review so I've been avoiding it.

CF> As it turns out, it took very little time at all.

CF> It seems to be ok, as far as I can tell, but I would prefer it if you
CF> would use the cygwin_internal interface for adding new cygwin-specific
CF> functionality.  That can allow a program to gracefully degrade when
CF> a feature is not available rather than popping up an "entry point not
CF> found" dialog.

This entry point was added intentionally, to diagnose the case
when application, linked using --enable-pseudo-relocs, is linked
(statically or dynamically) with a runtime which doesn't support such
relocations. Actually, i don't see the way for application to handle
such situation in other way than simply exiting with some kind of
"fatal error" message. I see only one drawback of my approach vs.
"application tries to use cygwin_internal(CW_RESOLVE_PSEUDO_RELOCS)
and fails, then printing error message and exiting". The GUI dialog
which pops up in the former case is bad if we run our applicaton from
other machine via ssh. In this case we won't see the dialog and will
be unable to react accordingly. Adding 'pei386_runtime_relocator'
symbol to libcygwin.a was also made to detect when 'new' application
is linked to 'old' runtime at link time.

You were suggesting to move all relocation related stuff to dll,
rather then to crt0.o. But in this case, whenever 'new' application is
loaded with new dll it'll silently start without performing any
relocations, and causing subtle and hard-to-diagnose errors later,
while running.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
