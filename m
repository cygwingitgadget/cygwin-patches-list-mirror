Return-Path: <cygwin-patches-return-4204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8121 invoked by alias); 11 Sep 2003 04:43:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8111 invoked from network); 11 Sep 2003 04:43:47 -0000
Date: Thu, 11 Sep 2003 15:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: setfragment patch for sound device
Message-ID: <20030911044341.GA13446@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030911042913.19539.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911042913.19539.qmail@linuxmail.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00222.txt.bz2

On Thu, Sep 11, 2003 at 12:29:12PM +0800, peter garrone wrote:
>
> The following patch to the /dev/dsp sound device does the following:
> 
> - implements SNDCTL_DSP_SETFRAGMENT, allowing smaller sound buffers to be used.
> - trivially implements SNDCTL_DSP_CHANNELS.
> - opens and closes the class device upon SNDCTL_DSP_RESET.
> - Uses win32 event to signal buffer output completion, instead of only a delay
> 
> I have only tested my own proprietary application. It compiled and ran without change, so,
> of course, has to be buggy.

Thanks for the patch, but AFAICT, you don't have an assignment on file,
so we can't include this in cygwin.  Check out
http://cygwin.com/contrib.html under the "Before you get started" section
for a link to the assignment form (aka http://cygwin.com/assign.txt).

cgf
