Return-Path: <cygwin-patches-return-3999-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26671 invoked by alias); 9 Jul 2003 10:10:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26651 invoked from network); 9 Jul 2003 10:09:59 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: start_time patch for fhandler_process.cc
Date: Wed, 09 Jul 2003 10:10:00 -0000
Message-ID: <ICEBIHGCEJIPLNMBNCMKOEIKCIAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20030709005048.GA18400@redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-SW-Source: 2003-q3/txt/msg00015.txt.bz2


> On Tue, Jul 08, 2003 at 07:09:12PM +0100, Chris January wrote:
> >Try this Chris and see if it solves the start time problem.
> >
> >Chris
> >
> >2003-07-28  Chris January  <kseitz@chris@atomice.net>
> >
> >	* fhandler_process.cc (format_process_stat): Changed the
> calculation for
> >start_time.
>
> Sorry, no.
>
> Unknown HZ value! (250) Assume 100.
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> cgf       3452  0.0  1.0  2544 2680 ?        R    Aug08   0:00 procps auwx
>
> Now that I've read the description of what the field is supposed to
> contain, I'm wondering if the culprit is the "Unknown HZ value! (250)
> Assume 100."
Maybe sysconf (_SC_NPROCESSORS_CONF) is reporting the wrong amount if the
problem is indeed you are running on an SMP machine.

Chris
