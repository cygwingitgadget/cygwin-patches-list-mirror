Return-Path: <cygwin-patches-return-4564-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7778 invoked by alias); 7 Feb 2004 18:56:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7764 invoked from network); 7 Feb 2004 18:56:18 -0000
Date: Sat, 07 Feb 2004 18:56:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Final patch for audio recording with /dev/dsp
Message-ID: <20040207185614.GA17895@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C3EDB1.B19B11B0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C3EDB1.B19B11B0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00054.txt.bz2

On Sat, Feb 07, 2004 at 07:36:32PM +0100, Gerd Spalink wrote:
>Please find attached the refined patch to enable audio recording with /dev/dsp.
>
>It replaces the patch I posted on December 8, 2003
>
>Enhancements in comparison to what I previously posted:
>
>Late and rate-dependent audio buffer allocation.
>Fix of buffers not being Unprepared.
>Code that is easier to understand (I hope).
>
>I hope it will make it into the cygwin distribution some day.

What is the status of your assignment?  Regardless of the copyright law,
we do need something from your employer.  It should either indicat that
you are doing cygwin work in your spare time or that they have no claim
on the cygwin code you have developed.

cgf
