Return-Path: <cygwin-patches-return-3822-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16717 invoked by alias); 16 Apr 2003 12:24:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16707 invoked from network); 16 Apr 2003 12:24:14 -0000
Message-ID: <3E9D4B6A.4090303@yahoo.com>
Date: Wed, 16 Apr 2003 12:24:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: hostid patch
References: <LPEHIHGCJOAIPFLADJAHCEMJDIAA.chris@atomice.net> <20030416025654.GA21129@redhat.com> <20030416030238.GA21194@redhat.com>
In-Reply-To: <20030416030238.GA21194@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00049.txt.bz2

When patching w32api please keep in mind this reference: 
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/sdkintro/sdkintro/using_the_sdk_headers.asp

You must properly guard the declaration with the appropriate OS release 
that it was designed for.

Earnie.

Christopher Faylor wrote:
> FWIW, I've taken the unusual step of checking this patch in since I
> suspect it just needs some tweaking.  I won't build a snapshot with it
> yet, though, so that some unsuspecting person won't try to use it, run a
> configure script, and get a semi-working gethostid.
> 
> cgf
> 
> On Tue, Apr 15, 2003 at 10:56:54PM -0400, Christopher Faylor wrote:
> 
>>On Tue, Apr 15, 2003 at 08:55:08PM +0100, Chris January wrote:
>>
>>>*Not* tested on anything other than Windows XP.
>>>
>>>Adds gethostid function to Cygwin. Three patches: one for Cygwin, one for
>>>newlib and one for w32api.
>>>If I've done anything wrong let me know and I'll try to fix it.
>>
>>I tried this on Windows XP and, when run repeatedly, I get two
>>different numbers:
>>
>>m:\test>gethostid
>>0xf9926a74
>>
>>m:\test>gethostid
>>0xdfd35415
>>
>>The highly sophisticated program that I'm using is below.
>>
>>I take it this doesn't happen to you, Chris?
>>
>>cgf
>>
>>#include <unistd.h>
>>
>>int
>>main (int argc, char **argv)
>>{
>> printf ("%p\n", gethostid ());
>> exit (0);
>>}
> 
> 
