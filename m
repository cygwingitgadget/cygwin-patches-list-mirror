Return-Path: <cygwin-patches-return-4586-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29810 invoked by alias); 3 Mar 2004 14:14:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29799 invoked from network); 3 Mar 2004 14:14:16 -0000
Date: Wed, 03 Mar 2004 14:14:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: Final patch for audio recording with /dev/dsp
Message-ID: <20040303140851.GA13034@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C3FF0F.B9D54520.Gerd.Spalink@t-online.de> <20040303095543.GC1587@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303095543.GC1587@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
Resent-From: Christopher Faylor <cgf@redhat.com>
Resent-Date: Wed, 3 Mar 2004 09:14:20 -0500
Resent-To: cygwin-patches@cygwin.com
Resent-Message-Id: <20040303141420.7106C400020@redhat.com>
X-SW-Source: 2004-q1/txt/msg00076.txt.bz2

On Wed, Mar 03, 2004 at 10:55:43AM +0100, Corinna Vinschen wrote:
>[Sorry for the delay, I didn't realize that my mail to cygwin-patches
> didn't come through]
>
>Hi Gerd,
>
>thanks for the patch, but regardless of the content, it's not acceptable
>for a few stylistic reasons:
>
>- All sentences end in a full stop in the ChangeLog.
>
>- Could you please change all one line if expressions like this:
>
>    if (head_ == depth1_) head_ = 0;
>
>  to
>
>    if (head_ == depth1_)
>      head_ = 0;
>
>- Please change `*(buffer+1)' to `*(buffer + 1)'.

Or better yet, in that case:  buffer[1]

cgf
