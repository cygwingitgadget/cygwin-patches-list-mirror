Return-Path: <cygwin-patches-return-4886-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10267 invoked by alias); 2 Aug 2004 12:29:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10258 invoked from network); 2 Aug 2004 12:29:57 -0000
Date: Mon, 02 Aug 2004 12:29:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040802123005.GA32652@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040726213310.0080be30@incoming.verizon.net> <01C47174.AD674DB0.Gerd.Spalink@t-online.de> <3.0.5.32.20040726213310.0080be30@incoming.verizon.net> <3.0.5.32.20040731120347.00812dd0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040731120347.00812dd0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00038.txt.bz2

On Jul 31 12:03, Pierre A. Humblet wrote:
> At 10:22 AM 7/30/2004 +0200, Corinna Vinschen wrote:
> >Hi Guys,
> >
> >do we have any further news?
> 
> Barring news from Gerd, I will submit a proper patch.

Sounds good.  May I suggest to submit only a patch to solve the dup
problem in the first place, so fixing this annoyance for 1.5.11 and
only submit any more complex patch for the next Cygwin version?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
