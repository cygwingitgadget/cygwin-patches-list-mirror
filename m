Return-Path: <cygwin-patches-return-3135-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12307 invoked by alias); 7 Nov 2002 02:53:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12296 invoked from network); 7 Nov 2002 02:53:49 -0000
Date: Wed, 06 Nov 2002 18:53:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: utmp database manipulations patch
Message-ID: <20021107025550.GA31304@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ba01c285e4$620b2350$0201a8c0@sos> <20021107022144.GB6144@redhat.com> <00c501c28606$05629df0$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c501c28606$05629df0$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00086.txt.bz2

On Wed, Nov 06, 2002 at 09:33:11PM -0500, Sergey Okhapkin wrote:
>Here are my proposed changes I'd like to include into utmp.h too. With these
>changes getutid() in syscalls.cc should be modified to use UT_IDLEN as 3rd
>parameter of strncmp().

Ok.  I've checked these changes in too.

Thanks.
cgf
