Return-Path: <cygwin-patches-return-3503-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8699 invoked by alias); 5 Feb 2003 16:52:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8669 invoked from network); 5 Feb 2003 16:52:33 -0000
Date: Wed, 05 Feb 2003 16:52:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
Message-ID: <20030205165231.GY5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030205114159.00800620@mail.attbi.com> <20030205164834.GE15400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205164834.GE15400@redhat.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00152.txt.bz2

On Wed, Feb 05, 2003 at 11:48:34AM -0500, Christopher Faylor wrote:
> Pierre or Corinna,
> Have either of you considered adding code to cygcheck to check for more
> common ntsec "problems"?  At the very least, something along the lines
> of "your username isn't in /etc/passwd" seems like it would be
> worthwhile.

Actually I would prefer that over this extra check, changing the
group name to "use mkpasswd".

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
