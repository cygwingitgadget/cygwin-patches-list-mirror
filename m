Return-Path: <cygwin-patches-return-3823-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4336 invoked by alias); 16 Apr 2003 16:08:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4309 invoked from network); 16 Apr 2003 16:08:30 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3E9D7FF3.30908@gmx.net>
Date: Wed, 16 Apr 2003 16:08:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [RFA] enable finline-functions optimization
References: <Pine.WNT.4.44.0304151046400.259-200000@algeria.intern.net> <20030416030635.GA21371@redhat.com>
In-Reply-To: <20030416030635.GA21371@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00050.txt.bz2

Christopher Faylor wrote:
> On Tue, Apr 15, 2003 at 10:59:13AM +0200, Thomas Pfaff wrote:
>>It seems that  __attribute__(used) does not work in conjunction with
>>__asm__ ("function name without _"). If i remove the  __asm__ stuff it
>>works as expected.
>>This patch will keep the functions static.
> Ok.  Feel free to checkin, in that case.  Out of curiousity, what version
> of gcc are you using?  3.2?

gcc version 3.2 20020927 (prerelease)

My gcc is build with sjlj exceptions to avoid problems with stdcall 
functions and exceptions and a patch to the w32-sharedptr handling that 
was included in the cygwin-mingw branch by Danny, but that shouldn't be 
the problem here.

BTW, are there any plans for a gcc-3.2.2 release ?

Thomas
