Return-Path: <cygwin-patches-return-4677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21605 invoked by alias); 13 Apr 2004 09:41:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21596 invoked from network); 13 Apr 2004 09:41:11 -0000
Date: Tue, 13 Apr 2004 09:41:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Patch for /dev/dsp to make ioctl SNDCTL_DSP_RESET respond immediately
Message-ID: <20040413094109.GA14895@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
References: <01C42018.B589D6F0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C42018.B589D6F0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00029.txt.bz2

On Apr 11 22:59, Gerd Spalink wrote:
> ChangeLog for winsup/cygwin:
> 
> 2004-04-11  Gerd Spalink  <Gerd.Spalink@t-online.de>
> 	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::stop): Add optional boolean
> 	argument so that playing can be stopped without playing pending buffers.
> 	(fhandler_dev_dsp::ioctl): Stop playback immediately for SNDCTL_DSP_RESET.
> 	Do not reset audio parameters in this case.
> 	Add support for ioctl SNDCTL_DSP_GETISPACE.
> 	(fhandler_dev_dsp::Audio_out::emptyblocks): Now returns the number of
> 	completely empty blocks.
> 	(fhandler_dev_dsp::Audio_out::buf_info): p->fragments is now the number of
> 	completely empty blocks. This conforms with the OSS specification.
> 	(fhandler_dev_dsp::Audio_out::parsewav): Ignore wave headers that are not
> 	aligned on four byte boundary.
> 	(fhandler_dev_dsp::Audio_in::buf_info): New, needed for SNDCTL_DSP_GETISPACE.
> 
> ChangeLog for winsup/testsuite:
> 
> 2004-04-11  Gerd Spalink  <Gerd.Spalink@t-online.de>
> 	* winsup.api/devdsp.c (forkrectest): Move synchronization with child
> 	so that test passes also under high CPU load.
> 	(forkplaytest): Ditto.
> 	(abortplaytest): New function to test ioctl code SNDCTL_DSP_RESET.

Appiled.  Just, for the next time, please make sure that the ChangeLog
fits into 80 columns.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
