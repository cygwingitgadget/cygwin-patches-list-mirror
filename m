Return-Path: <cygwin-patches-return-3837-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14974 invoked by alias); 30 Apr 2003 00:59:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14964 invoked from network); 30 Apr 2003 00:59:27 -0000
Date: Wed, 30 Apr 2003 00:59:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: hostid patch
Message-ID: <20030430010018.GA21292@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <LPEHIHGCJOAIPFLADJAHMEPHDIAA.chris@atomice.net> <LPEHIHGCJOAIPFLADJAHMEIFDJAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHMEIFDJAA.chris@atomice.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00064.txt.bz2

On Tue, Apr 29, 2003 at 07:19:14PM +0100, Chris January wrote:
>> > On Tue, Apr 15, 2003 at 08:55:08PM +0100, Chris January wrote:
>> > >*Not* tested on anything other than Windows XP.
>> > >
>> > >Adds gethostid function to Cygwin. Three patches: one for 
>> Cygwin, one for
>> > >newlib and one for w32api.
>> > >If I've done anything wrong let me know and I'll try to fix it.
>> >
>> > I tried this on Windows XP and, when run repeatedly, I get two
>> > different numbers:
>> >
>> > m:\test>gethostid
>> > 0xf9926a74
>> >
>> > m:\test>gethostid
>> > 0xdfd35415
>> >
>> > The highly sophisticated program that I'm using is below.
>> >
>> > I take it this doesn't happen to you, Chris?
>> Can you send me two strace outputs with different results please?
>> There are debug_printf's all the way through the hostid function 
>> that output
>> the result at each stage and these can be used to identify which value is
>> changing between calls.
>
>ping...

Three runs, two different results:

  707  232000 [main] gethostid 1796 gethostid: 486 processor
  553  232553 [main] gethostid 1796 gethostid: processor supports CPUID instruction
  547  233100 [main] gethostid 1796 gethostid: processor has psn
  540  233640 [main] gethostid 1796 gethostid: Processor PSN: 0000-0683-0003-013A-DF26-2399
 1506  235146 [main] gethostid 1796 gethostid: MAC address of first Ethernet card: 00:B0:D0:3D:27:CD
 1033  236179 [main] gethostid 1796 gethostid: Windows Product ID: 55276-010-4501803-22964
  877  237056 [main] gethostid 1796 gethostid: hostid entropy: 00000683 DF262399 0003013A 81928167 3DD0B000 0000CD27 37323535 31302D
36 35342D30 30383130 32322D33 43A50000 00000000
  647  237703 [main] gethostid 1796 gethostid: hostid: F9926A74
---
  653  235016 [main] gethostid 3668 gethostid: 486 processor
  517  235533 [main] gethostid 3668 gethostid: processor supports CPUID instruction
  616  236149 [main] gethostid 3668 gethostid: processor has psn
  561  236710 [main] gethostid 3668 gethostid: Processor PSN: 0000-0683-0002-400B-9D56-236F
 1575  238285 [main] gethostid 3668 gethostid: MAC address of first Ethernet card: 00:B0:D0:3D:27:CD
 1103  239388 [main] gethostid 3668 gethostid: Windows Product ID: 55276-010-4501803-22964
  870  240258 [main] gethostid 3668 gethostid: hostid entropy: 00000683 9D56236F 0002400B 81928167 3DD0B000 0000CD27 37323535 31302D
36 35342D30 30383130 32322D33 43A50000 00000000
  648  240906 [main] gethostid 3668 gethostid: hostid: DFD35410
---
  646  275819 [main] gethostid 2352 gethostid: 486 processor
  545  276364 [main] gethostid 2352 gethostid: processor supports CPUID instruction
  565  276929 [main] gethostid 2352 gethostid: processor has psn
  574  277503 [main] gethostid 2352 gethostid: Processor PSN: 0000-0686-0002-400B-9D56-236F
 1627  279130 [main] gethostid 2352 gethostid: MAC address of first Ethernet card: 00:B0:D0:3D:27:CD
 1050  280180 [main] gethostid 2352 gethostid: Windows Product ID: 55276-010-4501803-22964
  963  281143 [main] gethostid 2352 gethostid: hostid entropy: 00000686 9D56236F 0002400B 81928167 3DD0B000 0000CD27 37323535 31302D
36 35342D30 30383130 32322D33 43A50000 00000000
  605  281748 [main] gethostid 2352 gethostid: hostid: DFD35415
