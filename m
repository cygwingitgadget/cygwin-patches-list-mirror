Return-Path: <cygwin-patches-return-4528-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29331 invoked by alias); 23 Jan 2004 10:11:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29319 invoked from network); 23 Jan 2004 10:11:53 -0000
Date: Fri, 23 Jan 2004 10:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: patch for audio recording with /dev/dsp
Message-ID: <20040123101152.GE12512@cygbert.vinschen.de>
Mail-Followup-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
	cygwin-patches@cygwin.com
References: <01C3BD3C.95EC61D0.Gerd.Spalink@t-online.de> <20031208053529.GA31384@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208053529.GA31384@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00018.txt.bz2

Hi Gerd,

I'm not sure if you read this.  Are you going to send us a copyright
assignment according to http://cygwin.com/contrib.html ?

Corinna

On Dec  8 00:35, Christopher Faylor wrote:
> On Mon, Dec 08, 2003 at 03:37:19AM +0100, Gerd Spalink wrote:
> >Hi,
> >
> >This patch changes the device /dev/dsp so that audio recording works.
> >I have tested it with
> >cp /dev/dsp test.wav         (stop by hitting ctrl-C)
> >and subsequent playback with
> >cp test.wav /dev/dsp
> >
> >I also tested successfully with bplay of the gramofile package
> >(with some hangups that I link to the terminal handling of this software).
> >
> >I am now considering implementing /dev/mixer ...
> >
> >Any suggestions?
> 
> Thanks for the patch but have you checked out http://cygwin.com/contrib.html ?
> AFAIK, we don't have an assignment on file with you so we can't
> incorporate any substantial patches from you into cygwin.
> 
> cgf

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
