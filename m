Return-Path: <cygwin-patches-return-5003-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9391 invoked by alias); 4 Oct 2004 14:37:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9374 invoked from network); 4 Oct 2004 14:37:51 -0000
Date: Mon, 04 Oct 2004 14:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-ID: <20041004143808.GG30976@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040923123136.GG12802@cygbert.vinschen.de> <20040923162828.CA385E4F9@wildcard.curl.com> <20040923165641.GI12802@cygbert.vinschen.de> <20041004094010.GA21035@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004094010.GA21035@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00004.txt.bz2

On Mon, Oct 04, 2004 at 11:40:10AM +0200, Corinna Vinschen wrote:
>On Sep 23 18:56, Corinna Vinschen wrote:
>> On Sep 23 12:28, Bob Byrnes wrote:
>> > OutboundQuota is just the size of the pipe.  How do we know that the
>> > cygwin ssh didn't really inherit a huge pipe from the win32-native
>> > unison?
>> 
>> We don't unless checking the the source code or the strace, I guess.
>> 
>> > The real trouble here seems to be that WriteQuotaAvailable is so low,
>> > which (if that is to be believed) indicates the pipe has almost filled.
>> > This seems similar to the sftp problem, which I am still investigating;
>> > I haven't made much progress during the past week because I've been
>> > busy with other things at work, but I have learned a few new things
>> > and I'll try to send another report as soon as I can construct a
>> > coherent explanation.
>> 
>> Cool with me.  As I noted, I didn't care for debugging this issue so
>> far so I also might be off-track.  But at least my debugging pointed
>> out where something goes wrong so I hope it was useful nevertheless.
>
>Bob?  Any news on this?  If we don't have a solution soon we should at
>least disable the code and revert to the old behaviour in the meantime,
>shouldn't we?

That would be a shame but maybe we can keep the code in and just default to
Win 9x behavior for now?

cgf
