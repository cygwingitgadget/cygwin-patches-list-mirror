Return-Path: <cygwin-patches-return-4727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9140 invoked by alias); 7 May 2004 07:55:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9129 invoked from network); 7 May 2004 07:55:05 -0000
Date: Fri, 07 May 2004 07:55:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Patch for /dev/dsp to make audio play interruptible by Ctrl-C
Message-ID: <20040507075505.GH2201@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
References: <01C433CF.C9723B10.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C433CF.C9723B10.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00079.txt.bz2

On May  7 01:08, Gerd Spalink wrote:
> ChangeLog:
> 
> 2004-05-07  Gerd Spalink  <Gerd.Spalink@t-online.de>
> 	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::stop):
> 	Move delete of bigwavebuffer_ so that it is always cleaned,
> 	also in child processes.
> 	(fhandler_dev_dsp::Audio_in::stop): ditto
> 	(fhandler_dev_dsp::close): Stop audio play immediately
> 	in case of abnormal exit.

Applied with changes in the ChangeLog entry.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
