Return-Path: <cygwin-patches-return-4748-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13621 invoked by alias); 13 May 2004 21:03:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13600 invoked from network); 13 May 2004 21:03:07 -0000
Date: Thu, 13 May 2004 21:03:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040513210306.GD11731@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com> <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00100.txt.bz2

On Thu, May 13, 2004 at 03:28:12PM -0500, Brian Ford wrote:
>On Thu, 13 May 2004, Christopher Faylor wrote:
>
>> >I can't seem to make a muto fit this situation cleanly since it would
>> >have to be acquired and released by the same thread.
>>
>> Why would it be acquired and released from the same thread?
>
>What I was trying to say is that a muto must be acquired and released from
>the same thread.  But here, we want to block all threads calling gethwnd
>until the window thread has initialized.
>
>> Isn't the problem that multiple people are calling gethwnd?
>
>Concurrently, before ourhwnd has been initialized, yes.
>
>> You even mention this in the ChangeLog below.  Given that, the place to
>> put a mutex would seem to be in gethwnd.
>
>It seems to me that you would still need the window_started event then,
>no?  Since a muto contains an event, why use two?  I thought this was
>lighter weight.

Either the hwnd exists or it doesn't.

If it does exist, just return it.  No locking required.

If it doesn't exist, acquire the muto.  Does the hwnd exist now?
If so, release the muto and return the hwnd.

Otherwise, set up hwnd, release the muto and return hwnd.

cgf
