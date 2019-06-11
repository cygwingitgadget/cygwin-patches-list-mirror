Return-Path: <cygwin-patches-return-9450-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103089 invoked by alias); 11 Jun 2019 16:42:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103079 invoked by uid 89); 11 Jun 2019 16:42:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=HX-Languages-Length:2737, cleaning, claim
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 11 Jun 2019 16:42:46 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 18:42:44 +0200
Received: from [172.28.53.65]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hajr8-0002QX-P7; Tue, 11 Jun 2019 18:42:42 +0200
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
To: cygwin-patches@cygwin.com, Ken Brown <kbrown@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de> <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu> <874l51p7rt.fsf@Rainer.invalid> <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu> <b5a2e878-0282-d94e-92de-c4605dea4000@cornell.edu> <798cfd05-a12d-4f42-0a8a-f74750e78547@cornell.edu> <20190611084811.GB3520@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <70112bc2-54e0-7925-1bea-ccb3476dbcb9@ssi-schaefer.com>
Date: Tue, 11 Jun 2019 16:42:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611084811.GB3520@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00157.txt.bz2



On 6/11/19 10:48 AM, Corinna Vinschen wrote:
> Hi Ken,
> 
> On Jun  8 12:20, Ken Brown wrote:
>> On 6/7/2019 5:43 PM, Ken Brown wrote:
>>> On 6/7/2019 3:13 PM, Ken Brown wrote:
>>>> On 6/7/2019 2:31 PM, Achim Gratz wrote:
>>>>> Ken Brown writes:
>>>>>> I think I've found the problem.  I was mishandling signals that arrived during a
>>>>>> read.  But after I fix that, there's still one nagging issue involving timerfd
>>>>>> code.  I'll write to the main list with details.  I *think* it's a timerfd bug,
>>>>>> but it's puzzling that I only see it when testing my new pipe implementation.
>>>>>
>>>>> Anything triggering a race or deadlock will depend on so many other
>>>>> things that it really is no surprise to see seemingly unrelated changes
>>>>> making the bug appear or disappear.  There are certainly races left in
>>>>> Cygwin, I see them from time to time in various Perl modules, just never
>>>>> reproducible enough to give anyone an idea of where to look.
>>>>
>>>> That makes sense.
>>>>
>>>> In the meantime, I've already discovered another problem, within an hour of
>>>> posting my claim that everything was working fine: If I start emacs-X11 with
>>>> cygserver running, I can't fork any subprocesses within emacs.  I get
>>>>
>>>> 0 [main] emacs 2689 dofork: child 2693 - died waiting for dll loading, errno 11
>>>>
>>>> Back to the drawing board....  I've never looked at the cygserver code, but
>>>> maybe it will turn out to be something easy.
>>>
>>> Good news (for me): This isn't related to my pipe code.  The same problem occurs
>>> if I build the master branch.  I'll bisect when I get a chance (probably
>>> tomorrow).  In the meantime, all I can say is that strace shows a
>>> STATUS_ACCESS_VIOLATION at shm.cc:125.
>>
>> A bisection shows that the problem starts with the following commit:
> 
> Thanks for bisecting!
> 
>> commit f03ea8e1c57bd5cea83f6cd47fa02870bdfeb1c5
>> Author: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
>> Date:   Thu May 2 12:12:44 2019 +0200
>>
>>      Cygwin: fork: Remember child not before success.
>>
>>      Do not remember the child before it was successfully initialized, or we
>>      would need more sophisticated cleanup on child initialization failure,
>>      like cleaning up the process table and suppressing SIGCHILD delivery
>>      with multiple threads ("waitproc") involved.  Compared to that, the
>>      potential slowdown due to an extra yield () call should be negligible.
> 
> Please revert the patch for the time being.  Michael, this needs some
> more work, apparently.

Because of https://cygwin.com/ml/cygwin/2019-06/msg00110.html:
Is there still some problem related to that commit I need to figure out?

/haubi/
