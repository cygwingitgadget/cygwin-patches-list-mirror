Return-Path: <cygwin-patches-return-2916-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31069 invoked by alias); 2 Sep 2002 16:12:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31051 invoked from network); 2 Sep 2002 16:12:30 -0000
Date: Mon, 02 Sep 2002 09:12:00 -0000
From: Joshua Daniel Franklin <joshua@iocc.com>
X-X-Originator: joshua@joshua.iocc.com
Reply-To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: very small passwd patch
Message-ID: <Pine.CYG.4.44.0209021109360.1260-100000@joshua.iocc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00364.txt.bz2

--- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> On Mon, Sep 02, 2002 at 08:28:07AM -0500, Joshua Daniel Franklin wrote:
> > I thought there was some mention of this already, but I guess
> > not. This adds a note about passwd not working with Win9x/ME.
>
> Good idea but it doesn't help.  Since passwd is linked statically
> against a symbol only available in NT, a 9x/Me user will never see
> this help.  The system dialog will always win the race.
>

True, but it would at least help with people who use NT on another machine
diagnose the problem. Right now it's completely hidden.
Also the --help notes are eventually folded into the User's Guide.
