Return-Path: <cygwin-patches-return-3137-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29454 invoked by alias); 7 Nov 2002 03:08:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29436 invoked from network); 7 Nov 2002 03:08:48 -0000
Date: Wed, 06 Nov 2002 19:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: utmp database manipulations patch
Message-ID: <20021107031049.GA31332@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ba01c285e4$620b2350$0201a8c0@sos> <20021107022144.GB6144@redhat.com> <00c501c28606$05629df0$0201a8c0@sos> <00ca01c28608$beb21f40$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ca01c28608$beb21f40$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00088.txt.bz2

On Wed, Nov 06, 2002 at 09:52:41PM -0500, Sergey Okhapkin wrote:
>Looks like it's better to define UT_IDLEN as 4 to be compatible with linux
>and solaris...

You can't do that easily, it would break binary compatibility.

cgf
