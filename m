Return-Path: <cygwin-patches-return-4629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13005 invoked by alias); 24 Mar 2004 10:21:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12995 invoked from network); 24 Mar 2004 10:21:08 -0000
Date: Wed, 24 Mar 2004 10:21:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix to discard wave header properly
Message-ID: <20040324102108.GC17229@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C4112E.907FD100.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C4112E.907FD100.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00119.txt.bz2

On Mar 23 23:28, Gerd Spalink wrote:
> 2004-03-23  Gerd Spalink  <Gerd.Spalink@t-online.de>
> 
> 	* fhandler_dsp.cc (fhandler_dev_dsp::write): Remove type
> 	cast from argument to audio_out_->parsewav() to make reference
> 	work properly. Now .wav file headers are properly discarded.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
