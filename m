Return-Path: <cygwin-patches-return-4473-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13788 invoked by alias); 4 Dec 2003 05:29:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13779 invoked from network); 4 Dec 2003 05:29:52 -0000
Message-Id: <3.0.5.32.20031204002555.007ba380@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 04 Dec 2003 05:29:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031202092639.GD1640@cygbert.vinschen.de>
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00192.txt.bz2

At 10:26 AM 12/2/2003 +0100, you wrote:
>On Mon, Dec 01, 2003 at 10:55:46PM -0500, Pierre A. Humblet wrote:
>> Also, the utmp/wtmp functions use mutexes to insure safe access.
>> That creates two problems, particularly on servers:
>> - When users have private copies of Cygwin with different mounts,
>>   there can be several utmp/wtmp files. Having a global mutex isn't
>>   helpful.
>> - If the utmp/wtmp files are unique, a user may not be have the
>>   privilege to create a global mutex, so that no mutual protection
>>   is achieved.
>> Both problems could be solved very simply by using file locking.
>> Should I do that some day?
>
>Sure, go ahead.

Getting there, but I have questions.
1) Because I am inside cygwin, I assume I should use explicitly
   struct __flock64 and fcntl64(). 
   Or should I call fcntl_worker directly?
2) Why does struct __flock64 have a "_off_t  l_start"
   but a "_off64_t  l_len"  (in cygwin/types.h) ?
3) If I use fcntl64, shouldn't I use lseek64 as well?
   But then why does the rest of the utmp/wtmp code use lseek?

Thanks.

Pierre
