Return-Path: <cygwin-patches-return-2642-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18719 invoked by alias); 12 Jul 2002 21:39:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18703 invoked from network); 12 Jul 2002 21:39:56 -0000
Date: Fri, 12 Jul 2002 14:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: Jacek Trzcinski <jacek@certum.pl>
Subject: Re: Assignment received from Jacek Trzcinski
Message-ID: <20020712214003.GA13155@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jacek Trzcinski <jacek@certum.pl>
References: <20020711170416.GA29920@redhat.com> <3D2E872F.476FBDEC@certum.pl> <20020712095524.E10982@cygbert.vinschen.de> <20020712144938.GA4972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020712144938.GA4972@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00090.txt.bz2

On Fri, Jul 12, 2002 at 10:49:38AM -0400, Christopher Faylor wrote:
>Make that "If it isn't, and it doesn't apply perfectly, we'll ask for
>it to be against current CVS source."  Your patch applied but there was
>some "fuzz" and, of course, neither Corinna or I know if this is fine
>or not since we aren't familiar with your patch.

Just to follow up on this -- the patch applied with fuzz but it didn't
actually build since the patch uses constructions in cygwin that have
been made obsolete in newer versions.

So, a new patch, against CVS, is a real requirement.

cgf
