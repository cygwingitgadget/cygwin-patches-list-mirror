Return-Path: <cygwin-patches-return-2529-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11354 invoked by alias); 27 Jun 2002 16:09:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11277 invoked from network); 27 Jun 2002 16:09:07 -0000
Date: Thu, 27 Jun 2002 09:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
Message-ID: <20020627160909.GE7598@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D19F55E.3070800@netscape.net> <3D19F812.70509@netscape.net> <20020627152129.GA6961@redhat.com> <3D1B3783.7030201@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D1B3783.7030201@netscape.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00512.txt.bz2

On Thu, Jun 27, 2002 at 12:04:19PM -0400, Nicholas Wourms wrote:
>Christopher Faylor wrote:
>
>>On Wed, Jun 26, 2002 at 01:21:22PM -0400, Nicholas Wourms wrote:
>>
>>>Ok,
>>>
>>>A correction:
>>>"Due to the dependancy of gettext(libintl) and gettext, this pach..."
>>>
>>>This should read:
>>>"Due to the dependancy of gettext(libintl) on libiconv, this patch..."
>>>
>>>Also, Netscape is stripping tabs, so I have attached the Changelog this 
>>>time with the hope it won't be stripped.
>>>
>>
>>Sorry, but this patch isn't acceptable.  If we are going to accommodate
>>libiconv then there needs to be a configure test for it.
>
>A better solution is to include "naked-intl" in the list of cvs modules 
>for the "winsup" ampersand module, then when utils/Makefile.in evaluates 
>"libintl:=${shell $(CC) -B$(bupdir2)/intl/ 
>--print-file-name=libintl.a}", it will statically link dumper.exe to the 
>libintl which *doesn't* depend on libiconv.

No, that's not a "better solution".  configure is what we use for situations
like this.  I don't want to have to start adding libraries to the cygwin
distribution just to work around the fact that configure isn't figuring
out what it needs to figure out.

cgf
