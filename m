Return-Path: <cygwin-patches-return-4611-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27285 invoked by alias); 18 Mar 2004 10:22:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27275 invoked from network); 18 Mar 2004 10:22:53 -0000
content-class: urn:content-classes:message
Subject: RE: Patch for /proc/meminfo handler
Date: Thu, 18 Mar 2004 10:22:00 -0000
Message-ID: <A065B7C9B0648F4F8C43388D0D699F8D24977E@ZABRYSVCL21EX01.af.didata.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Andrew Klopper" <andrew.klopper@is.co.za>
To: <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 18 Mar 2004 09:34:45.0613 (UTC) FILETIME=[3FC7B1D0:01C40CCC]
X-SW-Source: 2004-q1/txt/msg00101.txt.bz2

Based on your results I would tend to agree that both are probably
wrong. This is the output from the unpatched DLL on my system:

> cat /proc/meminfo
         total:      used:      free:
Mem:   267829248  209637376   58191872
Swap:  185839616  377110528 4103696384
MemTotal:         261552 kB
MemFree:           56828 kB
MemShared:             0 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:         261552 kB
LowFree:           56828 kB
SwapTotal:        181484 kB
SwapFree:        4007516 kB

If you convert SwapFree from a 32 bit unsigned int to a 32 bit signed
int it it turns into a more "reasonable" negative number, which implies
that mem_total > dwAvailPageFile. Perhaps the problem lies in the
interpretation of dwTotalPageFile and dwAvailPageFile relative to
dwTotalPhys and dwAvailPhys. Unfortunately I do not have the answer at
the moment.

-----Original Message-----
From: Corinna Vinschen [mailto:vinschen@redhat.com] 
Sent: 13 March 2004 01:08 AM
To: cygwin-patches@cygwin.com
Subject: Re: Patch for /proc/meminfo handler

On Mar 12 15:14, Andrew Klopper wrote:
> With the Cygwin 1.5.7-1 DLL, 'cat /proc/meminfo' returns an incorrect 
> value for free swap space. This is most noticeable when the free 
> virtual memory is less than the total physical memory, in which case 
> the calculated free swap space is a negative value. This value is then

> converted to an unsigned int for display purposes, resulting in a very

> large positive number which is greater than the total amount of swap 
> space.
> 
> A patch to correct this problem is attached.

Well, that doesn't look right after applying your patch:

  $ cat /proc/meminfo
	   total:      used:      free:
  Mem:   536330240  230658048  305672192
  Swap:  770961408 4245790720  820137984
  MemTotal:         523760 kB
  MemFree:          298508 kB
  [...]
  SwapTotal:        752892 kB
  SwapFree:         800916 kB

The result using the original version looks much better:

  $ cat /proc/meminfo
	   total:      used:      free:
  Mem:   536330240  231788544  304541696
  Swap:  770961408  182104064  588857344
  MemTotal:         523760 kB
  MemFree:          297404 kB
  [...]
  SwapTotal:        752892 kB
  SwapFree:         575056 kB

So, perhaps both are wrong?

Please don't send patches uuencoded or in any other encoded or
compressed way.  Just add it as plain text, inline or attached.  And all
patches need a ChangeLog entry.  Have a look onto
http://cygwin.com/contrib.html which explains it thoroughly.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.





This email and all contents are subject to the following disclaimer:

"http://www.didata.com/disclaimer.asp"
