Return-Path: <cygwin-patches-return-1777-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31792 invoked by alias); 25 Jan 2002 00:04:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31771 invoked from network); 25 Jan 2002 00:04:50 -0000
Subject: Re: patch to allow newlib to compile when winsup not present
From: Robert Collins <robert.collins@itdomain.com.au>
To: Thomas Fitzsimmons <fitzsim@redhat.com>
Cc: cgf@redhat.com, newlib@sources.redhat.com, cygwin-patches@cygwin.com
In-Reply-To: <1011914014.18203.5.camel@lifelesswks>
References: <1011834535.1278.46.camel@toggle>
	<02ce01c1a488$156d32b0$0200a8c0@lifelesswks>
	<1011892037.16026.53.camel@toggle>  <20020124174949.GA3123@redhat.com> 
	<1011901690.1187.55.camel@toggle>  <1011914014.18203.5.camel@lifelesswks>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Thu, 24 Jan 2002 16:04:00 -0000
Message-Id: <1011917087.18172.9.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jan 2002 00:04:48.0861 (UTC) FILETIME=[E77B30D0:01C1A533]
X-SW-Source: 2002-q1/txt/msg00134.txt.bz2

Further to this,

IMO emulation & platform specific headers should be in the
winsup dir. libc and libm headers should be in newlib.

The pthread typedef's are emulation specific, not newlib specific, and I
strongly oppose them being moved to newlib. The function definitions
(like pthread_kill) however, are common to any libc, and thus belong in
newlib (IMO).

As for finding a winsup header/local system header, I think that it's
the users job - if they want to build newlib for cygwin, WITHOUT winsup,
then they need to add the appropriate -I to the passed CFLAGS line,
(unless there's a standard location that cross-header are found, like
/usr/local/i686-pc-cygwin/include/ ?) (I'm not a cross-gcc afficiondo).

Rob


On Fri, 2002-01-25 at 10:13, Robert Collins wrote:
> On Fri, 2002-01-25 at 06:48, Thomas Fitzsimmons wrote:
> > On Thu, 2002-01-24 at 12:49, Christopher Faylor wrote:
> 
> > > What's wrong with saying that you need the winsup directory or a cygwin
> > > installation to compile the cygwin versions of newlib?
> > > 
> > 
> > That is a possibility, but even in that case, the build shouldn't fail
> > with an obscure undefined symbol error at compile time.  If we're going
> > to require either the winsup directory, or a cygwin installation, there
> > should be checks for these at configuration time. However, usually,
> > newlib doesn't handle header dependencies in this way.
> > 
> > newlib typically includes system-specific headers (like types.h) in the
> > newlib distribution (like in newlib/libc/sys/cygwin/include).  Is there
> > any reason why this can't be done for the cygwin target?
> 
> Why should a cygwin-specific header be in the _newlib_ distribution? 
> 
> Rob
> 

