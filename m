Return-Path: <cygwin-patches-return-2530-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12767 invoked by alias); 27 Jun 2002 16:52:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12737 invoked from network); 27 Jun 2002 16:52:36 -0000
Message-ID: <3D1B4293.30707@netscape.net>
Date: Thu, 27 Jun 2002 09:58:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
References: <3D19F55E.3070800@netscape.net> <3D19F812.70509@netscape.net> <20020627152129.GA6961@redhat.com> <3D1B3783.7030201@netscape.net> <20020627160909.GE7598@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00513.txt.bz2

Christopher Faylor wrote:

>On Thu, Jun 27, 2002 at 12:04:19PM -0400, Nicholas Wourms wrote:
>
>>A better solution is to include "naked-intl" in the list of cvs modules 
>>for the "winsup" ampersand module, then when utils/Makefile.in evaluates 
>>"libintl:=${shell $(CC) -B$(bupdir2)/intl/ 
>>--print-file-name=libintl.a}", it will statically link dumper.exe to the 
>>libintl which *doesn't* depend on libiconv.
>>
>
>No, that's not a "better solution".  configure is what we use for situations
>like this.  I don't want to have to start adding libraries to the cygwin
>distribution just to work around the fact that configure isn't figuring
>out what it needs to figure out.
>
Chris,

I stand corrected... As it turns out, my theory doesn't work anyway. 
 So, I will have configure check for the existance of gettext > 10.40 
and any dependancies on libiconv.  I will work up a patch but I need to 
know if this will require a copyright assignment, as undoubtly it will 
entail more then 10 lines of configure script changes.  So if this is 
the way you want to go, then let me know and I'll do so.

On another note, I really think having seperate configure files for 
every directory is a tad bit redundant.  Are there any plans to migrate 
to Automake templates and/or a single configure script for the winsup tree?

Cheers,
Nicholas
