Return-Path: <cygwin-patches-return-3149-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16315 invoked by alias); 10 Nov 2002 13:50:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16298 invoked from network); 10 Nov 2002 13:50:50 -0000
Date: Sun, 10 Nov 2002 05:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: SIOCGIFCONF patch
Message-ID: <20021110145045.F10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021110092533.D10395@cygbert.vinschen.de> <Pine.LNX.4.44.0211101338550.1572-200000@lupus.ago.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101338550.1572-200000@lupus.ago.vpn>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00100.txt.bz2

On Sun, Nov 10, 2002 at 01:40:52PM +0100, Alexander Gottwald wrote:
> Corinna Vinschen wrote:
> 
> > So, I actually would like
> > to ask you to take this part out.  As soon as you send the tweaked patch,
> > I'll check it in.
> 
> Done

Applied.  I've ran indent on net.cc since the indentation became somewhat
flaky (not only by your code :-)).  However, in future, please indent if's
like

  if ()
    {
      foo;
    }
  else
    {
      bar;
    }

and not like

  if () {
    foo;
  } else {
    bar;
  }

In the ChangeLog entries, each line should have one leading TAB, not
spaces.  Oh, and the ChangeLog entry for autoload.cc was missing.

Thanks for the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
