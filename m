Return-Path: <cygwin-patches-return-4365-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20840 invoked by alias); 14 Nov 2003 01:37:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20831 invoked from network); 14 Nov 2003 01:37:42 -0000
Date: Fri, 14 Nov 2003 01:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc (build_fh_pc): serial port handling
Message-ID: <20031114013739.GC2631@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311111612280.9584@eos> <Pine.GSO.4.56.0311111819230.9584@eos> <20031112092733.GB7542@cygbert.vinschen.de> <Pine.GSO.4.56.0311121307230.9584@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311121307230.9584@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00084.txt.bz2

On Wed, Nov 12, 2003 at 01:24:21PM -0600, Brian Ford wrote:
>2003-11-12  Brian Ford  <ford@vss.fsi.com>
>
>	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
>	serial ports.  Remove redundant FH_CYGDRIVE case since it is
>	handled by DEV_CYGDRIVE_MAJOR.
>
>FYI, this is the reason I am here:
>
>http://www.cygwin.com/ml/cygwin/2003-10/msg01750.html
>
>He offered to test my tcflush patch, but reported being unable to
>open /dev/ttyS0 with the cvs compiled Cygwin.

Reporting that this solved an actual bug would have been useful
information in the patch.  I was holding off approving this until
I had a chance to investigate and I'm extremely busy with real
work this week.

So, approved and applied.

Thanks.

cgf
