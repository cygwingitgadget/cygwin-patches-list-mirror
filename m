Return-Path: <cygwin-patches-return-4442-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16890 invoked by alias); 26 Nov 2003 03:48:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16880 invoked from network); 26 Nov 2003 03:48:41 -0000
Date: Wed, 26 Nov 2003 03:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031126034841.GA29778@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031126021312.GD24422@redhat.com> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <20031126021312.GD24422@redhat.com> <3.0.5.32.20031125221219.0082f690@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031125221219.0082f690@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00161.txt.bz2

On Tue, Nov 25, 2003 at 10:12:19PM -0500, Pierre A. Humblet wrote:
>At 09:47 PM 11/25/2003 -0500, you wrote:
>>On Tue, Nov 25, 2003 at 09:13:12PM -0500, Christopher Faylor wrote:
>>>Other than that minor point, this looks ok.
>>
>>Sorry.  On rereading this this sounded rather lukewarm.  I'm very happy
>>that you are fixing this problem.  I should probably let Corinna have
>>the final word on this, though.
>>
>>Thanks.
>
>OK, I will be out of town for a few days, so it would be nice if Corinna 
>could apply it as well.
>
>Regarding your remark, I had thought of putting prefix on the cygheap,
>but that looked like overkill (could be done some day, together with 
>cygwin_user_h and a few others).

This is what I said:

"Couldn't you just initialize prefix prior to calling shared_name?"

I wasn't saying that it should be on the cygheap or that it should be
only initialized once per cygwin "session".  I was saying that it could
be calculated once per program, prior to calling shared_name, avoiding
the test entirely.

cgf
