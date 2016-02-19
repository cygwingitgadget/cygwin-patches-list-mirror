Return-Path: <cygwin-patches-return-8339-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110838 invoked by alias); 19 Feb 2016 01:20:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110811 invoked by uid 89); 19 Feb 2016 01:20:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=reverts, waited, interfaces, Vista
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 19 Feb 2016 01:20:33 +0000
Received: from minipixel.local (unknown [IPv6:2001:4830:1141:1:ae87:a3ff:fe0b:f9a8])	by glup.org (Postfix) with ESMTPSA id 3236D854C4;	Thu, 18 Feb 2016 20:20:31 -0500 (EST)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
From: john hood <cgull@glup.org>
Subject: Re: Cygwin select() issues and improvements
To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de>
X-Enigmail-Draft-Status: N0010
Message-ID: <56C66DDE.9070509@glup.org>
Date: Fri, 19 Feb 2016 01:20:00 -0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160215125703.GE8374@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SW-Source: 2016-q1/txt/msg00045.txt.bz2

On 2/15/16 7:57 AM, Corinna Vinschen wrote:
> On Feb 14 03:09, john hood wrote:
>> [I Originally sent this last week, but it bounced.]
>>
>> Various issues with Cygwin's select() annoyed me, and I've spent some
>> time gnawing on them.
>>
>> * With 1-byte reads, select() on Windows Console input would forget
>> about unread input data stored in the fhandler's readahead buffer.
>> Hitting F1 would send only the first ESC character, until you released
>> the key and another Windows event was generated.  (one-line fix, though
>> I'm not sure it's appropriate/correct)
> 
> I think so, yes.  I applied this patch, thank you.
> 
> With the other patches I have two problems.
> 
> One of them is that they are not trivial enough to be acceptable without
> copyright assignment (except patch 3, but see below).  Please have a
> look at https://cygwin.com/contrib.html, the "Before you get started"
> section.  There's a link to an "assign.txt" file with instructions.
> 
> The other one is just this:  Can you please describe each change in the
> accompanying patch comment so that it's accessible from the git log?

Sorry for the slow response here.  I have a bad cold and I'm not getting
to things quickly.

I'll do those two things; I wanted to see if there was interest first.

>> * Newer versions of Windows may return early on timers, causing select()
>> to return early. (fixed, but other timers in Cygwin still have this problem)
> 
> It would be nice if we could discuss this a bit more in detail.  I wasn't
> aware of this change.

Microsoft official documentation:

<https://msdn.microsoft.com/en-us/library/windows/desktop/ms687069%28v=vs.85%29.aspx#waitfunctionsandtime-outintervals>

<https://msdn.microsoft.com/en-us/library/windows/hardware/jj602805%28v=vs.85%29.aspx>

Try running my socket-t program in
<https://github.com/cgull/cygwin-timeouts> as 'socket-t 10000'; it will
report the actual time waited.  On Windows 10, you will see lots of
variation in timeouts, with some of them shorter than the requested
time.  My ancient Vista laptop has much less variation and is never
shorter.  Win7 is similar.

The same behavior applies to all other uses of waitable timers in
Cygwin, I think, and perhaps all timing-related code.  It's possible
the recent patches from ArtÃºr <ikartur@gmail.com> are related to this
problem, I haven't checked.

>> * The main loop in select() has some pretty tangled logic.  I improved
>> that some.  There's room for more improvement
> 
> Definitely.
> 
>> but that would need
>> changing fhandlers and related functions.
> 
> If it makes sense, sure.

The thing that I think should happen there is that fhandlers'
select_{read,write,except}() functions should go away, and an fhandler
should only have a poll() function that indicates what's available, and
a get_waitable_object() function, that gives sel.wait() something to
sleep on.  The select_{read,write,except}() functions, and the
always_ready state variables, partially implement both of these pieces
of functionality, and really complicate the implementation for select().

I'm not sure I'll ever get to it, these Cygwin issues are very much a
side project for me.

>> Windows scheduling in general seems to be rather poor for Cygwin
>> processes, and there are scheduling differences between processes run in
>> Windows console (which are seen as interactive by the scheduler) and
>> processes run in mintty (which are not).  There doesn't seem to be any
>> priority promotion for I/O as you see on most Unix schedulers.
> 
> I'm not aware of such a feature.
> 
>> I've attached plausible patches; they're also available on
>> <https://github.com/cgull/newlib-cygwin>, branch 'microsecond-select'.
>> I think it's all Windows XP compatible.  I've put some test programs up
>> at <https://github.com/cgull/cygwin-timeouts> too.
> 
> XP/2K3 compatibility is not required anymore.  If you think you need
> a feature which is only available on Vista or later, feel free.  We just
> have to inform the Cygwin mailing list, as promised.

I don't think we need any post-XP compatibility here.

The last patch in my series reverts from the documented
CreateWaitableTimer() interfaces to the ancient, undocumented
NTCreateTimer() interfaces only for consistency with the rest of the
Cygwin codebase, which only uses NTCreateTimer().  The documented
interfaces are all present in XP.  The undocumented interfaces have all
the functionality this code needs.

I'm on #cygwin and #cygwin-dev, ask questions there if you want.

regards,

  --jh
