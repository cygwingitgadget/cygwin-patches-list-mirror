Return-Path: <cygwin-patches-return-2754-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6888 invoked by alias); 31 Jul 2002 02:01:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6874 invoked from network); 31 Jul 2002 02:01:54 -0000
Date: Tue, 30 Jul 2002 19:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Performance: fhandler_socket and ready_for_read()
Message-ID: <20020731020213.GC21291@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com> <086701c2382f$2c6b19b0$6132bc3e@BABEL> <20020731012133.GB21134@redhat.com> <08e301c23833$d05627f0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e301c23833$d05627f0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00202.txt.bz2

On Wed, Jul 31, 2002 at 02:44:29AM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>>You don't have to worry about non_blocking or returning the base class
>>because you know that it is not intended to be called for the
>>non_blocking case and you know that sockets are "slow" devices.  So I
>>think this should only be gated on whether we're lucky enough to be
>>using winsock2.
>
>I realised that when I wrote it but I had some sort of aesthetic
>criteria reaction: like not relying on the caller to be doing the right
>thing; or, like making the change as precise as possible.

But we already rely on the caller to be doing the right thing in the
base class.  The reason for this is that the non-blockingness of an fd
has nothing to do with whether the method can correctly deal with
signals.

>Also if the setting of the NOEINTR flag is going to overridden
>completely like this, perhaps set_r_no_interrupt() ought to be
>virtual and overridden in fhandler_socket to generate an error,
>just in case someone one day calls that and expects it to have
>some effect?

Probably but since I just made get_r_no_interrupt virtual 30 minutes
ago, it obviously wasn't a design goal previously.  :-)

Now that you mention it, though, this could be handled (correctly?) by
calling set_r_no_interrupt whenever we first create a socket iff
winsock2_active.  I think putting this in the fdsock function would
catch this.  This means that I didn't have to virtualize this method.
Agh.

I think this is a Corinna decision now.  Sorry.  I'm pretty tired and
not thinking too clearly.

I think we're narrowing it down, though.  :-)

cgf
