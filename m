Return-Path: <cygwin-patches-return-1544-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 32479 invoked by alias); 28 Nov 2001 00:54:18 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 32465 invoked from network); 28 Nov 2001 00:54:17 -0000
Date: Fri, 26 Oct 2001 07:50:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Message-ID: <20011128005414.GA7118@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com> <1006906033.2048.23.camel@lifelesswks> <20011128002122.GA6919@redhat.com> <1006907495.2048.25.camel@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006907495.2048.25.camel@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00076.txt.bz2

On Wed, Nov 28, 2001 at 11:31:35AM +1100, Robert Collins wrote:
>What was your point? That in C++ one should write all equality
>comparisons as foo == or foo != zerovaluedvariableofthesametype for
>clarity?

My point was that is the way I do it.  I obviously do it that way
because I think it is the best way to do things.

Although I disagree with using 0 when testing a pointer, I wouldn't
venture to dictate this style in setup.exe.

And, as always, I'm sorry that I ventured into a discussion about
coding style.  I'll try not to let that happen again, unless it
is to point out a clear violation of GNU coding standards.

cgf
