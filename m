Return-Path: <cygwin-patches-return-2528-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8665 invoked by alias); 27 Jun 2002 16:05:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8635 invoked from network); 27 Jun 2002 16:05:08 -0000
Message-ID: <3D1B3783.7030201@netscape.net>
Date: Thu, 27 Jun 2002 09:09:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
References: <3D19F55E.3070800@netscape.net> <3D19F812.70509@netscape.net> <20020627152129.GA6961@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00511.txt.bz2

Christopher Faylor wrote:

>On Wed, Jun 26, 2002 at 01:21:22PM -0400, Nicholas Wourms wrote:
>
>>Ok,
>>
>>A correction:
>>"Due to the dependancy of gettext(libintl) and gettext, this pach..."
>>
>>This should read:
>>"Due to the dependancy of gettext(libintl) on libiconv, this patch..."
>>
>>Also, Netscape is stripping tabs, so I have attached the Changelog this 
>>time with the hope it won't be stripped.
>>
>
>Sorry, but this patch isn't acceptable.  If we are going to accommodate
>libiconv then there needs to be a configure test for it.
>
>cgf
>
Chris,

A better solution is to include "naked-intl" in the list of cvs modules 
for the "winsup" ampersand module, then when utils/Makefile.in evaluates 
"libintl:=${shell $(CC) -B$(bupdir2)/intl/ 
--print-file-name=libintl.a}", it will statically link dumper.exe to the 
libintl which *doesn't* depend on libiconv.  Otherwise, it will evaluate 
to be /usr/lib/libintl.a, which is dependant on libiconv if you are 
using the gettext > 10.40.  I think this would be a better solution 
because dumper.exe doesn't use any of the features provided by libiconv, 
so why use what isn't needed?  Furthermore, FWICT, src/intl doesn't 
install anything durning "make install", so nothing should get 
clobbered.  I'm going to checkout "naked-intl" to test this theory and 
re-run the build.  I'll report my findings shortly...

Cheers,
Nicholas
