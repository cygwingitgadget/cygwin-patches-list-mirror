Return-Path: <cygwin-patches-return-1901-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14935 invoked by alias); 25 Feb 2002 19:09:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14914 invoked from network); 25 Feb 2002 19:09:12 -0000
Date: Mon, 25 Feb 2002 13:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: help/version patches
Message-ID: <20020225190923.GA20128@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020225181506.62853.qmail@web20001.mail.yahoo.com> <20020225182351.GA12748@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225182351.GA12748@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00258.txt.bz2

On Mon, Feb 25, 2002 at 01:23:51PM -0500, Christopher Faylor wrote:
>Well, cygpath is wrong.  cygcheck is wrong too, under this scenario,
>but not quite as wrong since it at leasts puts the version in its own
>string.  I believe, it used to do something similar to cygpath but I
>changed it, intending to, someday, make it use cvs versions.

Sorry, I forgot to use the word "IMO" in the above.  Obviously there are
one of many ways to do this.  I think the "const char version[]" at the
top and cvs id in the version is the best.  However, I'm guilty of doing
it the "wrong" way myself.

cgf
