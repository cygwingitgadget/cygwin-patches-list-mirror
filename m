Return-Path: <cygwin-patches-return-4228-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30052 invoked by alias); 20 Sep 2003 16:05:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30005 invoked from network); 20 Sep 2003 16:05:54 -0000
Date: Sat, 20 Sep 2003 16:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: O_NONBLOCK for pipes
Message-ID: <20030920160547.GB24929@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1A0doP-0008SO-00.greenkaa-mail-ru@f23.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A0doP-0008SO-00.greenkaa-mail-ru@f23.mail.ru>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00244.txt.bz2

On Sat, Sep 20, 2003 at 01:13:53PM +0400, "Artem Khodush"  wrote:
>I have straightforward patch, containing about 20 lines of new code,
>which implements O_NONBLOCK fcntl for pipes using
>SetNamedPipeHandleState NT API call.
>
>Two questions before I send it:
>
>Will it be considered trivial, so that copyright assignement is not
>required?

No, sorry.

>Is there some deep reason, which I don't see, why this was not
>implemented before?

What does it buy you?  O_NONBLOCK is already implemented for pipes
without this call, AFAIK.

cgf
