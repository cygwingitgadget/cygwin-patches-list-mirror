Return-Path: <cygwin-patches-return-1776-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18528 invoked by alias); 24 Jan 2002 23:13:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18493 invoked from network); 24 Jan 2002 23:13:36 -0000
Subject: Re: patch to allow newlib to compile when winsup not present
From: Robert Collins <robert.collins@itdomain.com.au>
To: Thomas Fitzsimmons <fitzsim@redhat.com>
Cc: cgf@redhat.com, newlib@sources.redhat.com, cygwin-patches@cygwin.com
In-Reply-To: <1011901690.1187.55.camel@toggle>
References: <1011834535.1278.46.camel@toggle>
	<02ce01c1a488$156d32b0$0200a8c0@lifelesswks>
	<1011892037.16026.53.camel@toggle>  <20020124174949.GA3123@redhat.com> 
	<1011901690.1187.55.camel@toggle>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Thu, 24 Jan 2002 15:13:00 -0000
Message-Id: <1011914014.18203.5.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 24 Jan 2002 23:13:35.0698 (UTC) FILETIME=[BFBBBB20:01C1A52C]
X-SW-Source: 2002-q1/txt/msg00133.txt.bz2

On Fri, 2002-01-25 at 06:48, Thomas Fitzsimmons wrote:
> On Thu, 2002-01-24 at 12:49, Christopher Faylor wrote:

> > What's wrong with saying that you need the winsup directory or a cygwin
> > installation to compile the cygwin versions of newlib?
> > 
> 
> That is a possibility, but even in that case, the build shouldn't fail
> with an obscure undefined symbol error at compile time.  If we're going
> to require either the winsup directory, or a cygwin installation, there
> should be checks for these at configuration time. However, usually,
> newlib doesn't handle header dependencies in this way.
> 
> newlib typically includes system-specific headers (like types.h) in the
> newlib distribution (like in newlib/libc/sys/cygwin/include).  Is there
> any reason why this can't be done for the cygwin target?

Why should a cygwin-specific header be in the _newlib_ distribution? 

Rob
