Return-Path: <cygwin-patches-return-4679-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32170 invoked by alias); 13 Apr 2004 12:21:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32161 invoked from network); 13 Apr 2004 12:21:10 -0000
Date: Tue, 13 Apr 2004 12:21:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
Message-ID: <20040413122109.GC26558@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net> <20040410110343.GM26558@cygbert.vinschen.de> <3.0.5.32.20040412190645.00809e10@incoming.verizon.net> <3.0.5.32.20040412200933.0080b8f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040412200933.0080b8f0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00031.txt.bz2

On Apr 12 20:09, Pierre A. Humblet wrote:
> At 06:48 PM 4/12/2004 -0500, Brian Ford wrote:
> >On Mon, 12 Apr 2004, Pierre A. Humblet wrote:
> >
> >> I have also observed abnormal behavior on NT4.0
> >> 1) ls uses ntsec even on remote drives without smbntsec
> >>
> >> /> echo $CYGWIN
> >> bash: CYGWIN: unbound variable
> >
> >Ok, I'm confused.  Either I don't understand what you're saying, or
> >the following from the Cygwin User's Guide is too dificult to interpret
> >correctly?
> >
> >http://cygwin.com/cygwin-ug-net/using-cygwinenv.html:
> >
> >(no)smbntsec - if set, use ntsec on remote drives as well (this is the
> >default).
> 
> There is a third possibility: inaccurate documentation.
> 
> /eroot/src/winsup/cygwin: grep 'smbntsec.*=' *.cc
> /eroot/src/winsup/cygwin: grep 'ntsec.*=' *.cc
> environ.cc:    allow_ntsec = true;

Hmm, yes, the allow_smbntsec flag is not set by default and I have no
idea when that disappeared, actually.  Should we revert that or should
we better keep it as it is?  Somehow I have the vague feeling that we
have less complaints about Samba file access for a while...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
