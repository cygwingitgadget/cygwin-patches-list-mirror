Return-Path: <cygwin-patches-return-4657-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5610 invoked by alias); 5 Apr 2004 08:31:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5583 invoked from network); 5 Apr 2004 08:31:06 -0000
Date: Mon, 05 Apr 2004 08:31:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: Again: Support for SNDCTL_DSP_CHANNELS ioctl
Message-ID: <20040405083102.GD26575@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <01C41AA5.8795BD40.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C41AA5.8795BD40.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00009.txt.bz2

On Apr  5 00:32, Gerd Spalink wrote:
> ChangeLog for winsup/cygwin:
> 
> 2004-04-04  Gerd Spalink  <Gerd.Spalink@t-online.de>
> 	* fhandler_dsp.cc (fhandler_dev_dsp::ioctl): Add implementation
> 	for ioctl codes SNDCTL_DSP_CHANNELS and SNDCTL_DSP_GETCAPS
> 
> ChangeLog for winsup/testsuite:
> 
> 2004-04-04  Gerd Spalink  <Gerd.Spalink@t-online.de>
> 	* winsup.api/devdsp.c (ioctltest): Add 2 tests for ioctl codes
> 	SNDCTL_DSP_CHANNELS and SNDCTL_DSP_GETCAPS

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
