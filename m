Return-Path: <cygwin-patches-return-4536-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12137 invoked by alias); 23 Jan 2004 20:19:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12105 invoked from network); 23 Jan 2004 20:19:22 -0000
Message-ID: <01C3E1F6.8D472400.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: patch for audio recording with /dev/dsp
Date: Fri, 23 Jan 2004 20:19:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: SgJf-YZSYeC5xkS+rPs8Di5PCkX8qGwF2vYLZ8mzPaj-LLj6X+ODwq
X-SW-Source: 2004-q1/txt/msg00026.txt.bz2

Hi Corinna,

Yes, I'm on the cygwin-patches and cygwin-developers mailing lists (and I also peek into the cygwin mailing
list now and then at cygwin.com), so I read your message.

Regarding the copyright assignment, I haven't sent yet the part that my employer should sign,
but I'm working on it. My personal part should be at RedHat already.

Gerd

-----Original Message-----
From:	Corinna Vinschen [SMTP:cygwin-patches@cygwin.com]
Sent:	Freitag, 23. Januar 2004 11:12
To:	Gerd.Spalink@t-online.de
Cc:	cygwin-patches@cygwin.com
Subject:	Re: patch for audio recording with /dev/dsp

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
