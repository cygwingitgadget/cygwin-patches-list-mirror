Return-Path: <cygwin-patches-return-4393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2541 invoked by alias); 15 Nov 2003 04:43:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2532 invoked from network); 15 Nov 2003 04:43:51 -0000
Date: Sat, 15 Nov 2003 04:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: For masochists: the leap o faith
Message-ID: <20031115044347.GA29583@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4D81C.6010808@cygwin.com> <3FB53BAE.3000803@cygwin.com> <20031114220708.GA26100@redhat.com> <3FB55BCE.8030304@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB55BCE.8030304@cygwin.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00112.txt.bz2

On Sat, Nov 15, 2003 at 09:48:46AM +1100, Robert Collins wrote:
>Christopher Faylor wrote:
>>It is fairly unusual for PATH_MAX to be many times greater than what is
>>support by pathconf.
>
>And yet:
>http://www.opengroup.org/onlinepubs/007908799/xsh/fpathconf.html

Yes, I've already (obviously?) been to SUSv3.  I wasn't talking about
standards.  I was talking about common practice.

If you have a common practice web site that you want to show me then
that might be a convincing argument.  Otherwise, I'll have to fall back
on my personal UNIX experience.

I'm not vetoing the change because PATH_MAX is potentially large.  I was
kind of hoping (because I'm in incurable optimist) to start a discussion
with people who were familiar with packages that used PATH_MAX.  How
SUSv3 defines PATH_MAX is irrelevant to existing programs.

cgf
