Return-Path: <cygwin-patches-return-3901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26508 invoked by alias); 26 May 2003 12:29:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26479 invoked from network); 26 May 2003 12:29:17 -0000
Message-Id: <3.0.5.32.20030526082920.00818e90@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Mon, 26 May 2003 12:29:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: df and ls for root directories on Win9X
In-Reply-To: <20030526081141.GB5976@cygbert.vinschen.de>
References: <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
 <20030525091901.GA875@cygbert.vinschen.de>
 <3.0.5.32.20030523183423.008059c0@mail.attbi.com>
 <20030525091901.GA875@cygbert.vinschen.de>
 <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00128.txt.bz2

At 10:11 AM 5/26/2003 +0200, Corinna Vinschen wrote:
>On Sun, May 25, 2003 at 05:54:32PM -0400, Pierre A. Humblet wrote:
>> Meanwhile I found out that my statfs change fixing the MS GetFreeDiskSpace
>> bug exposes (on WinME only) a MS GetFreeDiskSpaceEx bug.
>> <http://support.microsoft.com/default.aspx?scid=kb%3ben-us%3b314417>  
>> 
>> Experimentally, that can be fixed by calling GetFreeDiskSpaceEx before
>> GetFreeDiskSpace, but not more than once per 3 sec... BTW, looking
>> up the disk properties in Windows has the same feature.
>
>Did you actually test that?  The KB article doesn't tell anything about
>calling GetFreeDiskSpace after GetFreeDiskSpaceEx fixing the problem.
>It just says calling GetFreeDiskSpace instead ofGetFreeDiskSpaceEx is
>a possible workaround (very funny).
>
Yes, I did test it. The bug above is due to a caching problem. 
Calling GetFreeDiskSpace fills the cache and the subsequent 
GetFreeDiskSpaceEx gets the wrong value. In fact that was frustrating 
to debug because it doesn't happen when you step through gdb 
(more than 3 sec before the calls ).
In all of MS examples either GetFreeDiskSpaceEx or GetFreeDiskSpace 
gets called, never both. That's probably why they don't mention this
specific combination. We need both because the Ex call doesn't report
cluster size.

>OTOH, there's a fix for ME available at Micosoft.

Yep, but apparently involves calling MS. It's not part of the regular
Windows update.

Pierre 
