Return-Path: <cygwin-patches-return-3078-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4558 invoked by alias); 22 Oct 2002 16:22:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4537 invoked from network); 22 Oct 2002 16:22:47 -0000
Date: Tue, 22 Oct 2002 09:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Avoiding /etc/passwd and /etc/group scans
Message-ID: <20021022162432.GF514@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DB416E7.99E22851@ieee.org> <20021021162246.GC15828@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021162246.GC15828@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00029.txt.bz2

On Mon, Oct 21, 2002 at 12:22:46PM -0400, Christopher Faylor wrote:
>Anyway, I'll take a look at your patch later today, Pierre.

I've checked this in.  If this solves the majority of the ntsec complaints,
I may even send you a medal.

If I had any idea that turning on ntsec by default would cause this much
pain, I don't think I would have considered it.

cgf
