Return-Path: <cygwin-patches-return-2738-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3311 invoked by alias); 27 Jul 2002 18:44:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3297 invoked from network); 27 Jul 2002 18:44:37 -0000
Date: Sat, 27 Jul 2002 11:44:00 -0000
From: David MacMahon <cygwin@smartsc.com>
To: cygwin-patches@cygwin.com
Subject: Re: time(time_t*) problem
Message-ID: <20020727115519.B1675@SmartSC.com>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020725160113.GG10541@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00186.txt.bz2

On Thu, Jul 25, 2002 at 12:01:13PM -0400, Christopher Faylor wrote:
> Thanks for the patch and for the rationalization of why it was
> necessary.  Until I read your message, I thought that cygwin was working
> correctly.  Now I can see that it obviously wasn't.

You're welcome.  I suppose the other patch to write would be for CVS's
configure(.in?) file to detect which version of cygwin is being used so
that an extra second can be added to the sleep time on earlier versions
of cygwin.  I'm not promising anything, but it could be a good exercise
for me to learn about autoconf (et al)...

> I also love patches that remove code and make cygwin faster, too.  :-)

Me, too!  Many such patches are (probably) possible, but the hard part is
figuring out which bits of code can be removed safely.

> The patch has been committed.

Great!  Looking back through times.cc's history, I see that this
behavior has been in there since this file was added to CVS.  Is there
any place to see the pre-CVS history of this file?

Dave

-- 
David MacMahon, President
Smart Software Consulting
http://www.smartsc.com
