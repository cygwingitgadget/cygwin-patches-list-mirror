Return-Path: <cygwin-patches-return-4484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15692 invoked by alias); 8 Dec 2003 05:35:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15672 invoked from network); 8 Dec 2003 05:35:29 -0000
Date: Mon, 08 Dec 2003 05:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for audio recording with /dev/dsp
Message-ID: <20031208053529.GA31384@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C3BD3C.95EC61D0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C3BD3C.95EC61D0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00203.txt.bz2

On Mon, Dec 08, 2003 at 03:37:19AM +0100, Gerd Spalink wrote:
>Hi,
>
>This patch changes the device /dev/dsp so that audio recording works.
>I have tested it with
>cp /dev/dsp test.wav         (stop by hitting ctrl-C)
>and subsequent playback with
>cp test.wav /dev/dsp
>
>I also tested successfully with bplay of the gramofile package
>(with some hangups that I link to the terminal handling of this software).
>
>I am now considering implementing /dev/mixer ...
>
>Any suggestions?

Thanks for the patch but have you checked out http://cygwin.com/contrib.html ?
AFAIK, we don't have an assignment on file with you so we can't
incorporate any substantial patches from you into cygwin.

cgf
