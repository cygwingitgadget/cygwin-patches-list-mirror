Return-Path: <cygwin-patches-return-4425-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9793 invoked by alias); 19 Nov 2003 11:24:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9784 invoked from network); 19 Nov 2003 11:24:17 -0000
Date: Wed, 19 Nov 2003 11:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc (build_fh_pc): serial port handling
Message-ID: <20031119112416.GA32288@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311111612280.9584@eos> <Pine.GSO.4.56.0311111819230.9584@eos> <20031112092733.GB7542@cygbert.vinschen.de> <Pine.GSO.4.56.0311121307230.9584@eos> <20031114013739.GC2631@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114013739.GC2631@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00144.txt.bz2

On Thu, Nov 13, 2003 at 08:37:39PM -0500, Christopher Faylor wrote:
> On Wed, Nov 12, 2003 at 01:24:21PM -0600, Brian Ford wrote:
> >2003-11-12  Brian Ford  <ford@vss.fsi.com>
> >
> >	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
> >	serial ports.  Remove redundant FH_CYGDRIVE case since it is
> >	handled by DEV_CYGDRIVE_MAJOR.
> >
> >FYI, this is the reason I am here:
> >
> >http://www.cygwin.com/ml/cygwin/2003-10/msg01750.html
> >
> >He offered to test my tcflush patch, but reported being unable to
> >open /dev/ttyS0 with the cvs compiled Cygwin.
> 
> Reporting that this solved an actual bug would have been useful
> information in the patch.  I was holding off approving this until
> I had a chance to investigate and I'm extremely busy with real
> work this week.
> 
> So, approved and applied.

Today I found out that you accidentally removed both cases, the
DEV_CYGDRIVE_MAJOR and the FH_CYGDRIVE case.  The effect is, that
/cygdrive is not recognized as directory anymore and `ls -l /mnt'
prints something like

  crw-rw-rw-    1 corinna  root      98,   0 Nov 19 12:23 /mnt

I checked in a patch which resurrects the DEV_CYGDRIVE_MAJOR case. 

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
