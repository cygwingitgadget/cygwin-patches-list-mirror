Return-Path: <cygwin-patches-return-2332-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17500 invoked by alias); 6 Jun 2002 02:08:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17465 invoked from network); 6 Jun 2002 02:08:22 -0000
Date: Wed, 05 Jun 2002 19:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make CW_STRACE_TOGGLE toggle
Message-ID: <20020606020836.GA2656@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01c501c20cf6$987d45b0$6132bc3e@BABEL> <20020606013422.GA851@redhat.com> <025201c20cfd$b5bf5670$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025201c20cfd$b5bf5670$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00315.txt.bz2

On Thu, Jun 06, 2002 at 02:58:53AM +0100, Conrad Scott wrote:
>> I've never had a real use for this myself, but it sounds like this is an
>> strace option, not another program.
>
>I've been using this with XEmacs so that I can get strace output just for
>some particular action. The strace log is so huge otherwise I can never find
>the output that corresponds to what I was trying to test.
>
>If this was to be another option to strace.exe, it would save the effort of
>thinking up a name for a new program :-)

Yep, sometimes that is the hardest part.

>Anyhow, I can send a patch to do just that but it'll have to be tomorrow.

How about something like 'strace [-T|--toggle] pid' where the only thing that
it does is turn strace/on off?  No other options allowed.

cgf
